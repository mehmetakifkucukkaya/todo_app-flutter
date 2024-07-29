import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'todo_model.g.dart';

@JsonSerializable()
class TodoModel {
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

  TodoModel({
    required this.userId,
    this.id,
    required this.title,
    this.isCompleted = false,
    DateTime? createdAt,
    this.todo = '',
  }) : createdAt = createdAt ?? DateTime.now();

  factory TodoModel.fromJson(Map<String, dynamic> json) =>
      _$TodoModelFromJson(json);
  Map<String, dynamic> toJson() => _$TodoModelToJson(this);

  // Firestore'dan veri okumak için factory constructor
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return TodoModel.fromJson({...data, 'id': doc.id});
  }

  // Todo'yu güncellemek için kullanılabilecek bir metod
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
