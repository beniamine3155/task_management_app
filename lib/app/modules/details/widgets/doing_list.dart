import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/core/utils/extension.dart';
import 'package:task_management_app/app/modules/home/home_controller.dart';

class DoingList extends StatelessWidget {
  final homeCtrl = Get.find<HomeController>();
  DoingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => homeCtrl.doingTodos.isEmpty && homeCtrl.doneTodos.isEmpty
        ? Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/images/clipboard.png',
                fit: BoxFit.cover,
                width: 30.0.wp,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                'Add Task',
                style:
                    TextStyle(fontSize: 16.0.sp, fontWeight: FontWeight.bold),
              )
            ],
          )
        : ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              ...homeCtrl.doingTodos
                  .map(
                    (element) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 2.0.wp, horizontal: 4.3.wp),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Checkbox(
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.grey),
                              value: element['done'],
                              onChanged: (value) {
                                homeCtrl.doneTodo(element['title']);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2.0.wp),
                            child: Text(
                              element['title'],
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                  .toList(),
              if (homeCtrl.doingTodos.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                  child: const Divider(
                    thickness: 2,
                  ),
                )
            ],
          ));
  }
}
