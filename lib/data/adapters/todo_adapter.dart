import 'package:drift_tutorial/data/database.dart';
import 'package:drift_tutorial/data/provider/database_provider.dart';
import 'package:drift_tutorial/domain/ports/todo_port.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_adapter.g.dart';

@Riverpod(keepAlive: true)
class TodoAdapter extends _$TodoAdapter implements TodoPort {
  AppDatabase get _db => ref.read(databaseProvider);

  @override
  Stream<List<TodoItem>> build() {
    return _db.getAllTodoItems();
  }

  @override
  Stream<List<TodoItem>> getAllTodoItems() {
    return _db.getAllTodoItems();
  }

  @override
  Stream<List<TodoItem>> getAllTodoItemsIncludeDeleted() {
    return _db.getAllTodoItemsIncludeDeleted();
  }

  @override
  Future<int> createTodo({
    required String title,
    required String content,
  }) async {
    final now = DateTime.now();
    final result = await _db.createTodoItem(
      TodoItemsCompanion(
        title: Value(title),
        content: Value(content),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
    ref.invalidateSelf();
    return result;
  }

  @override
  Future<bool> updateTodo({
    required int id,
    String? title,
    String? content,
  }) async {
    final now = DateTime.now();
    final result = await _db.updateTodoItem(
      TodoItemsCompanion(
        id: Value(id),
        title: title != null ? Value(title) : const Value.absent(),
        content: content != null ? Value(content) : const Value.absent(),
        updatedAt: Value(now),
      ),
    );
    ref.invalidateSelf();
    return result;
  }

  @override
  Future<int> softDeleteTodo(int id) async {
    final result = await _db.softDeleteTodoItem(id);
    ref.invalidateSelf();
    return result;
  }

  @override
  Future<int> deleteTodo(int id) async {
    final result = await _db.deleteTodoItem(id);
    ref.invalidateSelf();
    return result;
  }
}
