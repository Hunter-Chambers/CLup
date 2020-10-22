import 'package:flutter/material.dart';

class Third extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is the third page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text("You made it to the third page!")
          )
        ],
      )
    );
  }
}