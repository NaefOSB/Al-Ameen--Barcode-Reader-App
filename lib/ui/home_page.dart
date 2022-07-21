import 'dart:convert';
import 'dart:io';
import 'package:barcode_reader/helpers/currency.dart';
import 'package:barcode_reader/helpers/loading.dart';
import 'package:barcode_reader/helpers/product.dart';
import 'package:barcode_reader/ui/setting.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:barcode_reader/ui/product_screen.dart';
import 'package:http/http.dart' as http;
import 'package:barcode_reader/about_us/pages/character_listing_screen.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;
  TextEditingController _settingController = new TextEditingController();
  final snack = new GlobalKey<ScaffoldState>();

  // for Currencies
  List<Currency> Currencies = [];
  var selectedCurrencyGuid;


  _scan() async {
    try {
      // For reading from barcode
      String result = await FlutterBarcodeScanner.scanBarcode(
          '#000000', 'رجوع', true, ScanMode.BARCODE);


      if (result.isNotEmpty && result != '-1') {
        setState(() => _isLoading = true);
        String path = 'http://192.168.2.10:8900/api/material?barcode=$result';
        http.Response res = await http.get(path);


        if (res.statusCode == 200 && res.body ==
            'null') { //for if the connection is okay but doesn't found the barcode
          barcodeNotification('الباركود غير موجود',
              'الباركود المدخل غير موجود لدينا الرجاء إدخال باركود لمنتج موجود لدينا');
        } else {
          switch (res.statusCode) {
            case 200:
              {
                setState(() => _isLoading = false);
                Product product = Product.fromJson(jsonDecode(res.body));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductScreen(product)));
                break;
              }
            case 500: //for if the product doesn't exist in DB
              {
                barcodeNotification('الباركود غير موجود',
                    'الباركود المدخل غير موجود لدينا الرجاء إدخال باركود لمنتج موجود لدينا');
                break;
              }
            default:
              {
                barcodeNotification('تنبية حصل خطأ',
                    'حدث خطأ في القراءه الرجاء المحاولة مرة اخرى');
                break;
              }
          }
        }
      }
    } on SocketException {
      barcodeNotification('خطأ في الشبكة',
          'حصل خطأ متعلق بالشبكة الرجاء التأكد من اتصالك بالشبكة لقراءة المنتجات ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoading) ? Loading() : Scaffold(
      backgroundColor: Colors.white,
      key: snack,
      appBar: AppBar(
        toolbarHeight: 70,

        title: Text(
          'قارئ المنتجات',
          style: TextStyle(
              fontFamily: 'ElMessiri',
              color: Colors.lightBlue.shade500,
              fontWeight: FontWeight.bold
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.info_outline, color: Colors.lightBlue.shade500,),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => CharacterListingScreen()));
          },),

        // backgroundColor: Colors.blue.shade500,
        backgroundColor: Colors.white,
        actions: [
          IconButton(
              icon: Icon(Icons.settings, color: Colors.lightBlue.shade500,),
              onPressed: () {
                showCurrency();
                getCurrencies();
                getSelectedCurrencyGuid();
              }),


        ],
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              child: BarcodeWidget(
                data: 'Barcode',
                barcode: Barcode.qrCode(),
                width: 300,
                color: Colors.lightBlue.shade500,
              ),
              onTap: () => _scan(),
            ),
            Text(
              'أضغط للفحص',
              style: TextStyle(
                  fontFamily: 'ElMessiri',
                  color: Colors.lightBlue.shade500,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),

    );
  }

  barcodeNotification(titel, content) {
    setState(() => _isLoading = false);
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(
              titel,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(
                    content,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'ElMessiri',
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  _scan();
                },
                child: Text(
                  'محاولة مره أخرى',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'إلغاء',
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ElMessiri',
                  ),
                ),
              ),
            ],
          );
        });
  }


  showCurrency() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text(
                "التحقق من الهوية",
                textDirection: TextDirection.rtl,
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      "الرجاء إدخال كلمة المرور للدخول إلى واجهة الأعدادات : ",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextField(
                      controller: _settingController,
                      textAlign: TextAlign.right,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'اكتب كلمة المرور',
                          labelText: 'كلمة المرور',
                          icon: Icon(Icons.lock_open)),
                    ),
                  ],
                ),
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("إلغاء", textDirection: TextDirection.rtl)),
                FlatButton(
                  onPressed: () {
                    if (_settingController.text == '@novel-barcode150@') {
                      _settingController.clear();
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(
                          builder: (context) =>
                              Setting(currencies: Currencies,
                                  selectedCurrencyGuid: selectedCurrencyGuid)));
                      // settingsConfirmation();
                    }
                    else {
                      _settingController.clear();
                      Navigator.pop(context);
                      _wrongPassword();
                    }
                  },
                  child: Text(
                    "موافق",
                    textDirection: TextDirection.rtl,
                  ),
                ),

              ],
            ),
          );
        });
  }

  _wrongPassword() {
    snack.currentState.showSnackBar(

        SnackBar(
          content: Center(
            heightFactor: 1.5,
            child: Text('كلمة المرور خاطئة الرجاء عدم العبث مره اخرى',
              textDirection: TextDirection.rtl, style: TextStyle(
                fontFamily: 'ElMessiri',
              ),),
          ),

          duration: Duration(
            seconds: 2,
          ),


        )
    );
  }


//   for Currencies

  getCurrencies() async {
    try {
      String path = 'http://192.168.2.10:8900/api/material';
      http.Response response = await http.get(path);
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        // List<Currency> Currencies = body
        Currencies = body
            .map(
              (dynamic item) => Currency.fromJson(item),
        ).toList();
      }
    } catch (e) {

    }
  }

  getSelectedCurrencyGuid() async {
    try {
      String path = 'http://192.168.2.10:8900/api/material?x=5';
      http.Response response = await http.get(path);
      if (response.body != '"not found"' && response.statusCode == 200) {
        selectedCurrencyGuid = response.body.toString();
      }
    } catch (e) {

    }
  }


}
