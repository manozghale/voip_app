import 'package:chat/screens/messages/components/message.dart';
import 'package:flutter/material.dart';
import 'package:chat/models/ChatMessage.dart';
import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  // const ChatInputField({
  //   Key key,
  // }) : super(key: key);

  TextEditingController myController = TextEditingController();
  void sendMessage() {
    // send message action here
    print('send button tapped ' + myController.text);
    if (myController.text.isNotEmpty) {
      demeChatMessages.add(ChatMessage(
        messageType: ChatMessageType.text,
        messageStatus: MessageStatus.not_view,
        isSender: true,
      ));

      print(demeChatMessages.toString());
      for (var item in demeChatMessages) {}

      // setState(() {

      // });
    }
    myController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: Color(0xFF087949).withOpacity(0.08),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Icon(Icons.mic, color: kPrimaryColor),
            SizedBox(width: kDefaultPadding),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding * 0.75,
                ),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: kDefaultPadding / 4),
                    Expanded(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                          fillColor: Colors.transparent,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMessage();
                      },
                      icon: Icon(
                        Icons.send,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                    ),

                    // Icon(
                    //   Icons.send,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),

                    // Icon(
                    //   Icons.attach_file,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                    // SizedBox(width: kDefaultPadding / 4),
                    // Icon(
                    //   Icons.camera_alt_outlined,
                    //   color: Theme.of(context)
                    //       .textTheme
                    //       .bodyText1
                    //       .color
                    //       .withOpacity(0.64),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
