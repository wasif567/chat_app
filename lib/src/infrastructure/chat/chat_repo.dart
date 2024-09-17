import 'package:chat/src/domain/models/messages/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future sendMessage({required String receiverId, required String message}) async {
    try {
      final String currentUserId = _auth.currentUser!.uid;
      final String senderEmail = _auth.currentUser!.email!;
      final Timestamp timestamp = Timestamp.now();

      Message newMessage = Message(
          senderEmail: senderEmail,
          senderId: currentUserId,
          receiverId: receiverId,
          message: message,
          timestamp: timestamp);

      List<String> ids = [currentUserId, receiverId];
      ids.sort();

      String chatroomId = ids.join("_");

      await _firestore
          .collection("chat_rooms")
          .doc(chatroomId)
          .collection('messages')
          .add(newMessage.toMap());

      //
    } catch (_) {}
  }

  Future<Stream<QuerySnapshot<Object?>>> getMessages(String userId, String otherUserId) async {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatroomId = ids.join("_");

    return _firestore
        .collection("chat_rooms")
        .doc(chatroomId)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
