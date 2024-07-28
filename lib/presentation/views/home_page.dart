import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/core/constants/app_strings.dart';

import '../../controllers/todo_controller.dart' as tc;
import '../organism/todo/todo_tab.dart' as tt;

class HomePage extends StatelessWidget {
  final tc.TodoController controller = Get.put(tc.TodoController());

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              onChanged: (value) {
                controller.searchQuery.value = value;
              },
              hintText: 'Search Todos',
              leading: const Icon(Icons.search),
            ),
          ),
        ),
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                const TabBar(
                  tabs: [
                    Tab(text: AppStrings.notCompletedTodos),
                    Tab(text: AppStrings.completedTodos),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      Obx(() =>
                          tt.TodoTab(todos: controller.incompleteTodos)),
                      Obx(() =>
                          tt.TodoTab(todos: controller.completedTodos)),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTodoDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTodoDialog(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController todoController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(AppStrings.addPageTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration:
                  const InputDecoration(hintText: AppStrings.title),
            ),
            TextField(
              controller: todoController,
              decoration:
                  const InputDecoration(hintText: AppStrings.todoAdd),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  todoController.text.isNotEmpty) {
                try {
                  await controller.addTodo(
                    titleController.text,
                    todoController.text,
                  );
                  Navigator.pop(context);
                  Get.snackbar(
                    AppStrings.success,
                    AppStrings.addSuccesDesc,
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.check_circle),
                  );
                } catch (e) {
                  print('Failed to add todo: $e');
                  Get.snackbar(
                    AppStrings.error,
                    "${AppStrings.addErrorDesc} ${e.toString()}",
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.error),
                  );
                }
              } else {
                Get.snackbar(
                  AppStrings.error,
                  "Başlık ve açıklama boş olamaz",
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error),
                );
              }
            },
            child: const Text(AppStrings.add),
          ),
        ],
      ),
    );
  }
}
