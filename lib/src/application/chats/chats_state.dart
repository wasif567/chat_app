part of 'chats_cubit.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  List<Message> messagesList;
  ChatSuccess({required this.messagesList});
}

class ChatUsers extends ChatState {
  List<User> usersList;
  ChatUsers({required this.usersList});
}
