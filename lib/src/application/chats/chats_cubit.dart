import 'package:chat/src/domain/models/messages/message_model.dart';
import 'package:chat/src/infrastructure/chat/chat_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chats_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  ChatCubit(this.chatRepo) : super(ChatInitial());
  CollectionReference messages = FirebaseFirestore.instance.collection("messageCollection");
  CollectionReference users = FirebaseFirestore.instance.collection("users");
  List<Message> messagesList = [];
  List<User> userList = [];

  Future<void> sendMessage({required String message, required String receiverId}) async {
    try {
      await chatRepo.sendMessage(receiverId: receiverId, message: message);
    } catch (_) {}
  }

  void getMessages() {
    messages.orderBy("createdAt", descending: true).snapshots().listen((event) {
      messagesList.clear();
      for (var doc in event.docs) {
        // messagesList.add(Message.fromJson(doc));
      }

      emit(ChatSuccess(messagesList: messagesList));
    });
  }
}
