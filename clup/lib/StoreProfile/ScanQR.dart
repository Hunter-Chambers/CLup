import 'package:flutter/material.dart';

class ScanQR extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("This is the Scan QR page")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Text("EDITABLE TEXT FORM GOES HERE"),
          )
        ],
      )
    );
  }
}