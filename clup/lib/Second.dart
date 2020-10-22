import 'package:flutter/material.dart';

class Second extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is the second page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text("You made it to the second page!")
          )
        ],
      )
    );
  }
}