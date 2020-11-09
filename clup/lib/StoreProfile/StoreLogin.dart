//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'StoreEdit.dart';
import 'ScanQR.dart';

class StoreLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
      appBar: AppBar(title: Text("To Previous Page")),
      body: Center(
        child: Container(
          color: Colors.white,
          height: 500,
          width: 700,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 40),
                child: Text(
                  'Store Login Page',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Store Name Here\n' +
                  'Store Hours Here\n' + 
                  'Store Capacity Here\n',
                )
              ),
              Container(
                alignment: Alignment.center,
                child: Divider(
                  thickness: 3,
                  indent: 30,
                  endIndent: 30,
                )
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "S_EditBtn",
                  onPressed: () => _onButtonPressed(context, 1),
                  label: Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(150, 30, 150, 0),
                child: FloatingActionButton.extended(
                  heroTag: "S_QRBtn",
                  onPressed: () => _onButtonPressed(context, 2),
                  label: Text(
                    "Scan QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    )
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
  _onButtonPressed(BuildContext context, int option){
  
     switch(option){
        case 1: {
          return Navigator.push(context, MaterialPageRoute(
            builder: (context) => StoreEdit(),
            )
          );
        }
        break;
        case 2: {
          return Navigator.push(context, MaterialPageRoute(
            builder: (context) => ScanQR(),
            )
          );
        }
        break;
    }
  }


}