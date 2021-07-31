import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:todo/core/database/tasks_database_helper.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/screens/archive_screen.dart';
import 'package:todo/screens/done_screen.dart';
import 'package:todo/screens/tasks_screen.dart';

class HomeScreenViewModel extends GetxController {
  ValueNotifier<bool> _isLoading = ValueNotifier(false);
  ValueNotifier<bool> get isLoading => _isLoading;

  ValueNotifier<bool> _isBottomSheetOpen = ValueNotifier(false);
  ValueNotifier<bool> get isBottomSheetOpen => _isBottomSheetOpen;

  List<TaskModel> _allTasks = [];
  List<TaskModel> get allTasks => _allTasks;

  List<TaskModel> _newTasks = [];
  List<TaskModel> get newTasks => _newTasks;

  List<TaskModel> _doneTasks = [];
  List<TaskModel> get doneTasks => _doneTasks;

  List<TaskModel> _archiveTasks = [];
  List<TaskModel> get archiveTasks => _archiveTasks;

  var dbHelper = TasksDatabaseHelper.db;

  int currentIndex = 0;
  Icon _floatingBottomIcon = Icon(Icons.add);

  Icon get floatingBottomIcon => _floatingBottomIcon;

  List<String> _titles = [
    'tasks ',
    'Done ',
    'Archive ',
  ];
  List get titles => _titles;

  List<Widget> _screens = [
    TasksScreen(),
    DoneScreen(),
    ArchiveScreen(),
  ];
  List get screens => _screens;

  HomeScreenViewModel() {
    getAllProduct();
  }

  changeScreen(int index) {
    currentIndex = index;
    update();
  }

  changeBottomSheetStatus() {
    print('_isBottomSheetOpen before change $_isBottomSheetOpen');
    _isBottomSheetOpen.value = !_isBottomSheetOpen.value;
    print('_isBottomSheetOpen after change $_isBottomSheetOpen');
    _floatingBottomIcon =
        _isBottomSheetOpen.value ? Icon(Icons.edit) : Icon(Icons.add);
    update();
  }

  getAllProduct() async {
    _newTasks = [];
    _doneTasks = [];
    _archiveTasks = [];
    _isLoading.value = true;
    _allTasks = await dbHelper.getAllTasks();
    _allTasks.forEach((element) {
      if(element.status == 'new'){
        _newTasks.add(element);
      }else if(element.status == 'done'){
        _doneTasks.add(element);
      }else{
        _archiveTasks.add(element);
      }
    });
    _isLoading.value = false;
    update();
  }

  addTask({required TaskModel taskModel, required BuildContext context}) async {
    await dbHelper.insert(taskModel);
    _newTasks.add(taskModel);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added to cart.'),
      ),
    );
    update();
  }

  updateTask(TaskModel model) async {
    await dbHelper.updateTask(model);
    getAllProduct();
    update();
  }

  deleteProduct(TaskModel taskModel, BuildContext context) async {
    await dbHelper.deleteTask(taskModel);
    _newTasks.remove(taskModel);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted.'),
      ),
    );
    getAllProduct();
    update();
  }
}