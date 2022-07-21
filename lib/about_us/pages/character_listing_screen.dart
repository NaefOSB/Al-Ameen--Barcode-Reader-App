import 'package:barcode_reader/about_us/styleguide.dart';
import 'package:barcode_reader/about_us/widgets/character_widget.dart';
import 'package:flutter/material.dart';
import 'package:barcode_reader/about_us/widgets/character_widget.dart';

import '../styleguide.dart';

class CharacterListingScreen extends StatefulWidget {
  @override
  _CharacterListingScreenState createState() => _CharacterListingScreenState();
}

class _CharacterListingScreenState extends State<CharacterListingScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.lightBlue.shade600,),onPressed: (){
            Navigator.pop(context);
          },),
          backgroundColor: Colors.transparent,
          elevation: 0,

        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 32.0, top: 8.0),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(text: "نوفل سوفت", style: TextStyle(
                          color: Colors.lightBlue.shade400,
                          fontFamily: 'ElMessiri',
                          fontSize: 28,
                          fontWeight: FontWeight.w600
                        ),),
                        TextSpan(text: "\n"),
                        TextSpan(text: "للبرمجيات", style: TextStyle(
                            color: Colors.lightBlue.shade400,
                            fontFamily: 'ElMessiri',
                            fontSize: 28,
                            fontWeight: FontWeight.w600
                        ),),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: CharacterWidget(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}