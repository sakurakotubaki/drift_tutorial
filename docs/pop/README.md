# 値がtrueなら前のページの状態を更新する

Flutterで画面遷移後の状態を更新する方法

画面遷移後（pop時）に前の画面の状態を更新する方法について説明します。

## 基本的な実装方法

Flutterでは、`Navigator.pop()`で結果を返し、`Navigator.push()`の戻り値で受け取ることができます。

### 1. データを返す側の実装（新規作成画面など）

```dart
ElevatedButton(
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      await TodoRepository.instance.createTodo(
        title: _titleController.text,
        content: _contentController.text,
      );
      if (context.mounted) {
        Navigator.of(context).pop(true);  // 保存成功を示すtrueを返す
      }
    }
  },
  child: const Text('Create'),
)
```

### 2. データを受け取る側の実装（一覧画面など）

```dart
FloatingActionButton(
  onPressed: () async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (context) => const CreateTodoPage()),
    );
    if (result == true && context.mounted) {
      setState(() {});  // 保存成功時に更新
    }
  },
  child: const Icon(Icons.add),
)
```

## 実装のポイント

1. **非同期処理の考慮**
   - `async/await`を使用して非同期処理を適切に扱う
   - `mounted`チェックを忘れずに行う

2. **型安全性の確保**
   - `Navigator.push<T>`で期待する戻り値の型を指定
   - 例：`Navigator.push<bool>`でbool型の結果を期待

3. **状態更新のタイミング**
   - 成功時のみ更新する（`if (result == true)`）
   - `setState()`で画面を更新

## mountedプロパティについて

### mountedとは
`mounted`は、Widgetが現在のWidget Treeに存在しているかどうかを示すブール値です。

### なぜmountedチェックが必要か
1. **非同期処理での安全性確保**
   - 非同期処理（async/await）の完了を待っている間に、ユーザーが画面を離れる可能性がある
   - その場合、Widgetは既にWidget Treeから削除（アンマウント）されている
   - アンマウントされたWidgetで`setState`を呼ぶと、エラーが発生する

2. **メモリリークの防止**
   - アンマウントされたWidgetの状態を更新しようとすると、メモリリークの原因になる
   - `mounted`チェックで、不要な状態更新を防ぐ

### 実装例と解説

```dart
FloatingActionButton(
  onPressed: () async {
    final result = await Navigator.of(context).push<bool>(
      MaterialPageRoute(builder: (context) => const CreateTodoPage()),
    );
    // ここで非同期処理が完了するまでの間に
    // ユーザーが画面を離れている可能性がある
    
    if (result == true && context.mounted) {  // mountedチェックが重要
      setState(() {});  // Widgetが存在する場合のみ更新
    }
  },
)
```

### 講師の解説

mountedチェックは、Flutterアプリケーションの信頼性と安全性を確保する上で重要な役割を果たします：

1. **タイミングの問題**
   - 非同期処理中にユーザーが画面を離れることは珍しくない
   - 特にモバイルアプリでは、バックグラウンド遷移やアプリの終了が頻繁に発生

2. **エラー防止**
   - `setState`は、Widgetが有効な状態（mounted）でのみ呼び出せる
   - mountedチェックを怠ると、実行時エラーの原因になる
   ```
   Flutter Error: setState() called after dispose()
   ```

3. **ベストプラクティス**
   - 非同期処理後の状態更新には、必ずmountedチェックを含める
   - `context.mounted`（Flutter 3.7以降）の使用を推奨

### 補足：context.mountedについて
- Flutter 3.7で導入された新しい構文
- `if (mounted)`の代わりに`if (context.mounted)`を使用
- より明示的で分かりやすい構文として推奨されている

## 参考資料

詳細な実装方法については、Flutter公式ドキュメントを参照してください：
- [Flutterクックブック - 画面からデータを返す](https://docs.flutter.dev/cookbook/navigation/returning-data)
