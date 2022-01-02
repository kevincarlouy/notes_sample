import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_sample/firebase_options.dart';
import 'package:notes_sample/model/note_model.dart';
import 'package:notes_sample/screens/add_note.dart';
import 'package:notes_sample/screens/edit_note.dart';
import 'package:notes_sample/screens/home.dart';
import 'package:notes_sample/screens/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => NotesModel(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null ? LoginScreen.routeName : MainScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
        AddNoteScreen.routeName: (context) => const AddNoteScreen(),
        EditNoteScreen.routeName: (context) => const EditNoteScreen(),
      },
    );
  }
}
