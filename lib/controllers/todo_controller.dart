import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Cloud Firestore yerine doğru paket adı
import 'package:get/get.dart';

import '../data/models/todo_model.dart';
import 'auth_controller.dart';

class TodoController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthController _authController = Get.find<AuthController>();

  final todos = <TodoModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    ever(_authController.firebaseUser, (_) => fetchTodos());
    fetchTodos();
  }

  //* Todoları Firebase'den getirme metodu
  List<TodoModel> get incompleteTodos =>
      todos.where((todo) => !todo.isCompleted).toList();

  List<TodoModel> get completedTodos =>
      todos.where((todo) => todo.isCompleted).toList();

  //* Todoları firebase'den çekme metodu
  Future<void> fetchTodos() async {
    if (_authController.userId == null) {
      print('User ID is null');
      return;
    }

    try {
      print('Fetching todos for user: ${_authController.userId}');
      final querySnapshot = await _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('todos')
          .get();

      print('Query snapshot: ${querySnapshot.docs.length} documents');

      if (querySnapshot.docs.isEmpty) {
        print('No todos found for user: ${_authController.userId}');
      } else {
        todos.value = querySnapshot.docs
            .map((doc) => TodoModel.fromFirestore(doc))
            .toList();
        print("Fetched todos: ${todos.length}");
        for (var todo in todos) {
          print('Todo: ${todo.title}, Completed: ${todo.isCompleted}');
        }
      }
    } catch (e) {
      print('Failed to fetch todos: $e');
    }
  }

  Future<void> addTodo(String title, String todo) async {
    if (_authController.userId == null) return;

    final newTodo = TodoModel(
      title: title,
      userId: _authController.userId!,
      todo: todo, // Yeni özellik ekleniyor
    );

    try {
      final docRef = await _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('todos')
          .add(newTodo.toMap());
      newTodo.id = docRef.id;
      todos.add(newTodo);
      print("Added todo: ${newTodo.title}");
    } catch (e) {
      print('Failed to add todo: $e');
    }
  }

  //* Todo'yu tamamlayıp tamamalamama durumunu kontrol eden metot
  Future<void> toggleTodo(TodoModel todo) async {
    if (_authController.userId == null) return;

    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);

    try {
      await _firestore
          .collection('users')
          .doc(_authController.userId)
          .collection('todos')
          .doc(todo.id)
          .update(updatedTodo.toMap());
      final index = todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        todos[index] = updatedTodo;
      }
      print("Toggled todo: ${updatedTodo.title}");
    } catch (e) {
      print('Failed to toggle todo: $e');
    }
  }
}
