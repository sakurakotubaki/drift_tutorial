import 'package:drift_tutorial/data/database.dart';
import 'package:drift_tutorial/data/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class DeleteTodoPage extends StatefulWidget {
  const DeleteTodoPage({super.key});

  @override
  State<DeleteTodoPage> createState() => _DeleteTodoPageState();
}

class _DeleteTodoPageState extends State<DeleteTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('TODO Delete'),
        ),
        body: StreamBuilder<List<TodoItem>>(
          stream: TodoRepository.instance.getAllTodoItemsIncludeDeleted(),
          builder: (context, AsyncSnapshot<List<TodoItem>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final todo = snapshot.data?[index];
                  return ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        TodoRepository.instance.deleteTodo(todo?.id ?? 0);
                      },
                    ),
                    title: Text(todo?.title ?? ''),
                    subtitle: Text(todo?.content ?? ''),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
