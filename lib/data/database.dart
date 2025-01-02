import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';

class TodoItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 6, max: 32)();
  TextColumn get content => text().named('body')();
  DateTimeColumn get createdAt => dateTime().nullable()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}

@DriftDatabase(tables: [TodoItems])
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'my_database.sqlite'));
      return NativeDatabase(file);
    });
  }

  // 全てのTodoアイテムを取得（論理削除されていないもののみ）
  Stream<List<TodoItem>> getAllTodoItems({bool descending = true}) {
    final query = select(todoItems)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([
        (t) => OrderingTerm(
            expression: t.createdAt,
            mode: descending ? OrderingMode.desc : OrderingMode.asc)
      ]);
    return query.watch();
  }

// 論理削除されたアイテムを含めて全て取得
  Stream<List<TodoItem>> getAllTodoItemsIncludeDeleted(
      {bool descending = true}) {
    final query = select(todoItems)
      ..orderBy([
        (t) => OrderingTerm(
            expression: t.createdAt,
            mode: descending ? OrderingMode.desc : OrderingMode.asc)
      ]);
    return query.watch();
  }

// 新規Todo作成
  Future<int> createTodoItem(TodoItemsCompanion entry) {
    return into(todoItems).insert(entry);
  }

// Todo更新
  Future<bool> updateTodoItem(TodoItemsCompanion entry) {
    return update(todoItems).replace(entry);
  }

// 論理削除
  Future<int> softDeleteTodoItem(int id) {
    return (update(todoItems)..where((t) => t.id.equals(id)))
        .write(TodoItemsCompanion(deletedAt: Value(DateTime.now())));
  }

// 物理削除
  Future<int> deleteTodoItem(int id) {
    return (delete(todoItems)..where((t) => t.id.equals(id))).go();
  }
}
