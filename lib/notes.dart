import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/note.dart';
import 'noteitem.dart';

class Notes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final notes = Provider.of<List<Note>>(context);

    return ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(25)),
                child: NoteItem(notes[index])),
          );
        });
  }
}
