import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:todo/core/view_model/home_screen_view_model.dart';

import 'package:intl/intl.dart';
import 'package:todo/model/task_model.dart';


class MyHomePage extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var timeController = TextEditingController();
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenViewModel>(
      init: HomeScreenViewModel(),
      builder: (controller) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text(
            controller.titles[controller.currentIndex],
          ),
        ),
        body: controller.screens[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex,
          onTap: (index) {
            controller.changeScreen(index);
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu),
              label: 'Tasks',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check_circle_outline),
              label: 'Done',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.archive_outlined),
              label: 'Archive',
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: controller.floatingBottomIcon,
          onPressed: () async {
            if (controller.isBottomSheetOpen.value) {
              formKey.currentState!.save();
              if (formKey.currentState!.validate()) {
                controller
                    .addTask(
                  taskModel: TaskModel(
                    time: timeController.text,
                    title: titleController.text,
                    date: dateController.text,
                    status: 'new',
                  ),
                  context: context,
                )
                    .then(
                  (value) {
                    Navigator.pop(context);
                  },
                );
              }
            } else {
              controller.changeBottomSheetStatus();
              scaffoldKey.currentState!
                  .showBottomSheet(
                    (context) => Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 1.0), //(x,y)
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: Form(
                        key: formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: titleController,
                                  decoration: InputDecoration(
                                    labelText: 'task title',
                                    prefixIcon: Icon(Icons.title),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  onSaved: (value) {
                                    titleController.text = value!;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: timeController,
                                  decoration: InputDecoration(
                                    labelText: 'task time',
                                    prefixIcon:
                                        Icon(Icons.watch_later_outlined),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  onTap: () async {
                                    var picked = await showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: dateController,
                                  decoration: InputDecoration(
                                    labelText: 'task time',
                                    prefixIcon: Icon(Icons.calendar_today),
                                    border: new OutlineInputBorder(
                                      borderRadius:
                                          new BorderRadius.circular(5.0),
                                      borderSide: new BorderSide(),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                    return null;
                                  },
                                  onTap: () async {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2022, 1, 1),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .closed
                  .then(
                (value) {
                  controller.changeBottomSheetStatus();
                },
              );
            }
            //await insertToDatabase();
          },
        ),
      ),
    );
  }
}
