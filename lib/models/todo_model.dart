import 'package:zeepalm_challenge_entry/utils/extensions.dart';

class Todo {
  final String? id;
  final String? title;
  final String? description;
  final String? category;
  final TodoStatus? status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
  });

  factory Todo.empty() {
    return Todo(
      id: '',
      title: '',
      description: '',
      category: '',
      status: TodoStatus.todo,
    );
  }

  Todo copyWith({
    String? id,
    String? title,
    String? description,
    String? category,
    // TodoPriority? priority,
    TodoStatus? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      status: status ?? this.status,
    );
  }

  @override
  String toString() {
    return 'Todo(title: $title, description: $description, categoryId: $category, status: $status)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.category == category &&
        other.id == id &&
        other.status == status;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        category.hashCode ^
        id.hashCode ^
        status.hashCode;
  }
}
