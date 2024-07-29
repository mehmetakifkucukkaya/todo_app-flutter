import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

import '../models/todo_model.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TodoModel>> fetchTodos(String userId) async {
    try {
      // Görevleri createdAt alanına göre sıralı olarak getiriyoruz.
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .orderBy(
            'createdAt',
            descending: true,
          )
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
      // createdAt alanını eklerken Timestamp olarak eklediğimizden emin oluyoruz.
      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .add({
        ...todo.toMap(),
        'createdAt': FieldValue.serverTimestamp(),
      });
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
      rethrow;
    }
  }

  Future<void> deleteTodo(String userId, String todoId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(todoId)
          .delete();
    } catch (e) {
      print('Failed to delete todo: $e');
      rethrow;
    }
  }
}
