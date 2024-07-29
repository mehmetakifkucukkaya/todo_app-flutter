// ignore_for_file: public_member_api_docs

import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:todo_app/data/models/todo_model.dart';

class TodoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<TodoModel>> fetchTodos(String userId) async {
    try {
      final querySnapshot = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .orderBy('createdAt', descending: true)
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
      final todoJson = todo.toJson();
      todoJson.remove(
        'id',
      ); // ID'yi çıkarıyoruz çünkü Firestore otomatik oluşturacakk
      todoJson['createdAt'] = FieldValue.serverTimestamp();

      final docRef = await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .add(todoJson);

      todo.id = docRef.id;
    } catch (e) {
      print('Failed to add todo: $e');
    }
  }

  Future<void> updateTodo(String userId, TodoModel todo) async {
    try {
      if (todo.id == null) {
        throw ArgumentError('Todo ID cannot be null');
      }

      final todoJson = todo.toJson();
      todoJson.remove('id');

      await _firestore
          .collection('users')
          .doc(userId)
          .collection('todos')
          .doc(todo.id)
          .update(todoJson);
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
