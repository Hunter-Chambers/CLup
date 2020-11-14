import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';

class QR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => QRState();
}

class QRState extends State<QR> {
  GlobalKey globalKey = new GlobalKey();

  var qrDataArray = [
    "QR Code 1;Store 1",
    "QR Code 2;Store 2",
    "QR Code 3;Store 3"
  ];
  var qrIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is the QR page"),
      ),
      body: _contentWidget(),
    );
  }

  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
    final RegExp regex = new RegExp(r".+(?=;)");
    //print(regex.firstMatch(qrDataArray[1]).group(0));
    return Container(
      color: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 20,
              right: 10,
              bottom: 20,
            ),
          ),
          DropdownButton(
            value: regex.stringMatch(qrDataArray[qrIndex]),
            //icon
            onChanged: (String newValue) {
              setState(() {
                qrIndex =
                    int.parse(newValue.substring(newValue.length - 1)) - 1;
              });
            }, // onChanged
            items: qrDataArray.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: regex.stringMatch(value),
                child: Text(regex.stringMatch(value)),
              );
            }).toList(), // items
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                key: globalKey,
                child: QrImage(
                  data: qrDataArray[qrIndex].split(";")[1],
                  size: 0.5 * bodyHeight,
                  errorStateBuilder: (context, err) {
                    return Container(
                      child: Center(
                        child: Text("An error occured."),
                      ),
                    );
                  }, // errorStateBuilder
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
