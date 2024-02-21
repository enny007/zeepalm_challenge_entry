import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeepalm_challenge_entry/models/todo_model.dart';
import 'package:zeepalm_challenge_entry/providers/todos_list_provider.dart';
import 'package:zeepalm_challenge_entry/utils/extensions.dart';

class TodoFormProvider extends StateNotifier<Todo> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  TodoStatus? _status;
  bool showErrors = false;
  TodoFormProvider(Todo initialState) : super(initialState) {
    //update controllers
    updateControllers();

    // Initialize status
    _status = initialState.status;

    // state = state.copyWith(id: id);

    titleController.addListener(() {
      state = state.copyWith(title: titleController.text);
    });

    descriptionController.addListener(() {
      state = state.copyWith(description: descriptionController.text);
    });

    categoryController.addListener(() {
      state = state.copyWith(category: categoryController.text);
    });
  }

  // Add a function to set TodoStatus
  void setTodoStatus(TodoStatus? status) {
    _status = status;
    state = state.copyWith(status: status);
  }

  // Add a function to get current TodoStatus
  TodoStatus? getTodoStatus() {
    return _status;
  }

  void setShowErrors(bool show) {
    showErrors = show;
  }

  //To load the last state of an entry in the form
  load(Todo todo) {
    state = todo;
    _status = todo.status;
    updateControllers();
  }

  clear() {
    state = Todo.empty();
    _status = TodoStatus.todo;
    updateControllers();
  }

  updateControllers() {
    titleController.text = state.title ?? '';
    descriptionController.text = state.description ?? '';
    categoryController.text = state.category ?? '';
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Name is required";
    }

    return null;
  }

  String? descriptionValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Description is required";
    }

    return null;
  }

  String? categoryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Category is required";
    }

    return null;
  }

  void submit(WidgetRef ref, {bool isUpdate = false}) {
    setShowErrors(true);
    if (!formKey.currentState!.validate()) {
      return;
    }
    setShowErrors(false);
    final newId = isUpdate ? state.id : Random().nextInt(100).toString();
    state = state.copyWith(id: newId);
    final todoList = ref.read(todoListProvider.notifier);
    isUpdate ? todoList.updateTodo(state) : todoList.addTodo(state);
    clear();
    Navigator.pop(ref.context);
  }
}

final todoFormProvider = StateNotifierProvider<TodoFormProvider, Todo>((ref) {
  return TodoFormProvider(Todo.empty());
});
