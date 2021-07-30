import 'package:flutter/material.dart';
import 'package:meganotes/Services/database.dart';

class AddNote extends StatefulWidget {
  static const routeName = '/addNote';

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  // final Database _notes = Database();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo[50],
      appBar: AppBar(
        toolbarHeight: 150,
        backgroundColor: Colors.indigo,
        flexibleSpace: Container(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Add Note',
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.indigo,
        child: TextButton(
          onPressed: () async {
            await Database().addItem(
                title: titleController.text,
                description: descriptionController.text);

            // My AsyncTask is done and onPostExecute was called
            Navigator.pop(context);
          },
          child: Text(
            'Save Note',
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
                    hintText: 'Title', border: InputBorder.none),
              ),
            ),
            Expanded(
              flex: 3,
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: descriptionController,
                maxLines: 20,
                decoration: InputDecoration(
                    hintText: 'Description', border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
