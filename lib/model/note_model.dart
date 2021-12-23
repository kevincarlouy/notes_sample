import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:notes_sample/model/note.dart';

class NotesModel extends ChangeNotifier {
  final List<Note> _notes = [];

  UnmodifiableListView<Note> get noteList => UnmodifiableListView(_notes);

  void addNote(Note item) {
    _notes.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void removeNote(String noteId) {
    int index = _notes.indexWhere((note) => note.noteId == noteId);
    _notes.removeAt(index);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void setNotes(List<Note> notes) {
    _notes.clear();
    _notes.addAll(notes);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void updateNote(String noteId, String title, String noteString) {
    final note = getNote(noteId);
    note.title = title;
    note.note = noteString;
    notifyListeners();
  }

  Note getNote(String noteId) =>
      _notes[_notes.indexWhere((note) => note.noteId == noteId)];
}
