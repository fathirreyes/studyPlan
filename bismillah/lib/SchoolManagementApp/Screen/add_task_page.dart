import 'package:flutter/material.dart';
import '../Services/task_services.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();
  String title = '';
  String description = '';
  String? deadline;

  bool isSubmitting = false;

  void submitTask() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => isSubmitting = true);

    try {
      await TaskService().createTask(
        title: title,
        description: description,
        deadline: deadline,
      );
      Navigator.pop(context, true); // true -> untuk trigger refresh
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    } finally {
      setState(() => isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tambah Task')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Judul'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Judul wajib diisi'
                            : null,
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Deskripsi'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Deskripsi wajib diisi'
                            : null,
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Deadline (YYYY-MM-DD, opsional)',
                ),
                onSaved: (value) => deadline = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: isSubmitting ? null : submitTask,
                child:
                    isSubmitting
                        ? const CircularProgressIndicator()
                        : const Text('Tambah Task'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
