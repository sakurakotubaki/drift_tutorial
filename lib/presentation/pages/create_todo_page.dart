import 'package:drift_tutorial/data/repository/todo_repository.dart';
import 'package:flutter/material.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  State<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends State<CreateTodoPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TODO Create'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            spacing: 10,
            children: [
              TextFormField(
                validator: (value) {
                  // Text count 6
                  if (value!.length < 6) {
                    return 'Title must be at least 6 characters';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                controller: _titleController,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Content',
                ),
                controller: _contentController,
              ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
