import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'CustomerLogin.dart';
import 'package:clup/LoadingScreen/LoadingScreen.dart';

class QR extends StatefulWidget {
  final CustomerProfileController customerProfile;
  QR({Key key, this.customerProfile}) : super(key: key);

  @override
  _QRState createState() => _QRState(customerProfile: customerProfile);
}

class _QRState extends State<QR> {
  final CustomerProfileController customerProfile;
  _QRState({this.customerProfile});

  List<String> data;
  List<String> dropDownItems = [];
  String dropDownValue = "";
  int qrIndex = 0;

  // updates the class variables appropriately
  // when the page is first loaded
  @override
  void initState() {
    super.initState();

    _loadVisits().then((data) {
      setState(() {
        this.data = data;

        _loadData();
      });
    });

    // adding a visit for testing
    /*
    customerProfile.addvisit('7:30AM - 8:30AM;' +
        customerProfile.getTextController("username").text +
        ';' +
        customerProfile.getTextController("email").text +
        ';Walmart;1701 N 23rd St;Canyon;TX;79015');
        */

    // fill dropDownItems correctly
    
  }



  @override
  Widget build(BuildContext context) {

    if( data == null ) {
      return LoadingScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("This is the QR page"),
      ),
      body: _contentWidget(),
    );
  }

  Future _loadVisits() async{
    await customerProfile.getVisits();
    return this.data = customerProfile.visits;
  }
  _loadData() {
    if (!customerProfile.visits.isEmpty) {
      for (String visit in customerProfile.visits) {
        List<String> info = visit.split(';');
        dropDownItems.add(
            info[5] + " - " + info[6] + "\n" + info[7] + "\n on " + info[8]);
      }

      // correctly initialize dropDownValue
      dropDownValue = dropDownItems[qrIndex];
    } else {
      dropDownItems = [];
      dropDownValue = null;
    }

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
          DropdownButton<String>(
              itemHeight: 75,
              value: dropDownValue,
              //icon
              onChanged: (String newValue) {
                setState(() {
                  dropDownValue = newValue;
                  qrIndex = dropDownItems.indexOf(newValue);
                });
              }, // onChanged
              /*
            items: dropDownItems.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(), // items
            */
              items:
                  dropDownItems?.map<DropdownMenuItem<String>>((dynamic value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value),
                        );
                      })?.toList() ??
                      []),
          Center(
            child: RepaintBoundary(
              child: Padding(
                padding: EdgeInsets.only(top: 50, bottom: 50),
                child: _generateQR(bodyHeight),
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

  Widget _generateQR(double bodyHeight) {
    if (dropDownItems.isEmpty) {
      return Text("No Scheduled Visits");
    }

    return QrImage(
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
