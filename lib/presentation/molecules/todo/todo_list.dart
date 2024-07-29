// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

import 'package:todo_app/presentation/atoms/todo/todo_item.dart';

class TodoList extends StatelessWidget {

  const TodoList({super.key, required this.todos});
  final List<TodoItem> todos;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) => todos[index],
    );
  }
}
