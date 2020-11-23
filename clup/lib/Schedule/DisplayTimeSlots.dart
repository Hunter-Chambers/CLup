import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'StoreScheduleController.dart';


class DisplayTimeSlots extends StatelessWidget{
  final _scrollController = ScrollController();
  List <String> timeSlots;
  int numPerRow;
  StoreScheduleController storeSchedule;
  DisplayTimeSlots({Key key, List<String> timeSlotSlice, StoreScheduleController scheduleController,}) 
      : this.timeSlots = timeSlotSlice, this.storeSchedule = scheduleController,  super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container (
            // Need height parameter to render correctly
            height: 50,
            width: 810,
            child: new ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: timeSlots.length, 
              itemBuilder: (BuildContext context, int index) => 
                  StatefulListTile(passSlots: timeSlots, passIndex: index, scheduleController: storeSchedule,),
              separatorBuilder: (BuildContext context, int index) 
                  => const Divider(height: 100, thickness: 1, color: Colors.black),
              )
      );
  }
}



 class StatefulListTile extends StatefulWidget {
   int index;
   List<String> timeSlots;
   StoreScheduleController storeSchedule;
   StatefulListTile({Key key, int passIndex, List<String> passSlots, StoreScheduleController scheduleController,}) 
      : this.index = passIndex, this.timeSlots = passSlots, this.storeSchedule = scheduleController, super(key: key);

   @override
   _StatefulListTileState createState() => _StatefulListTileState(passIndex: index, passSlots: timeSlots, scheduleController: storeSchedule,);
 }




 class _StatefulListTileState extends State<StatefulListTile> {
   int index;
   List<String> timeSlots;
   StoreScheduleController storeSchedule;
   _StatefulListTileState({int passIndex, List<String> passSlots, StoreScheduleController scheduleController,}) 
      : this.index = passIndex, this.timeSlots = passSlots, this.storeSchedule = scheduleController;
   bool _isSelected = false; 

   void updateSelection(){
     setState(() {_isSelected = !_isSelected;});
   }
   @override
   Widget build(BuildContext context) {
     String time = timeSlots[index];
     return Container (
              decoration: new BoxDecoration(
              border: Border.all(color: Colors.black)),
              // Need height and width parameter to render correctly
              height: 50,
              width: 200,
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
                   onTap: () => _onTapped(timeSlots[index]),
                 ),
     );
   }




  _onTapped(String timeSlot){
    updateSelection();
    String time = timeSlots[index];
    storeSchedule.updateSelectedTimes(index, time);
    Fluttertoast.showToast(
      msg: timeSlot + ' was selected.',
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      );
  }

  String _displayTime() {
    String time = timeSlots[index];
    if (storeSchedule.getAvailable(time)) {
      return time;
    }
    return 'Full';
  }

 }

