import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class DisplayTimeSlots extends StatelessWidget{
  final _scrollController = ScrollController();
  List <String> timeSlots;
  int numPerRow;
  DisplayTimeSlots({Key key, List<String> timeSlotSlice}) 
      : this.timeSlots = timeSlotSlice, super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container (
            // Need height parameter to render correctly
            height: 50,
            child: new ListView.separated(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: timeSlots.length, 
              itemBuilder: (BuildContext context, int index) => StatefulListTile(passSlots: timeSlots, passIndex: index),
              separatorBuilder: (BuildContext context, int index) 
                  => const Divider(height: 100, thickness: 1, color: Colors.black),
              )
      );
  }
}



 class StatefulListTile extends StatefulWidget {
   int index;
   List<String> timeSlots;
   StatefulListTile({Key key, int passIndex, List<String> passSlots}) 
      : this.index = passIndex, this.timeSlots = passSlots, super(key: key);

   @override
   _StatefulListTileState createState() => _StatefulListTileState(passIndex: index, passSlots: timeSlots);
 }




 class _StatefulListTileState extends State<StatefulListTile> {
   int index;
   List<String> timeSlots;
   _StatefulListTileState({int passIndex, List<String> passSlots}) : this.index = passIndex, this.timeSlots = passSlots;
   bool _isSelected = false; 

   void updateSelection(){
     setState(() {_isSelected = !_isSelected;});
   }
   @override
   Widget build(BuildContext context) {
     return Container (
              alignment: Alignment.center,
              decoration: new BoxDecoration(
              border: Border.all(color: Colors.black)),
              // Need height and width parameter to render correctly
              height: 50,
              width: 200,
              child: 
               ListTile(
                   hoverColor: Colors.lightBlueAccent,
                   selectedTileColor: Colors.grey,
                   //tileColor: Colors.lightBlueAccent,
                   selected: _isSelected,
                   title: Text(
                     timeSlots[index],
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
    Fluttertoast.showToast(
      msg: timeSlot + ' was selected.',
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_SHORT,
      );
  }

 }

