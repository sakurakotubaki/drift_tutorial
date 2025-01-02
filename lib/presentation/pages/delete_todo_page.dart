import 'package:drift_tutorial/data/adapters/todo_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DeleteTodoPage extends ConsumerWidget {
  const DeleteTodoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoStream = ref.watch(todoAdapterProvider.notifier).getAllTodoItemsIncludeDeleted();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO Delete'),
      ),
      body: StreamBuilder(
        stream: todoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('エラーが発生しました:${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (context, index) {
              final data = todos[index];
              return ListTile(
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await ref.read(todoAdapterProvider.notifier).deleteTodo(data.id);
                  },
                ),
                title: Text(data.title),
                subtitle: Text(data.content),
              );
            },
          );
        },
      ),
    );
  }
}
