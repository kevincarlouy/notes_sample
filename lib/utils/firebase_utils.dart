import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:notes_sample/model/note.dart';
import 'package:notes_sample/model/note_model.dart';

class FirebaseUserUtils {
  late final CollectionReference<Note> _notesCollection;
  late User _user;
  static FirebaseUserUtils? _instance;
  StreamSubscription? _notesCollectionStream;

  FirebaseUserUtils.createWithUserId({required String userId}) {
    _user = FirebaseAuth.instance.currentUser!;
    _notesCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('notes')
        .withConverter<Note>(
          fromFirestore: (snapshot, _) =>
              Note.fromFirebaseData(snapshot.id, snapshot.data()!),
          toFirestore: (movie, _) => movie.toFirebaseData(),
        );
  }

  static FirebaseUserUtils get instance {
    if (_instance == null) {
      var curUser = FirebaseAuth.instance.currentUser;
      if (curUser == null) {
        throw Exception("Login first using the provided constructors!");
      } else {
        final newInstance =
            FirebaseUserUtils.createWithUserId(userId: curUser.uid);
        _instance = newInstance;
        return newInstance;
      }
    } else {
      return _instance!;
    }
  }

  User get user => _user;

  static Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    final user = userCred.user;

    if (user != null) {
      _instance = FirebaseUserUtils.createWithUserId(userId: user.uid);
      return true;
    }

    //return true if user is !=null which means that user has successfully logged in
    return false;
  }

  void setNote(Note note) {
    _notesCollection
        .doc(note.noteId)
        .set(note)
        .then((value) => debugPrint("Set note ${note.noteId}"))
        .catchError(
            (error) => {debugPrint("Error adding note: ${error.toString()}")});
  }

  void deleteNote(String noteId) {
    _notesCollection
        .doc(noteId.toString())
        .delete()
        .then((value) => debugPrint("Deleted note ${noteId.toString()}"))
        .catchError(
            (error) => {debugPrint("Error adding note: ${error.toString()}")});
  }

  void subscibeNotes(Function(List<Note> noes) onSnapshot) {
    _notesCollectionStream = _notesCollection.snapshots().listen((snapshot) {
      final notes =
          snapshot.docs.map<Note>((document) => document.data()).toList();
      onSnapshot(notes);
    });
  }

  void stopSubscribeNotes() {
    _notesCollectionStream?.cancel();
  }

  Future<Note> getNoteById(String noteId) async {
    DocumentSnapshot document = await _notesCollection.doc(noteId).get();
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    return Note.fromFirebaseData(document.id, data);
  }
}
