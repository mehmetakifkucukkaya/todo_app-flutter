import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/core/constants/app_strings.dart';

import '../../../data/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  final TodoModel todo;
  final VoidCallback onTap;
  final TodoController controller = Get.find<TodoController>();

  TodoItem({
    super.key,
    required this.todo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) async {
        return await _showConfirmationDialog(context);
      },
      onDismissed: (direction) async {
        try {
          await controller.deleteTodo(todo.id.toString());
          Get.snackbar(
            AppStrings.success,
            AppStrings.deletSuccesDesc,
            backgroundColor: Colors.green,
            icon: const Icon(Icons.check_circle),
          );
        } catch (e) {
          Get.snackbar(
            AppStrings.error,
            "${AppStrings.deleteErrorDesc} ${e.toString()}",
            backgroundColor: Colors.red,
            icon: const Icon(Icons.error),
          );
        }
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          title: Text(
            todo.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration:
                  todo.isCompleted ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                todo.todo,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                todo.createdAt.toLocal().toString().split(' ')[0],
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          trailing: Icon(
            todo.isCompleted
                ? Icons.check_box
                : Icons.check_box_outline_blank,
          ),
          onTap: onTap,
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Silmek istiyor musunuz?'),
          content: const Text(
            'Bu görevi silmek istediğinize emin misiniz?',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Hayır'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );
  }
}
