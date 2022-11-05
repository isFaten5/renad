import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequeststState();
}

class _RequeststState extends State<Requests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Requests')),
    );
  }
}
