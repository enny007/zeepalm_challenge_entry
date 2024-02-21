//TodoStatus Enum extension
import 'package:flutter/material.dart';

enum TodoStatus {
  completed,
  inProgress,
  todo,
}

extension TodoStatusExtension on TodoStatus {
  String get displayText {
    switch (this) {
      case TodoStatus.completed:
        return 'Completed';
      case TodoStatus.inProgress:
        return 'In Progress';
      case TodoStatus.todo:
        return 'Todo';
      default:
        return 'Todo';
    }
  }

  Color get displayColor {
    switch (this) {
      case TodoStatus.completed:
        return Colors.green;
      case TodoStatus.inProgress:
        return Colors.orange;
      case TodoStatus.todo:
        return Colors.red;
      default:
        return Colors.red;
    }
  }
}
