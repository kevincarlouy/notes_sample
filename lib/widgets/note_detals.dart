import 'package:flutter/material.dart';

class NoteDetails extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController noteController;

  const NoteDetails(
      {Key? key,
      required this.titleController,
      required this.noteController})
      : super(key: key);

  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: widget.titleController,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.cyan),
                  ),
                  hintText: "Title"),
            ),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: widget.noteController,
              decoration: const InputDecoration.collapsed(hintText: "Note"),
            ),
          ],
        ),
      );
    
  }
}
