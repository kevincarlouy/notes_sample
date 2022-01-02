import 'package:uuid/uuid.dart';

class Note {
  String title;
  String note;
  final String noteId;

  Note({required this.title, required this.note}) : noteId = const Uuid().v4();

  Note.clone(Note note)
      : noteId = note.noteId,
        title = note.title,
        note = note.note;

  Note.fromFirebaseData(this.noteId, Map<String, Object?> json)
      : title = json["title"] as String,
        note = json["note"] as String;

  Map<String, Object?> toFirebaseData() {
    return {"title": title, "note": note};
  }

  @override
  int get hashCode => noteId.hashCode ^ title.hashCode ^ note.hashCode;

  @override
  bool operator ==(Object other) {
    Note otherNote = other as Note;
    return title == otherNote.note &&
        note == otherNote.note &&
        noteId == otherNote.noteId;
  }
}
