import 'package:flutter/material.dart';
import 'constants.dart';

const kDefaultPaddin = 50.0;

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It provide us total height and width
    return Scaffold(
        body: SizedBox(
      height: 170,
      width: 170,
      child: Container(
          decoration: BoxDecoration(
        color: Color.fromRGBO(43, 43, 95, 1),
      )),
    ));
  }
}
