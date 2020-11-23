import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'StoreScheduleController.dart';


class DisplayTimeSlots extends StatelessWidget{
  final _scrollController = ScrollController();
  StoreScheduleController storeSchedule;
  DisplayTimeSlots({Key key, StoreScheduleController scheduleController,}) 
      : this.storeSchedule = scheduleController,  super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container (
            // Need height parameter to render correctly
            height: 550,
            width: 900,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 4,
                ),
              controller: _scrollController,
              itemCount: storeSchedule.timeSlots.length,
              itemBuilder: (BuildContext context, int index) => 
                  StatefulListTile(passIndex: index, scheduleController: storeSchedule,),
            )
    );
  }
}



 class StatefulListTile extends StatefulWidget {
   int index;
   StoreScheduleController storeSchedule;
   StatefulListTile({Key key, int passIndex, StoreScheduleController scheduleController,}) 
      : this.index = passIndex, this.storeSchedule = scheduleController, super(key: key);

   @override
   _StatefulListTileState createState() => _StatefulListTileState(passIndex: index, scheduleController: storeSchedule,);
 }




 class _StatefulListTileState extends State<StatefulListTile> {
   int index;
   StoreScheduleController storeSchedule;
   _StatefulListTileState({int passIndex, StoreScheduleController scheduleController,}) 
      : this.index = passIndex, this.storeSchedule = scheduleController;
   bool _isSelected = false; 

   void updateSelection(){
     setState(() {_isSelected = !_isSelected;});
   }
   @override
   Widget build(BuildContext context) {
     String time = storeSchedule.timeSlots[index];
     return Container (
              decoration: new BoxDecoration(
              border: Border.all(color: Colors.black)),
              child: 
               ListTile(
                   //hoverColor: Colors.lightBlueAccent,
                   selectedTileColor: Colors.grey,
                   enabled: storeSchedule.getAvailable(time),
                   tileColor: Colors.white,
                   selected: _isSelected,
                   title: Text(
                     _displayTime(),
                     style: TextStyle( 
                       color: Colors.black,
                       fontWeight: FontWeight.bold,
                       fontSize: 16,
                     ),
                     textAlign: TextAlign.center,
                     ),
                   onTap: () => _onTapped(time),
                 ),
     );
   }




  _onTapped(String time){
    updateSelection();
    storeSchedule.updateSelectedTimes(index, time);
    Fluttertoast.showToast(
      msg: time + ' was selected.',
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      );
  }


  String _displayTime() {
    String time = storeSchedule.timeSlots[index];
    if (storeSchedule.getAvailable(time)) {
      return time;
    }
    return 'Full';
  }

 }

