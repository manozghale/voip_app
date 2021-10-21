import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/MessageThread.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);

  // final ChatMessage message;
  final ThreadDatum message;

  bool get isSender {
    if (message.messageType == 'outbound') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75, vertical: kDefaultPadding / 2),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        message.messageBody,
        style: TextStyle(
            color: isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1.color),
      ),
    );
  }
}
