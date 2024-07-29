// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/core/constants/app_strings.dart';

import 'package:todo_app/data/models/todo_model.dart';
import 'package:todo_app/presentation/atoms/todo/todo_item.dart';

class TodoTab extends StatelessWidget {

  const TodoTab({super.key, required this.todos});
  final List<TodoModel> todos;

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? const Center(
            child: Text(
              AppStrings.notTodoYet,
              style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),
            ),
          )
        : ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) => TodoItem(
              todo: todos[index],
              onTap: () =>
                  Get.find<TodoController>().toggleTodo(todos[index]),
            ),
          );
  }
}
