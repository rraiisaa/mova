import 'package:get/get.dart';
import 'package:mova_app/controllers/my_list_controller.dart';

class MyListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyListController>(() => MyListController());
  }
}
