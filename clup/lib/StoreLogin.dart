//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'Edit.dart';
import 'Favorite.dart';
import 'Schedule.dart';
import 'QR.dart';

class StoreLogin extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(100, 107, 255, 245),
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
          builder: (context) => Edit(),
          )
        );
      }
      break;
      case 2: {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Favorite(),
        ));
      }
      break;
      case 3: {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Schedule(),
        ));
      }
      break;
      case 4: {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => QR(),
        ));
      }
      break;
     return null;
    }
  }

}