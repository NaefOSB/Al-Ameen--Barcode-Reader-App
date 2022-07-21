import 'dart:async';
import 'package:barcode_reader/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'قارئ المنتجات',
      theme: ThemeData(
          fontFamily: 'ElMessiri',
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: SplashScreen(),

    ),
  );

  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 2), (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>HomePage()));
    });
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;
    return Scaffold(


        // backgroundColor: Colors.blue.shade500,

        body: Center(
          child: Container(
            // height:MediaQuery.of(context).size.height / 3,
            color: Colors.lightBlue.shade500,
            child: Stack(
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/الأمين_أبيض.png',
                    // height: 140,
                    height: MediaQuery.of(context).size.height / 4.5,
                    color: Colors.white,

                  ),
                ),
                Padding(
                  // padding: const EdgeInsets.only(top: 175),
                  padding:  EdgeInsets.only(top:(size / 3.5)-20),
                  child: Container(
                    margin: EdgeInsets.only(top: 0),
                    child: Center(
                      child: Text(
                        'Powered By Novel Soft',
                        style: TextStyle(
                            fontFamily: 'ElMessiri',
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            // color: Color(0xFF363636)
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),


    );



  }
}
