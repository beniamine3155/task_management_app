import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:task_management_app/app/core/utils/extension.dart';
import 'package:task_management_app/app/modules/details/widgets/doing_list.dart';
import 'package:task_management_app/app/modules/details/widgets/done_list.dart';
import 'package:task_management_app/app/modules/home/home_controller.dart';

class DetailPage extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var task = homeCtrl.task.value!;
    var color = HexColor.fromHex(task.color);

    return Scaffold(
      body: Form(
        key: homeCtrl.fromKey,
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(2.0.wp),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Get.back();
                        homeCtrl.updateTodos();
                        homeCtrl.changeTask(null);
                        homeCtrl.editCtrl.clear();
                      },
                      icon: const Icon(Icons.arrow_back))
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
              child: Row(
                children: [
                  Icon(
                    IconData(task.icon, fontFamily: 'MaterialIcons'),
                    color: color,
                  ),
                  SizedBox(
                    width: 1.0.wp,
                  ),
                  Text(
                    task.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                  )
                ],
              ),
            ),
            Obx(() {
              var totalTodos =
                  homeCtrl.doingTodos.length + homeCtrl.doneTodos.length;
              return Padding(
                padding: EdgeInsets.only(
                  left: 6.0.wp,
                  right: 6.0.sp,
                  top: 2.0.wp,
                ),
                child: Row(
                  children: [
                    Text(
                      '$totalTodos Tasks',
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(
                      width: 2.0.wp,
                    ),
                    Expanded(
                      child: StepProgressIndicator(
                        totalSteps: totalTodos == 0 ? 1 : totalTodos,
                        currentStep: homeCtrl.doneTodos.length,
                        size: 5,
                        padding: 0,
                        selectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [color.withOpacity(0.5), color],
                        ),
                        unselectedGradientColor: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.topRight,
                          colors: [Colors.grey[300]!, Colors.grey[300]!],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 1.0.wp, horizontal: 3.0.wp),
              child: TextFormField(
                controller: homeCtrl.editCtrl,
                autofocus: true,
                decoration: InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey[400]!),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey[400],
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      if (homeCtrl.fromKey.currentState!.validate()) {
                        var success = homeCtrl.addTodo(homeCtrl.editCtrl.text);
                        if (success) {
                          EasyLoading.showSuccess('Todo item add success');
                        } else {
                          EasyLoading.showError('Todo item already exist');
                        }
                        homeCtrl.editCtrl.clear();
                      }
                    },
                    icon: Icon(
                      Icons.done,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your todo item';
                  }
                  return null;
                },
              ),
            ),
            DoingList(),
            DoneList(),
          ],
        ),
      ),
    );
  }
}
