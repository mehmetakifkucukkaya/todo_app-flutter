// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
  TodoModel({
    required this.userId,
    required this.title,
    this.id,
    this.isCompleted = false,
    DateTime? createdAt,
    this.todo = '',
  }) : createdAt = createdAt ?? DateTime.now();

  // Firestore'dan veri okumak için factory constructor
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data()! as Map<String, dynamic>;
    return TodoModel.fromJson({...data, 'id': doc.id});
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  @JsonKey(includeIfNull: false)
  String? id;
  String title;
  @JsonKey(defaultValue: false)
  bool isCompleted;
  @TimestampConverter()
  DateTime createdAt;
  String userId;
  @JsonKey(defaultValue: '')
  String todo;
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  // Görevi güncellemek için kullanılabilecek bir metod
  TodoModel copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    String? userId,
    DateTime? createdAt,
    String? todo,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      todo: todo ?? this.todo,
    );
  }
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
