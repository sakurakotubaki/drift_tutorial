import 'package:drift_tutorial/data/database.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  // データベースを開く
  final db = AppDatabase();
  // データベースを閉じる
  ref.onDispose(() => db.close());
  return db;
}
