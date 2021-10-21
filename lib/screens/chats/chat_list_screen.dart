import 'dart:convert';

import 'package:chat/components/filled_outline_button.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/GetContactList.dart';
import 'package:chat/screens/contacts/contacts_screen.dart';
import 'package:chat/screens/contacts/user_contact_list_screen.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:chat/services/url_constants.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
import 'components/chat_card.dart';
import 'package:http/http.dart' as http;

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({
    Key key,
    this.tn,
  }) : super(key: key);

  final String tn;

  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  List<MessageDatum> messageList = [];

  getMessageList() async {
    List<MessageDatum> _messageList =
        await UserDefaults.getMessageList(widget.tn);
    print('_message setstate: $_messageList');
    setState(() {
      messageList = _messageList;
      print('message setstate: $messageList');
    });
  }

  @override
  void initState() {
    super.initState();
    getMessageList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(
        widget.tn,
        Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messageList.length,
              itemBuilder: (context, index) => ChatCard(
                chat: messageList[index],
                press: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MessageScreen(
                      tn: widget.tn,
                      thread: messageList[index],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget appBar(String text) {
  //   return AppBar(
  //     automaticallyImplyLeading: true,
  //     title: Text(text),
  //   );
  // }

  Widget appBar(String text, Icon iconButton) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(text),
      // uncomment if needed -> shows actionable icon in right side of nav bar

      actions: [
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserContactList(),
            ),
          ),
          // },
          icon: iconButton,
        ),
      ],
    );
  }
}
