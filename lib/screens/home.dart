import 'package:flutter/material.dart';
import 'package:notes_sample/model/note.dart';
import 'package:notes_sample/model/note_model.dart';
import 'package:notes_sample/screens/add_note.dart';
import 'package:notes_sample/screens/edit_note.dart';
import 'package:notes_sample/utils/firebase_utils.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/";

  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();

    FirebaseUserUtils.instance.subscibeNotes((notes) {
      Provider.of<NotesModel>(context, listen: false).setNotes(notes);
    });
  }

  @override
  void dispose() {
    super.dispose();
    FirebaseUserUtils.instance.stopSubscribeNotes();
  }

  void _onPressNote(String noteId) {
    Navigator.pushNamed(context, EditNoteScreen.routeName, arguments: noteId);
  }

  void _onPressCreateNote() {
    Navigator.pushNamed(context, AddNoteScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(title: const Text("Notes")),
      body: Consumer<NotesModel>(builder: (context, notesModel, card) {
        final notes = notesModel.noteList;
        //show empty screen if notes is empty
        if (notes.isEmpty) {
          return const Center(
              child: Text("Tap on the + button to add a new note"));
        }
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: notes.length,
            itemBuilder: (BuildContext contex, int index) {
              final Note note = notes[index];
              return Card(
                child: ListTile(
                  onTap: () {
                    _onPressNote(note.noteId);
                  },
                  title: Text(
                    note.title.isEmpty ? "-" : note.title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(note.note.isEmpty ? "-" : note.note),
                ),
              );
            });
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: _onPressCreateNote,
        child: const Icon(Icons.add),
      ),
    );
  }
}
