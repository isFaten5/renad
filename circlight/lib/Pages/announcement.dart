import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Announcement extends StatefulWidget {
  const Announcement({super.key});

  @override
  State<Announcement> createState() => _Announcement();
}

class _Announcement extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Announcement')),
    );
  }
}
