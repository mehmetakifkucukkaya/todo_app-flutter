import 'package:get/get.dart';

import '../data/models/todo_model.dart';
import '../data/services/todo_service.dart';
import 'auth_controller.dart';

class TodoController extends GetxController {
  final TodoService _todoService = TodoService();
  final AuthController _authController = Get.find<AuthController>();

  final todos = <TodoModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_authController.firebaseUser, (_) => fetchTodos());
    fetchTodos();
  }

  List<TodoModel> get incompleteTodos =>
      todos.where((todo) => !todo.isCompleted).toList();

  List<TodoModel> get completedTodos =>
      todos.where((todo) => todo.isCompleted).toList();

  Future<void> fetchTodos() async {
    if (_authController.userId == null) {
      print('User ID is null');
      return;
    }

    isLoading.value = true;

    try {
      final fetchedTodos =
          await _todoService.fetchTodos(_authController.userId!);
      todos.value = fetchedTodos;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTodo(String title, String todo) async {
    if (_authController.userId == null) return;

    final newTodo = TodoModel(
      title: title,
      userId: _authController.userId!,
      todo: todo,
      isCompleted: false,
      createdAt: DateTime.now(),
    );

    await _todoService.addTodo(_authController.userId!, newTodo);
    fetchTodos(); 
  }

  Future<void> toggleTodo(TodoModel todo) async {
    if (_authController.userId == null) return;

    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);

    await _todoService.updateTodo(_authController.userId!, updatedTodo);
    final index = todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      todos[index] = updatedTodo;
    }
  }

  Future<void> updateTodo(TodoModel updatedTodo) async {
    if (_authController.userId == null) return;

    try {
      await _todoService.updateTodo(_authController.userId!, updatedTodo);
      final index = todos.indexWhere((t) => t.id == updatedTodo.id);
      if (index != -1) {
        todos[index] = updatedTodo;
      }
    } catch (e) {
      print('Failed to update todo: $e');
      rethrow;
    }
  }

  Future<void> deleteTodo(String todoId) async {
    if (_authController.userId == null) return;

    try {
      await _todoService.deleteTodo(_authController.userId!, todoId);
      todos.removeWhere((todo) => todo.id == todoId);
    } catch (e) {
      print('Failed to delete todo: $e');
      rethrow;
    }
  }
}
