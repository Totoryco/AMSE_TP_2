import 'package:flutter/material.dart';


class Exo1 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black, 
        title: Center(child: Text("Exo 1")),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ), 
      ),
      body: Center(child: Image.network('https://picsum.photos/512/1024')),
    );
  }
}