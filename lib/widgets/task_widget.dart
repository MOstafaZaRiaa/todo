import 'package:flutter/material.dart';
import 'package:todo/model/task_model.dart';
class TaskWidget extends StatelessWidget {
  const TaskWidget({
    required this.controller,
    required this.tasks,
  });
  final  controller;
  final tasks;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) => Dismissible(
          key: Key(tasks[index].id.toString()),
          // direction: DismissDirection.horizontal,
          onDismissed: (direction){
            controller.deleteProduct(tasks[index],context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  child: Text('${tasks[index].time}'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*.33,
                      child: Text(
                        '${tasks[index].title}',
                        // softWrap: true,
                        overflow: TextOverflow.visible,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Text(
                      '${tasks[index].date}',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () async {
                      controller.updateTask(TaskModel(
                        id: tasks[index].id,
                        time: tasks[index].time,
                        title: tasks[index].title,
                        date: tasks[index].date,
                        status: 'done',
                      ));
                    },
                    icon: Icon(Icons.check_circle,color: Colors.green,)),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                    onPressed: () async {
                      controller.updateTask(TaskModel(
                        id: tasks[index].id,
                        time: tasks[index].time,
                        title: tasks[index].title,
                        date: tasks[index].date,
                        status: 'archive',
                      ));
                    },
                    icon: Icon(Icons.archive_rounded,)),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Divider(),
        itemCount: tasks.length,
      );
  }
}