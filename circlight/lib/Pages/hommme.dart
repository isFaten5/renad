import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final onItemPressed;

  MyHomePage({
    Key? key,
    this.onItemPressed,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20, // Your Height
                  width: 20, // Your width
                  child: IconButton(
                    // Your drawer Icon
                    onPressed: () => Null,
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ]
              // Your widgets here

              ),
        ));
  }
}
