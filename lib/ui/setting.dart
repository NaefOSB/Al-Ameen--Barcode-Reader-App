import 'dart:convert';
import 'package:barcode_reader/helpers/ExpandedListAnimationWidget.dart';
import 'package:barcode_reader/helpers/currency.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Setting extends StatefulWidget {
  List<Currency> currencies;
  var selectedCurrencyGuid;
  Setting({this.currencies,this.selectedCurrencyGuid});



  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<Currency> currencies;

  var selectedCurrencyGuid;

  bool isStrechedDropDown = false;
  int groupValue = 0;
  String currencyName = 'الرجاء إختيار عملة';

  bool _isLoading = false;


  @override
  void initState() {
    currencies = widget.currencies;
    selectedCurrencyGuid = widget.selectedCurrencyGuid;

    getSelectedCurrencyGroupAndName();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child:ModalProgressHUD (
        inAsyncCall: _isLoading,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.lightBlue.shade500,
            title: Text('إعدادات التطبيق',style: TextStyle(
              fontWeight: FontWeight.bold,
            ),),
            centerTitle: true,

            actions: [
              IconButton(
                onPressed: ()=>refearsh(),
                icon: Icon(Icons.refresh),
              ),
            ],
          ),

          body: Center(
            child:  Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/6),
              padding: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: ListView(
                children: [

                  GestureDetector(
                    onTap: (){

                      setState(() {
                        isStrechedDropDown =
                        !isStrechedDropDown;

                      });

                    },
                    child: Container(


                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Container(
                                      // padding: EdgeInsets.symmetric(vertical: 20),////////
                                      decoration: BoxDecoration(

                                        // border: Border.all(color: Color(0xffbbbbbb)),
                                        border: Border.all(color: Colors.lightBlue.shade300),
                                        borderRadius: BorderRadius.all(Radius.circular(27))
                                        // borderRadius: BorderRadius.all(Radius.circular(5)),
                                      ),
                                      child: Column(
                                        children: [
                                          Container(
                                            // height: 45,
                                              width: double.infinity,
                                              // padding: EdgeInsets.only(right: 10),
                                              padding: EdgeInsets.symmetric(vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                    // color: Color(0xffbbbbbb),
                                                    color: Colors.lightBlue.shade300,
                                                  ),

                                                  borderRadius:
                                                  BorderRadius.all(Radius.circular(25))),
                                                  // BorderRadius.all(Radius.circular(3))),
                                              constraints: BoxConstraints(
                                                minHeight: 45,
                                                minWidth: double.infinity,
                                              ),
                                              alignment: Alignment.center,
                                              child: Directionality(
                                                textDirection: TextDirection.rtl,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(
                                                            horizontal: 20, vertical: 10),
                                                        child: Center(
                                                          child: Text(
                                                            currencyName,style: TextStyle(
                                                              // color: Colors.grey[700]
                                                              color: Colors.lightBlue.shade500,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 16
                                                          ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:10),
                                                      child: Icon(isStrechedDropDown
                                                          ? Icons.arrow_upward
                                                          : Icons.arrow_downward,
                                                          color: Colors.lightBlue.shade500,
                                                          // color: Colors.black54,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              )),
                                          Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: ExpandedSection(
                                              expand: isStrechedDropDown,
                                              height: 100,
                                              child: ListView.builder(

                                                // itemCount: widget.currencies.length,
                                                itemCount: currencies.length,
                                                padding: EdgeInsets.all(0),
                                                // controller: scrollController2,
                                                shrinkWrap: true,
                                                itemBuilder: (BuildContext context, int index){
                                                  return RadioListTile(

                                                      // title: Text('${widget.currencies[index].Name}'),
                                                      title: Text('${currencies[index].Name}'),
                                                      value: index,

                                                      groupValue: groupValue,
                                                      onChanged: (val) {
                                                        setState(() {

                                                          // selectedCurrencyGuid = widget.currencies[index].GUID;
                                                          selectedCurrencyGuid = currencies[index].GUID;
                                                          groupValue = val;

                                                          // currencyName = widget.currencies[index].Name;
                                                          currencyName = currencies[index].Name;


                                                          isStrechedDropDown =
                                                          !isStrechedDropDown;
                                                        });
                                                      });
                                                },

                                              ),

                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height/5.5,),

                  InkWell(
                    onTap: () => initializeConnection(),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightBlue.shade500,
                      ),

                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Text('إنشاء الإتصال',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () =>updateSelectedCurrency(),
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.lightBlue.shade500,
                      ),

                      padding: EdgeInsets.symmetric(vertical: 20),
                      alignment: Alignment.center,
                      child: Text('تثبيت العملة',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  initializeConnection() async{

    try{

      // for create db of selected Currency
      setState(() =>_isLoading=true);

      String path = 'http://192.168.2.10:8900/api/material';
      http.Response response = await http.post(path);
      setState(() =>_isLoading=false);
      if(response.body == '"Success"'){
        message(title: 'إتصال ناجح',content: 'تم إنشاء الأتصال بنجاح !!');
      }else {
        message(title: 'الإتصال مفعل مسبقاً',content: 'الإتصال موجود مسبقاً الرجاء عدم تكرار هذه العملية مرة أخرى !!');
      }

    }catch(e){
      setState(() =>_isLoading=false);
    }


  }


  getSelectedCurrencyGroupAndName(){
    // for(int i = 0; i<widget.currencies.length; i++){
    for(int i = 0; i<currencies.length; i++){
      // var currency = widget.currencies[i];
      var currency = currencies[i];
      // if('"${currency.GUID.toString()}"' == widget.selectedCurrencyGuid){
      if('"${currency.GUID.toString()}"' == selectedCurrencyGuid){
        groupValue = i;
        currencyName = currency.Name;
        // selectedCurrencyGuid = widget.selectedCurrencyGuid;
        selectedCurrencyGuid = selectedCurrencyGuid;
        setState(() {
        });
      }
    }
  }

  updateSelectedCurrency() async{
    try{

      setState(() =>_isLoading=true);
      String path = 'http://192.168.2.10:8900/api/material?selectedGuid=$selectedCurrencyGuid';
      http.Response response = await http.post(path);

      setState(() =>_isLoading=false);
      if(response.body == '"Success"'){
        message(title: 'عملية تثبيت العملة',content: 'تم تثبيت العملة بنجاح !!');
      }else {
        message(title: 'حدثَ خطأ',content: 'حدثَ خطأ اثنا الأتصال بقاعدة البيانات\n الرجاء التأكد من عملية أنشاء الأتصال');
      }

    }catch(e){
      setState(() =>_isLoading=false);
    }


  }

  message({title,content}){
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text('$title'),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text('$content'),
                ],
              ),
            ),
            actions: [
              FlatButton(
                  onPressed:(){
                    Navigator.pop(context);
                  }, child: Text('موافق'))
            ],
          ),
        );
      }
    );
  }

  // for refearch

  getCurrencies() async{
    String path = 'http://192.168.2.10:8900/api/material';
    http.Response response = await http.get(path);
    if(response.statusCode == 200){

      List<dynamic> body = jsonDecode(response.body);
      // List<Currency> Currencies = body
      currencies = body
          .map(
            (dynamic item) => Currency.fromJson(item),
      ).toList();
      setState(() {

      });
    }
  }

  getSelectedCurrencyGuid() async{
    String path = 'http://192.168.2.10:8900/api/material?x=5';
    http.Response response = await http.get(path);
    if(response.body != '"not found"' && response.statusCode == 200){
      setState(() {
        selectedCurrencyGuid = response.body.toString();
      });

    }
  }

  refearsh() async{

    try{
      setState(() =>_isLoading=true);
      await getCurrencies();
      await getSelectedCurrencyGuid();

      getSelectedCurrencyGroupAndName();
      setState(() =>_isLoading=false);
    }catch(e){
      setState(() =>_isLoading=false);
    }


  }


}
