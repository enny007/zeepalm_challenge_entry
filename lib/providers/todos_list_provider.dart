import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zeepalm_challenge_entry/providers/ui_providers.dart';
import '../models/todo_model.dart';

final todoListProvider =
    StateNotifierProvider.autoDispose<TodoListProvider, List<Todo>>((ref) {
  return TodoListProvider([]);
});

class TodoListProvider extends StateNotifier<List<Todo>> {
  TodoListProvider(List<Todo> initialState) : super(initialState);

  void addTodo(Todo todo) {
    state = [...state, todo];
  }

  void updateTodo(Todo updatedTodo) {
    state = state.map((todo) {
      if (todo.id == updatedTodo.id) {
        return updatedTodo;
      } else {
        return todo;
      }
    }).toList();
  }

  void removeTodoAt(Todo todo) {
    final disposableList = <Todo>[...state];
    disposableList.removeWhere((element) => element.id == todo.id);
    state = disposableList;
  }

   List<Todo> getFilteredTodos(String category) {
    final allTodos = <Todo>[...state];
    return allTodos.where((todo) => todo.category == category).toList();
  }

   void handleCategoryTap(WidgetRef ref, String category) {
    ref.read(activeCategoriesProvider.notifier).toggleCategory(category);
    ref.read(isCategorizedProvider.notifier).state = category != 'all';
    ref.read(selectedCategoryProvider.notifier).state = category;
  }

  // Add other methods as needed
}

