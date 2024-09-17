import 'package:chat/src/application/chats/chats_cubit.dart';
import 'package:chat/src/domain/models/messages/message_model.dart';
import 'package:chat/src/domain/models/register_user/register_user_model.dart';
import 'package:chat/src/presentation/pages/chat/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatelessWidget {
  final RegisterUserModel chatUser;
  ChatPage({super.key, required this.chatUser});

  final TextEditingController _controller = TextEditingController();

  final ScrollController _scorllController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final kSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(chatUser.fullName!),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
              List<Message> messagesList = BlocProvider.of<ChatCubit>(context).messagesList;
              return ListView.builder(
                  reverse: true,
                  controller: _scorllController,
                  itemCount: messagesList.length,
                  itemBuilder: (context, index) {
                    return messagesList[index].senderEmail == chatUser.email
                        ? ChatBuble(
                            message: messagesList[index],
                          )
                        : ChatBubleForFriend(message: messagesList[index]);
                  });
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _controller,
              onSubmitted: (data) {
                _sendMessage(message: data, receiverId: chatUser.id!, context: context);
              },
              decoration: InputDecoration(
                hintText: 'Send Message',
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.green),
                    onPressed: () {
                      //
                      _sendMessage(
                          message: _controller.text.trim(), receiverId: chatUser.id!, context: context);
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _sendMessage({required String message, required String receiverId, required BuildContext context}) {
    if (_controller.text.isNotEmpty) {
      BlocProvider.of<ChatCubit>(context).sendMessage(message: message, receiverId: receiverId);
      _controller.clear();
      _scorllController.animateTo(0, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
    }
  }
}
