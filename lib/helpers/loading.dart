import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE0E0E0),
      child: Center(
        child: SpinKitWave(
          color: Colors.lightBlue.shade500,
          size: 50,
        ),
      ),
    );
  }
}
