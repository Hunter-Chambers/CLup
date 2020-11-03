//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'Edit.dart';
import 'Favorite.dart';
import 'Schedule.dart';
import 'QR.dart';

class Login extends StatelessWidget{
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
                  'Login Page',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Customer Name Here\n' +
                  'Customer Email Here\n' + 
                  'Customer Phone Number Here\n',
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
                child: FloatingActionButton.extended(
                  heroTag: "EditBtn",
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
                child: FloatingActionButton.extended(
                  heroTag: "FavoriteBtn",
                  onPressed: () => _onButtonPressed(context, 2),
                  label: Text(
                    "Favorite a Store",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: FloatingActionButton.extended(
                  heroTag: "ScheduleBtn",
                  onPressed: () => _onButtonPressed(context, 3),
                  label: Text(
                    "Schedule a visit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: FloatingActionButton.extended(
                  heroTag: "QRBtn",
                  onPressed: () => _onButtonPressed(context, 4),
                  label: Text(
                    "QR Code",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
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