import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(backgroundColor: Colors.white, title: Text('Chat')),
        body: Center(
          child: Text('Chat Screen', style: TextStyle(fontSize: 40)),
          // Center
        ));
  }
}
