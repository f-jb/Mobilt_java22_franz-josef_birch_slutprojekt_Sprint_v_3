import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class ChatClient{
  final FirebaseDatabase _database;
  ChatClient(this._database);


  // sends message with current user and uses the servers timestamp
  Future<void> sendMessage(String message) async {
    await _database
        .ref()
    .child('chat')
    .push()
    .set({
      'user': FirebaseAuth.instance.currentUser!.email,
      'timestamp': ServerValue.timestamp,
      'message': message

    });
  }

  Stream<List<Map<String, dynamic>>>
  getMessages(){
    return _database
        .ref()
        .child('chat')
        .orderByChild('timestamp')
        .onValue
        .map(
            (event) => event.snapshot.children.map(
              // stupidly enough there is a bug in which the response from firebase is not valid JSON.
              // Took a long time to figure that one out. bah.
                    (child) => jsonDecode(jsonEncode(child.value)) as Map<String, dynamic>).toList());
  }




}