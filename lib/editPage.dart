import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/state_notifier.dart';

class EditPage extends ConsumerWidget {
  final String id;
  final String title;
  final String content;

  EditPage({
    required this.id,
    required this.title,
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController(text: title);
    final contentController = TextEditingController(text: content);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Note',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                hintText: "Edit Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                hintText: "Edit Content",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 50,
        width: 300,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            ref.read(noteProvider.notifier).update(
                  id,
                  titleController.text,
                  contentController.text,
                );
            Navigator.pop(context);
          },
          child: const Text(
            "Save Changes",
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
