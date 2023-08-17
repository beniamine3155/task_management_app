import 'package:get/get.dart';
import 'package:task_management_app/app/data/providers/api_provider.dart';
import 'package:task_management_app/app/data/services/repository.dart';
import 'package:task_management_app/app/modules/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
