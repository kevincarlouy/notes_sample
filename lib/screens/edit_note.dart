import 'package:flutter/material.dart';
import 'package:notes_sample/model/note_model.dart';
import 'package:notes_sample/widgets/note_detals.dart';
import 'package:provider/provider.dart';

class EditNoteScreen extends StatefulWidget {
  static const routeName = "main/edit_note";

  const EditNoteScreen({Key? key}) : super(key: key);

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final _titleController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onBackPressed(String noteId) {
    // widget.onBack(_titleController.text, _noteController.text);
    final newTitle = _titleController.text;
    final newNote = _noteController.text;

    if (newTitle.isNotEmpty || newNote.isNotEmpty) {
      Provider.of<NotesModel>(context, listen: false)
          .updateNote(noteId, newTitle, newNote);
    }

    Navigator.pop(context);
  }

  void _onDeletePressed(String noteId) {
    Navigator.pop(context);
    Provider.of<NotesModel>(context, listen: false).removeNote(noteId);
  }

  @override
  Widget build(BuildContext context) {
    final String noteId = ModalRoute.of(context)!.settings.arguments as String;
    final note =
        Provider.of<NotesModel>(context, listen: false).getNote(noteId);
    _titleController.text = note.title;
    _noteController.text = note.note;

    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Note"),
          leading: BackButton(onPressed: () {
            _onBackPressed(noteId);
          }),
          actions: [
            IconButton(
                onPressed: () {
                  _onDeletePressed(noteId);
                },
                icon: const Icon(Icons.delete))
          ],
        ),
        body: NoteDetails(
          titleController: _titleController,
          noteController: _noteController,
        ));
  }
}
