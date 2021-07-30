import 'package:flutter/material.dart';
import 'package:meganotes/Services/database.dart';

import 'Models/note.dart';
import 'Screens/editnote.dart';

class NoteItem extends StatelessWidget {
  final Note note;
  NoteItem(this.note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(EditNote.routeName, arguments: note.id);
      },
      child: Container(
        height: 125,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 100,
                        child: Text(
                          note.title,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                      Container(
                        width: 200,
                        child: Text(
                          note.description,
                          style: TextStyle(
                            color: Colors.black38,
                          ),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    // style: ButtonStyle(
                    //     backgroundColor: MaterialStateProperty.all(Colors.red)),
                    onPressed: () {
                      Database().deleteItem(dID: note.id);
                    },
                    icon: Icon(Icons.delete, color: Colors.indigo[900]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
