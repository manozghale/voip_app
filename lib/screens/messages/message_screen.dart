import 'package:chat/models/Chat.dart';
import 'package:chat/models/MessageThread.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({
    Key key,
    this.tn,
    this.thread,
  }) : super(key: key);

  final String tn;
  final MessageDatum thread;
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  List<ThreadDatum> messages = [];
  String updatedMessage = '';
  @override
  void initState() {
    super.initState();
    getAllMessage();
  }

  getAllMessage() async {
    List<ThreadDatum> _messages = await UserDefaults.getMessageThread(
        widget.tn, widget.thread.contactNumber);
    setState(() {
      messages = _messages;
    });
  }

  String get userName {
    return widget.thread.contactName.isEmpty
        ? widget.thread.contactNumber
        : widget.thread.contactName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(
        tn: widget.tn,
        messageDatum: widget.thread,
        threadDatum: messages,
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          // CircleAvatar(
          //   backgroundImage: AssetImage("assets/images/user_2.png"),
          // ),
          // SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 16),
              ),
              // Text(
              //   "Active 3m ago",
              //   style: TextStyle(fontSize: 12),
              // )
            ],
          )
        ],
      ),

      // Not for now - for furthur use
      // actions: [
      //   IconButton(
      //     icon: Icon(Icons.local_phone),
      //     onPressed: () {},
      //   ),
      //   IconButton(
      //     icon: Icon(Icons.videocam),
      //     onPressed: () {},
      //   ),
      //   SizedBox(width: kDefaultPadding / 2),
      // ],
    );
  }
}
