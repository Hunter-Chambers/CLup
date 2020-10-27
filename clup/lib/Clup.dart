import 'package:flutter/material.dart';
import 'Login.dart';
import 'Signup.dart';

class Clup extends StatelessWidget {
  final List<int> screens = [2, 3];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(title: Text("Home Page")),
          body: ListView.builder(
            itemCount: this.screens.length,
            itemBuilder: (context, index ) {
              return ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Text(this.screens[index].toString()),
                onTap: () => _onScreenTap(context, screens[index]),
                  );
                },
            )
          );
     }

/*
  Widget _section(String title) {
    return Container(
       child: Text(title),
       );
  }
*/

  _onScreenTap(BuildContext context, int screenNum){
    
    switch(screenNum) {
      case 2: {
        return Navigator.push(context, MaterialPageRoute(
          builder: (context) => Login(),
          )
        );
      }
      break;
      case 3: {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Signup(),
          )
        );
      }
      break;
      }
    }

}
