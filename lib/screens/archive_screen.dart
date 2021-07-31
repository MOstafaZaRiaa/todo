import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:todo/core/view_model/home_screen_view_model.dart';
import 'package:todo/model/task_model.dart';
import 'package:todo/widgets/task_widget.dart';

class ArchiveScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenViewModel>(
      init: HomeScreenViewModel(),
      builder: (controller) => controller.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : controller.archiveTasks.length == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu),
                      Text('No Tasks Yet,Please Add Some Tasks.')
                    ],
                  ),
                )
              : TaskWidget(
                  controller: controller,tasks: controller.archiveTasks,
                ),
    );
  }
}
