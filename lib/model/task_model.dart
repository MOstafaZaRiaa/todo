import 'dart:ui';


class TaskModel {
  int? id;
  String? title, time, date, status;

  TaskModel({
    this.title,
    this.id,
    this.time,
    this.date,
    this.status,
  });
  TaskModel.fromJson(Map<dynamic,dynamic>?map){
    if(map == null){
      return;
    }
    title=map['title'];
    id=map['id'];
    time=map['time'];
    date=map['date'];
    status=map['status'];
  }
  toJson(){
   return{
     'title':title,
     'time':time,
     'date':date,
     'status':status,
   };
  }
}
