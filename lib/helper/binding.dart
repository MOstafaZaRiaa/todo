import 'package:get/get.dart';

import 'package:todo/core/view_model/home_screen_view_model.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenViewModel(),);

  }

}