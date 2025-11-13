import 'package:flutter/material.dart';
import 'package:task_notes_manager/models/task_item.dart';
import 'package:task_notes_manager/data/database_helper.dart';

class Screen2 extends StatefulWidget {
  final TaskItem? taskToEdit;

  const Screen2({Key? key, this.taskToEdit}) : super(key: key);

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late int _priority;
  late bool _isCompleted;
  bool get _isEditing => widget.taskToEdit != null;

  @override
  void initState() {
    super.initState();
    _title = widget.taskToEdit?.title ?? '';
    _description = widget.taskToEdit?.description ?? '';
    _priority = widget.taskToEdit?.priority ?? 1;
    _isCompleted = widget.taskToEdit?.isCompleted ?? false;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    if (_isEditing) {
      final updatedTask = widget.taskToEdit!.copyWith(
        title: _title,
        description: _description,
        priority: _priority,
        isCompleted: _isCompleted,
      );
      await DatabaseHelper.instance.updateTask(updatedTask);
    } else {
      final task = TaskItem(
        title: _title,
        description: _description,
        priority: _priority,
        isCompleted: _isCompleted,
      );
      await DatabaseHelper.instance.insertTask(task);
    }
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Task' : 'Add Task'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                onSaved: (v) => _title = v!.trim(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                onSaved: (v) => _description = v?.trim() ?? '',
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _priority,
                decoration: const InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 1, child: Text('Low')),
                  DropdownMenuItem(value: 2, child: Text('Medium')),
                  DropdownMenuItem(value: 3, child: Text('High')),
                ],
                onChanged: (v) => setState(() => _priority = v ?? 1),
              ),
              const SizedBox(height: 16),
              CheckboxListTile(
                title: const Text('Completed'),
                value: _isCompleted,
                onChanged: (v) => setState(() => _isCompleted = v ?? false),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: Colors.grey.shade400),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  _isEditing ? 'Update Task' : 'Add Task',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
