import 'package:drift_tutorial/data/database.dart';

abstract class TodoPort {
  Stream<List<TodoItem>> getAllTodoItems();
  Stream<List<TodoItem>> getAllTodoItemsIncludeDeleted();
  Future<int> createTodo({required String title, required String content});
  Future<bool> updateTodo({required int id, String? title, String? content});
  Future<int> softDeleteTodo(int id);
  Future<int> deleteTodo(int id);
}
