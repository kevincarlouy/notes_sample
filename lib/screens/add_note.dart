import 'package:flutter/material.dart';
import 'package:notes_sample/model/note.dart';
import 'package:notes_sample/model/note_model.dart';
import 'package:notes_sample/widgets/note_detals.dart';
import 'package:provider/provider.dart';

class AddNoteScreen extends StatefulWidget {
  static const routeName = "main/add_note";

  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onBackPressed() {
    // widget.onBack(_titleController.text, _noteController.text);
    final newTitle = _titleController.text;
    final newNote = _noteController.text;
    if (newTitle.isNotEmpty || newNote.isNotEmpty) {
      final note = Note(title: newTitle, note: newNote);
      Provider.of<NotesModel>(context, listen: false).addNote(note);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Note"),
          leading: BackButton(onPressed: _onBackPressed),
        ),
        body: NoteDetails(
          titleController: _titleController,
          noteController: _noteController,
        ));
  }
}
