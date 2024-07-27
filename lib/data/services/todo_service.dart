import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

import '../models/todo_model.dart';

// Görevler ile ilgili yapılan işlemleri yöneten servis sınıfı

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TodoModel>> fetchTodos(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .get();

      return querySnapshot.docs
          .map((doc) => TodoModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Failed to fetch todos: $e');
      return [];
    }
  }

  Future<void> addTodo(String userId, TodoModel todo) async {
    try {
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .add(todo.toMap());
      todo.id = docRef.id;
    } catch (e) {
      print('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(String userId, TodoModel todo) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(todo.id)
          .update(todo.toMap());
    } catch (e) {
      print('Failed to update todo: $e');
    }
  }
}
