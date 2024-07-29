// ignore_for_file: public_member_api_docs, unnecessary_await_in_return

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/config/themes/app_theme.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/core/constants/app_strings.dart';
import 'package:todo_app/data/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTap,
    super.key,
  });
  final TodoModel todo;
  final VoidCallback onTap;
  final TodoController controller = Get.find<TodoController>();

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      //* Güncelleme
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
          size: 30,
        ),
      ),
      //* Silme
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          return await _showConfirmationDialog(context);
        } else if (direction == DismissDirection.startToEnd) {
          _showUpdateTodoDialog(context, todo);
          return false;
        }
        return false;
      },
      onDismissed: (direction) async {
        if (direction == DismissDirection.endToStart) {
          try {
            await controller.deleteTodo(todo.id.toString());
            Get.snackbar(
              AppStrings.success,
              AppStrings.deletSuccesDesc,
              backgroundColor: Colors.green,
              icon: const Icon(
                Icons.check_circle,
              ),
            );
          } catch (e) {
            Get.snackbar(
              AppStrings.error,
              '${AppStrings.deleteErrorDesc} $e',
              backgroundColor: Colors.red,
              icon: const Icon(Icons.error),
            );
          }
        }
      },
      child: Card(
        color: todo.isCompleted
            ? AppTheme.completedTodoCard
            : AppTheme.notCompletedTodoCard,
        elevation: 6,
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
                _formatDate(todo.createdAt),
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

  void _showUpdateTodoDialog(BuildContext context, TodoModel todo) {
    final titleController = TextEditingController(text: todo.title);
    final todoController = TextEditingController(text: todo.todo);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Görev Güncelle'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(hintText: 'Başlık'),
            ),
            TextField(
              controller: todoController,
              decoration: const InputDecoration(hintText: 'Görev'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty &&
                  todoController.text.isNotEmpty) {
                try {
                  todo.title = titleController.text;
                  todo.todo = todoController.text;
                  await controller.updateTodo(
                    todo,
                  );
                  Navigator.pop(context);
                  Get.snackbar(
                    AppStrings.success,
                    AppStrings.updateSuccesDesc,
                    backgroundColor: Colors.green,
                    icon: const Icon(Icons.check_circle),
                  );
                } catch (e) {
                  print('Failed to update todo: $e');
                  Get.snackbar(
                    AppStrings.error,
                    'Göreviniz Güncellenemedi: $e',
                    backgroundColor: Colors.red,
                    icon: const Icon(Icons.error),
                  );
                }
              } else {
                Get.snackbar(
                  AppStrings.error,
                  AppStrings.updateWarning,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error),
                );
              }
            },
            child: const Text('Güncelle'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('d MMMM yyyy - HH:mm');
    return formatter.format(date);
  }
}
