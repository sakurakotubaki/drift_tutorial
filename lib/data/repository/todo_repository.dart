import 'package:drift/drift.dart';
import 'package:drift_tutorial/data/database.dart';

class TodoRepository {
  static final TodoRepository instance = TodoRepository._internal();
  static AppDatabase? _database;

  TodoRepository._internal();

  Future<AppDatabase> get database async {
    if (_database != null) return _database!;
    _database = AppDatabase();
    return _database!;
  }

  // 全てのデータを取得
  Stream<List<TodoItem>> getAllTodoItems() {
    return AppDatabase().getAllTodoItems();
  }

  // 論理削除されたアイテムを含めて全て取得
  Stream<List<TodoItem>> getAllTodoItemsIncludeDeleted() {
    return AppDatabase().getAllTodoItemsIncludeDeleted();
  }

  // 新規作成
  Future<int> createTodo({
    required String title,
    required String content,
  }) async {
    final db = await database;
    final now = DateTime.now();
    return db.createTodoItem(
      TodoItemsCompanion(
        title: Value(title),
        content: Value(content),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  // 更新
  Future<bool> updateTodo({
    required int id,
    String? title,
    String? content,
  }) async {
    final db = await database;
    final now = DateTime.now();
    return db.updateTodoItem(
      TodoItemsCompanion(
        id: Value(id),
        title: title != null ? Value(title) : const Value.absent(),
        content: content != null ? Value(content) : const Value.absent(),
        updatedAt: Value(now),
      ),
    );
  }

  // 論理削除
  Future<int> softDeleteTodo(int id) async {
    final db = await database;
    return db.softDeleteTodoItem(id);
  }

  // 物理削除
  Future<int> deleteTodo(int id) async {
    final db = await database;
    return db.deleteTodoItem(id);
  }
}
