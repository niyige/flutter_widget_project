import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  @override
  createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "首页",
          style: TextStyle(fontSize: 15, color: Colors.black),
        ),
      ),
      body: ListView(
        children: [],
      ),
    );
  }
}
