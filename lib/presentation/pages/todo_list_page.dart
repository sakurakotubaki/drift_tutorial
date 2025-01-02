import 'package:drift_tutorial/data/database.dart';
import 'package:drift_tutorial/data/repository/todo_repository.dart';
import 'package:drift_tutorial/presentation/pages/create_todo_page.dart';
import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.of(context).push<bool>(
            MaterialPageRoute(builder: (context) => const CreateTodoPage()),
          );
          if (result == true && mounted) {
            setState(() {});  // 保存成功時に更新
          }
        },
        child: const Icon(Icons.add, color: Colors.black),
      ),
      body: StreamBuilder<List<TodoItem>>(
        stream: TodoRepository.instance.getAllTodoItems(),
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
                      setState(() {
                        TodoRepository.instance.softDeleteTodo(todo?.id ?? 0);
                      });
                    },
                  ),
                  title: Text(todo?.title ?? ''),
                  subtitle: Text(todo?.content ?? ''),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
