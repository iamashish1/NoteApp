import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:meganotes/Screens/addnote.dart';
import 'package:meganotes/notes.dart';
import 'package:provider/provider.dart';

import 'Models/note.dart';
import 'Screens/editnote.dart';
import 'Services/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Center(child: Text('Cant Load the app'));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<List<Note>>.value(
            value: Database().readItems(),
            initialData: [],
            child: MaterialApp(
              home: Builder(
                builder: (context) => Scaffold(
                  body: Scaffold(
                    backgroundColor: Colors.indigo[50],
                    appBar: AppBar(
                      toolbarHeight: 150,
                      backgroundColor: Colors.indigo,
                      flexibleSpace: Container(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text('Notes',
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500)),
                          )),
                    ),
                    bottomNavigationBar: BottomAppBar(
                      color: Colors.indigo,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddNote.routeName);
                        },
                        child: Text(
                          'Add Note',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    body: Notes(),
                  ),
                ),
              ),
              routes: <String, WidgetBuilder>{
                AddNote.routeName: (context) => AddNote(),
                EditNote.routeName: (context) => EditNote(),
              },
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return CircularProgressIndicator();
      },
    );
  }
}
