import 'package:drift_tutorial/data/adapters/todo_adapter.dart';
import 'package:drift_tutorial/presentation/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListPage extends ConsumerWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adapter = ref.watch(todoAdapterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final result = await const CreateTodoRoute().push<bool>(context);
          const CreateTodoRoute().go(context);
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: switch (adapter) {
        AsyncData(:final value) => ListView.builder(
            itemCount: value.length,
            itemBuilder: (context, index) {
              final data = value[index];
              return ListTile(
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    ref
                        .read(todoAdapterProvider.notifier)
                        .softDeleteTodo(data.id);
                  },
                ),
                title: Text(data.title),
                subtitle: Text(data.content),
              );
            },
          ),
        AsyncError(:final error) => Center(child: Text('エラーが発生しました$error')),
        _ => const Center(child: CircularProgressIndicator()),
      },
      // body: StreamBuilder<List<TodoItem>>(
      //   stream: TodoRepository.instance.getAllTodoItems(),
      //   builder: (context, AsyncSnapshot<List<TodoItem>> snapshot) {
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //         itemCount: snapshot.data?.length ?? 0,
      //         itemBuilder: (context, index) {
      //           final todo = snapshot.data?[index];
      //           return ListTile(
      //             trailing: IconButton(
      //               icon: const Icon(Icons.delete),
      //               onPressed: () {
      //                 setState(() {
      //                   TodoRepository.instance.softDeleteTodo(todo?.id ?? 0);
      //                 });
      //               },
      //             ),
      //             title: Text(todo?.title ?? ''),
      //             subtitle: Text(todo?.content ?? ''),
      //           );
      //         },
      //       );
      //     } else {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //   },
    );
  }
}
