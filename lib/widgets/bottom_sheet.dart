// import 'package:flutter/material.dart';
//
// import 'package:persian_datetime_picker/persian_datetime_picker.dart';
//
// class AddBottomSheet extends StatelessWidget {
//   AddBottomSheet({
//     required this.formKey,
//   });
//
//   final GlobalKey formKey;
//
//   var timeController = TextEditingController();
//   var titleController = TextEditingController();
//   var dateController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey,
//             offset: Offset(0.0, 1.0), //(x,y)
//             blurRadius: 6.0,
//           ),
//         ],
//       ),
//       child: Form(
//         key: formKey,
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 TextFormField(
//                   controller: titleController,
//                   decoration: InputDecoration(
//                     labelText: 'task title',
//                     prefixIcon: Icon(Icons.title),
//                     border: new OutlineInputBorder(
//                       borderRadius: new BorderRadius.circular(5.0),
//                       borderSide: new BorderSide(),
//                     ),
//                   ),
//                   validator: (value){
//                     if(value!.isEmpty){
//                       return 'title must not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: timeController,
//                   decoration: InputDecoration(
//                     labelText: 'task time',
//                     prefixIcon: Icon(Icons.watch_later_outlined),
//                     border: new OutlineInputBorder(
//                       borderRadius: new BorderRadius.circular(5.0),
//                       borderSide: new BorderSide(),
//                     ),
//                   ),
//                   onTap: () async {
//                     var picked = await showTimePicker(
//                       context: context,
//                       initialTime: TimeOfDay.now(),
//                     ).then((value) {
//                       timeController.text = value!.format(context).toString();
//                     });
//                   },
//                   validator: (value){
//                     if(value!.isEmpty){
//                       return 'time must not be empty';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 TextFormField(
//                   controller: dateController,
//                   decoration: InputDecoration(
//                     labelText: 'task time',
//                     prefixIcon: Icon(Icons.calendar_today),
//                     border: new OutlineInputBorder(
//                       borderRadius: new BorderRadius.circular(5.0),
//                       borderSide: new BorderSide(),
//                     ),
//                   ),
//                   validator: (value){
//                     if(value!.isEmpty){
//                       return 'date must not be empty';
//                     }
//                     return null;
//                   },
//                   onTap: () async {
//                     Jalali? picked = await showPersianDatePicker(
//                       context: context,
//                       initialDate: Jalali.now(),
//                       firstDate: Jalali.now(),
//                       lastDate: Jalali.fromDateTime(DateTime.parse('2021-12-30'),),
//                     ).then((value) {
//                       dateController.text = value!.formatCompactDate();
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
