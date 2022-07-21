import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:barcode_reader/helpers/product.dart';
import 'package:flutter/painting.dart';


class ProductScreen extends StatefulWidget {

  Product product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(

      backgroundColor: Color(0xFFE0E0E0),
      body: ListView(
        children: [


          Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            constraints: BoxConstraints(
              maxWidth: size.width,
              maxHeight: size.width,
            ),

            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10),topLeft:Radius.circular(10),topRight: Radius.circular(10) ),
              color: Colors.white,
              image: new DecorationImage(
                image: new AssetImage("assets/images/AmeenIcon.png",),
                fit: BoxFit.fill,
              )
            ),
            margin: EdgeInsets.only(left: 10,right: 10,),

            height: 200,
            width: 100,
          ),





          Padding(padding: EdgeInsets.only(top: 10),),

          Details(title:'أسم المنتج' , content: '${widget.product.Name}',),
          Details(title:'المجموعة' , content:'${widget.product.Group_Name}'),
          Details(title:'العملة' ,   content:'${widget.product.Currency}'),

          if(widget.product.Price1 != null && widget.product.Unity != null)
              Details(title:'${widget.product.Unity}', content: '${widget.product.Price1.round()}' , color: 1),


          if(widget.product.Price2 != 0.0 && widget.product.Unit2 != '')
            getCountable(title: '${widget.product.Unit2}',qountity:widget.product.Unit2Fact,content: '${widget.product.Price2}',color: 2),

          if(widget.product.Price3 != 0.0 && widget.product.Unit3 != '')
            getCountable(title: '${widget.product.Unit3}',qountity:widget.product.Unit3Fact,content: '${widget.product.Price3}',color: 3),

          Padding(padding: EdgeInsets.only(top: 10),),


        ],
      ),

    );
  }

  Widget Details({String title, String content,  color=0  ,countable = false,qountity}) {

    return Container(
      padding: EdgeInsets.all(9),
      margin:  EdgeInsets.symmetric(vertical: 5,horizontal: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: (color == widget.product.SearchedKind)?Color(0xFF03A9F4):Colors.white,
      ),
      child: ListTile(
        title: Text(content , style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            fontFamily: 'ElMessiri',
            color: Colors.blueGrey
        ),),

        // for title
        trailing: Text('$title',textDirection: TextDirection.rtl, style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          fontFamily: 'ElMessiri',
          color: Colors.deepPurple,

        ),),




      ),

    );

  }

  Widget getCountable({title,content,qountity , color=0}){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
      margin:  EdgeInsets.symmetric(vertical: 5,horizontal: 10),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: (color == widget.product.SearchedKind)?Color(0xFF03A9F4):Colors.white,

      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${double.parse(content).round()}' , style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                  color: Colors.blueGrey
              ),),
              Text('${getQuantityWithoutDots(qountity)}',style: TextStyle(
              // Text('$qountity',style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ElMessiri',
                  // color: Colors.blueGrey,
                  color: Color(0xFF5C6BC0),

                )),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('$title',textDirection: TextDirection.rtl, style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
                color: Colors.deepPurple,

              ),),
              Text('يحتوي على',textDirection: TextDirection.rtl,style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                fontFamily: 'ElMessiri',
                color: Colors.deepPurple,

              ),),
            ],
          ),
        ],
      ),
    );
  }

  getQuantityWithoutDots(number){
    var regex = RegExp(r"([.]*0)(?!.*\d)");

    String finalQuantityResult = number.toString().replaceAll(regex, "");

    return finalQuantityResult;

  }


}
