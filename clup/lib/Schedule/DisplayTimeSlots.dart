import 'package:flutter/material.dart';
import 'StoreScheduleController.dart';
import 'package:clup/CustomerProfile/CustomerProfileController.dart';


class DisplayTimeSlots extends StatefulWidget{
  final StoreScheduleController storeSchedule;
  final CustomerProfileController customerProfile;
  DisplayTimeSlots({Key key, StoreScheduleController scheduleController, CustomerProfileController customerController})
      : this.storeSchedule = scheduleController, customerProfile = customerController,  super(key: key);

  @override _DisplayTimeSlotsState createState() =>
    _DisplayTimeSlotsState(scheduleController: storeSchedule,
                           customerController: customerProfile);

}
class _DisplayTimeSlotsState extends State<DisplayTimeSlots> {
  StoreScheduleController storeSchedule;
  CustomerProfileController customerProfile;
  final _scrollController = ScrollController();
  //Color _color;

  _DisplayTimeSlotsState ({StoreScheduleController scheduleController,
                            CustomerProfileController customerController}) :
                            storeSchedule = scheduleController,
                            customerProfile = customerController;

  @override
  Widget build(BuildContext context) {
    //_scrollController.addIListener(() { })

    return Container (
            decoration: new BoxDecoration(
              border: Border.all(color: Colors.black),
              //color: Colors.white,//_color,
            ),
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
                  StatefulListTile(passIndex: index, scheduleController: storeSchedule, customerController: customerProfile,),
            )
    );
  }
}



 class StatefulListTile extends StatefulWidget {
   final int index;
   final StoreScheduleController storeSchedule;
   final CustomerProfileController customerProfile;
   StatefulListTile({Key key, int passIndex, StoreScheduleController scheduleController, CustomerProfileController customerController}) 
      : this.index = passIndex, this.storeSchedule = scheduleController, customerProfile = customerController, super(key: key);

   @override
   _StatefulListTileState createState() => _StatefulListTileState(passIndex: index, scheduleController: storeSchedule, customerController: customerProfile);
 }




 class _StatefulListTileState extends State<StatefulListTile> {
   int index;
   StoreScheduleController storeSchedule;
   CustomerProfileController customerProfile;
   _StatefulListTileState({int passIndex, StoreScheduleController scheduleController, CustomerProfileController customerController}) 
      : this.index = passIndex, this.storeSchedule = scheduleController, customerProfile = customerController;
   bool _isSelected; 
   Color _color;

   @override
  void initState() {
    if ( storeSchedule.selectedTimes[index] != null){
      _isSelected = true;

    }
    else {
      _isSelected = false;

    }
    super.initState();
  }
  void _updateSelection(bool timesUpdated){
     setState(() {
       if (timesUpdated) {
        _isSelected = !_isSelected;
       } 
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
                   hoverColor: Color.fromARGB(100, 107, 255, 245),
                   enabled: storeSchedule.getAvailable(time),
                   tileColor: _setColor(),
                   selected: _isSelected,
                   title: 
                   Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                      Text(
                       _displayTime(),
                       style: TextStyle( 
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         fontSize: 16,
                       ),
                       textAlign: TextAlign.center,
                      ),
                      Text(
                       _displayReserved(),
                       style: TextStyle( 
                         color: Colors.black,
                         fontWeight: FontWeight.bold,
                         fontSize: 10,
                       ),
                       textAlign: TextAlign.center,
                      ),

                     ]
                     
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
    int numReserved = int.parse(storeSchedule.reserved[time]);
    int partySize = int.parse(customerProfile.getTextController("party_size").text);
    bool room = numReserved + partySize <= 60; 
    bool timesUpdated = storeSchedule.updateSelectedTimes(index, time, room);
    _updateSelection(timesUpdated);

  }


  String _displayTime() {
    String time = storeSchedule.timeSlots[index];
    if (storeSchedule.getAvailable(time)) {
      return time;
    }
    return 'Full';
  }

  String _displayReserved() {
    String time = storeSchedule.timeSlots[index];
    String reserved = storeSchedule.reserved[time];
    int numReserved = int.parse(reserved);

    if ( numReserved < storeSchedule.limit ) {
      int numRemaining = storeSchedule.limit - numReserved;
      String output = "Spots remaining: " + numRemaining.toString();
      return output;
    }
    return '';

  }


 }

