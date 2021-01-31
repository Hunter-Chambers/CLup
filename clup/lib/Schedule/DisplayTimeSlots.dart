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
   Color _color;

   void _updateSelection(bool timesUpdated){
     setState(() {
       if (timesUpdated) _isSelected = !_isSelected;
       });
   }
   @override
   Widget build(BuildContext context) {
     String time = storeSchedule.timeSlots[index];
     return Container (
              decoration: new BoxDecoration(
              border: Border.all(color: Colors.black)),
              child: 
               ListTile(
                   key: Key('timeTile'),
                   selectedTileColor: Colors.blue,
                   hoverColor: Colors.purple,
                   enabled: storeSchedule.getAvailable(time),
                   tileColor: _setColor(),
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



  Color _setColor() {
    String time = storeSchedule.timeSlots[index];
    if (!storeSchedule.getAvailable(time)){
      _color =  Colors.grey;
    }
    return _color;
  }

  
  _onTapped(String time){
    bool timesUpdated = storeSchedule.updateSelectedTimes(index, time);
    _updateSelection(timesUpdated);
  }


  String _displayTime() {
    String time = storeSchedule.timeSlots[index];
    if (storeSchedule.getAvailable(time)) {
      return time;
    }
    return 'Full';
  }

 }

