import 'package:flutter/material.dart';
import 'package:meganotes/Models/note.dart';
import 'package:meganotes/Services/database.dart';
import 'package:provider/provider.dart';

class EditNote extends StatefulWidget {
  static const routeName = '/editnote';

  @override
  _EditNoteState createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  // final Database _notes = Database();

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) return SizedBox.shrink();
    final noteID = route.settings.arguments;
    final note = Provider.of<List<Note>>(context)
        .firstWhere((element) => noteID == element.id);
    final titleController = TextEditingController(text: note.title);
    final descriptionController = TextEditingController(text: note.description);
    @override
    void dispose() {
      super.dispose();
      titleController.dispose();
      descriptionController.dispose();
    }

    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.indigo,
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text('Edit Note',
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: TextButton(
          onPressed: () async {
            await Database().updateItem(
                title: titleController.text,
                description: descriptionController.text,
                dID: noteID.toString());
            dispose();

            // My AsyncTask is done and onPostExecute was called
            Navigator.pop(context);
          },
          child: Text(
            'Save Change',
            style: TextStyle(
                fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: note.title, border: InputBorder.none),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                maxLines: 20,
                decoration: InputDecoration(
                    hintText: note.description, border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
