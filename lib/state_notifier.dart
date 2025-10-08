import 'dart:core';
import 'package:flutter_riverpod/legacy.dart';
import 'package:myapp/note.dart';

final noteProvider = StateNotifierProvider<noteNotifier, List<Note>>((refs) {
  return noteNotifier();
});

class noteNotifier extends StateNotifier<List<Note>> {
  noteNotifier() : super([]);

  void addNote(String title, String content) {
    final note = Note(
      id: DateTime.now().toString(),
      title: title,
      content: content,
    );
    state.add(note);
    state = state.toList();
  }

  void update(String id, String newTitle, String newContent) {
  state = state
      .map((note) => note.id == id
          ? Note(id: note.id, title: newTitle, content: newContent)
          : note)
      .toList();
}


  void delete(String id) {
    state.removeWhere((item) => item.id == id);
    state = state.toList();
  }
}
