import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myapp/state_notifier.dart';
import 'package:flutter_riverpod/legacy.dart';

class Addpage extends ConsumerWidget {
  const Addpage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final provider=ref.watch(noteProvider);

    final TextEditingController title=TextEditingController();
    final TextEditingController content=TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Notes',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: content,
                decoration: InputDecoration(
                  hintText: "Enter Content",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        height: 50,
        width: 300,
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            ref.read(noteProvider.notifier).addNote(title.text.toString(),content.text.toString());
            Navigator.pop(context);
          },
          child: Text(
            "Add",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold,color: Colors.white),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
