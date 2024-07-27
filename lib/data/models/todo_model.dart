import 'package:cloud_firestore/cloud_firestore.dart'; // Firebase Cloud Firestore yerine doğru paket adı

class TodoModel {
  String? id;
  String title;
  bool isCompleted;
  DateTime createdAt;
  String userId;
  String todo; // Yeni eklenen todo özelliği

  TodoModel({
    this.id,
    required this.title,
    this.isCompleted = false,
    required this.userId,
    DateTime? createdAt,
    this.todo = '', // Yeni özelliğin varsayılan değeri
  }) : createdAt = createdAt ?? DateTime.now();

  // Firestore'dan veri okumak için factory constructor
  factory TodoModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TodoModel(
      id: doc.id,
      title: data['title'] ?? '',
      isCompleted: data['isCompleted'] ?? false,
      userId: data['userId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      todo: data['todo'] ?? '', // Yeni özelliğin okunması
    );
  }

  // Firestore'a veri yazmak için Map'e dönüştürme metodu
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'todo': todo, // Yeni özelliğin eklenmesi
    };
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
      todo: todo ?? this.todo, // Yeni özelliğin güncellenmesi
    );
  }
}
