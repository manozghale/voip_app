import 'package:chat/constants.dart';
import 'package:chat/models/Chat.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/MessageThread.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatefulWidget {
  const Body({Key key, this.tn, this.messageDatum, this.threadDatum})
      : super(key: key);

  final List<ThreadDatum> threadDatum;
  final MessageDatum messageDatum;
  final String tn;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ThreadDatum> messages = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      messages = widget.threadDatum;
    });
  }

  int get count {
    return messages.length > 0 ? messages.length : widget.threadDatum.length;
  }

  List<ThreadDatum> get reference {
    return messages.length > 0 ? messages : widget.threadDatum;
  }

  getAllMessage() async {
    List<ThreadDatum> _messages = await UserDefaults.getMessageThread(
        widget.tn, widget.messageDatum.contactNumber);
    setState(() {
      messages = _messages;

      print('updated messages: ${messages[0].messageBody}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ListView.builder(
              itemCount: count,
              itemBuilder: (context, index) =>
                  Message(message: reference[index]),
            ),
          ),
        ),
        ChatInputField(
          tn: widget.tn,
          messageThread: messages,
          messageDatum: widget.messageDatum,
          press: getAllMessage,
        ),
      ],
    );
  }
}
