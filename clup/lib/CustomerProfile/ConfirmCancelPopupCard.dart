import 'dart:ui';

import 'package:clup/CustomerProfile/CustomerProfileController.dart';
import 'package:flutter/material.dart';
import 'CancelVisit.dart';
import 'package:clup/CustomerProfile/CustomerLogin.dart';
import 'package:clup/Services/Services.dart';

class ConfirmCancelPopupCard extends StatefulWidget{

  final String visit;
  final CustomerProfileController customerProfile;
  ConfirmCancelPopupCard({String visit, CustomerProfileController customerController})
    : this.visit = visit, customerProfile = customerController;

  @override
  _ConfirmCancelPopupCardState createState() => 
    _ConfirmCancelPopupCardState(visit : visit, customerController: customerProfile);
}

class _ConfirmCancelPopupCardState extends State<ConfirmCancelPopupCard> with SingleTickerProviderStateMixin {
  String visit = '';
  CustomerProfileController customerProfile;
  _ConfirmCancelPopupCardState({String visit, CustomerProfileController customerController })
    : this.visit = visit, customerProfile = customerController;

  Widget build(BuildContext context) {
    return Center(
      child: 
      Container(
        color: Colors.white,
        height: 200,
        width: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Cancel Visit: ' + _formatVisit(visit),
              style: TextStyle(
                decoration: TextDecoration.underline,
                decorationColor: Colors.black,
                fontSize: 20,
                color: Colors.black,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                FloatingActionButton.extended(
                  label: Text('Yes'),
                  heroTag: 'confirmYes',
                  onPressed: () => _onPressed(1)),
                FloatingActionButton.extended(
                  label: Text('No'),
                  heroTag: 'confirmNo',
                  onPressed: () => _onPressed(2))

              ],
            ),
                      ],
        ),
      ),

    );

  }

  _onPressed(int option) async {
    switch (option) {

      case 1: {

        await Services.cancelVisit(visit);


        Navigator.pop(context);

        return Services.showAlertMessage("Visit Successfully Canceled",
            "Your visit for: " + _formatVisit(visit) + " was canceled!", context);
        /*
        return 
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CustomerLogin(customerController: customerProfile,)
            ));
        */

      }
      break;
      case 2: {
        Navigator.pop(context);
        /*
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CancelVisit(customerProfile: customerProfile,)
            ));
        */

      }
      break;
    }
  }

String _formatVisit(String visit) {
  
  print(visit);
  List<String> info = visit.split(';');
  print(info);
  return  info[5] + " - " + info[6] + "\n" + info[7] + "\n on " + info[8];
}
  
}