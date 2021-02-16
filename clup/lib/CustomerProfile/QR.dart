import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'CustomerLogin.dart';

class QR extends StatefulWidget {
  final CustomerProfileController customerProfile;
  QR({Key key, this.customerProfile}) : super(key: key);

  @override
  _QRState createState() => _QRState(customerProfile: customerProfile);
}

class _QRState extends State<QR> {
  final CustomerProfileController customerProfile;
  _QRState({this.customerProfile});

  final List<String> dropDownItems = [];
  String dropDownValue = "";
  int qrIndex = 0;

  // updates the class variables appropriately
  // when the page is first loaded
  @override
  void initState() {
    super.initState();

    // adding a visit for testing
    /*
    customerProfile.addvisit('7:30AM - 8:30AM;' +
        customerProfile.getTextController("username").text +
        ';' +
        customerProfile.getTextController("email").text +
        ';Walmart;1701 N 23rd St;Canyon;TX;79015');
        */

    // fill dropDownItems correctly
    for (String visit in customerProfile.visits) {
      List<String> info = visit.split(';');
      dropDownItems.add(info[0] + "\n" + info[3]);
    }

    // correctly initialize dropDownValue
    dropDownValue = dropDownItems[qrIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("This is the QR page"),
      ),
      body: _contentWidget(),
    );
  }

  // holds everything in the page
  _contentWidget() {
    final bodyHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).viewInsets.bottom;
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
            itemHeight: 75,
            value: dropDownValue,
            //icon
            onChanged: (String newValue) {
              setState(() {
                dropDownValue = newValue;
                qrIndex = dropDownItems.indexOf(newValue);
              });
            }, // onChanged
            items: dropDownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(), // items
          ),
          Expanded(
            child: Center(
              child: RepaintBoundary(
                child: QrImage(
                  key: Key('QRcode'),
                  data: customerProfile.visits[qrIndex],
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
          ),
          FloatingActionButton.extended(
            heroTag: 'RetLogBtn',
            onPressed: () => _onButtonPressed(context),
            label: Text(
              "To Profile Page",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }

  _onButtonPressed(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CustomerLogin(customerController: customerProfile),
        ));
  }
}
