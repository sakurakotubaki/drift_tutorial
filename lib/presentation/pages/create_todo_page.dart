import 'package:drift_tutorial/data/adapters/todo_adapter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CreateTodoPage extends ConsumerStatefulWidget {
  const CreateTodoPage({super.key});

  @override
  ConsumerState<CreateTodoPage> createState() => _CreateTodoPageState();
}

class _CreateTodoPageState extends ConsumerState<CreateTodoPage> {
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
                    await ref.read(todoAdapterProvider.notifier).createTodo(
                          title: _titleController.text,
                          content: _contentController.text,
                        );
                    if (context.mounted) {
                      context.pop(true); // 保存成功を示すtrueを返す
                    }
                  }
                },
                child: const Text('保存'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
