// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoModel _$TodoModelFromJson(Map<String, dynamic> json) => TodoModel(
      userId: json['userId'] as String,
      id: json['id'] as String?,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdAt: _$JsonConverterFromJson<Timestamp, DateTime>(
          json['createdAt'], const TimestampConverter().fromJson,),
      todo: json['todo'] as String? ?? '',
    );

Map<String, dynamic> _$TodoModelToJson(TodoModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['title'] = instance.title;
  val['isCompleted'] = instance.isCompleted;
  val['createdAt'] = const TimestampConverter().toJson(instance.createdAt);
  val['userId'] = instance.userId;
  val['todo'] = instance.todo;
  return val;
}

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
