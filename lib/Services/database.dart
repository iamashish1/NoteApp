import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meganotes/Models/note.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _notesCollection = _firestore.collection('notes');

class Database {
  // final String noteId;
  // Database(this.noteId);

  Future addItem({
    required String title,
    required String description,
  }) async {
    DocumentReference documentReferencer = _notesCollection.doc();

    if (title.isNotEmpty || description.isNotEmpty) {
      Map<String, dynamic> data = <String, dynamic>{
        "title": title.isEmpty ? 'No Title' : title,
        "description": description,
        "id": documentReferencer.id,
      };
      await documentReferencer
          .set(data)
          .whenComplete(() => print("Notes item added to the database"))
          .catchError((e) => print(e));
    } else
      return;
  }

  Stream<List<Note>> readItems() {
    var snapshot = _notesCollection.snapshots();
    return snapshot.map(listOfNotes);
  }

  List<Note> listOfNotes(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) {
      return Note(
        id: e.get('id'),
        title: e.get('title'),
        description: e.get('description'),
      );
    }).toList();
  }

  Future<void> updateItem({
    required String title,
    required String description,
    required String dID,
  }) async {
    DocumentReference documentReferencer = _notesCollection.doc(dID);

    Map<String, dynamic> data = <String, dynamic>{
      "title": title,
      "description": description,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  Future<void> deleteItem({
    required String dID,
  }) async {
    DocumentReference documentReferencer = _notesCollection.doc(dID);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
