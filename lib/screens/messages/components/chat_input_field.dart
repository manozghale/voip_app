import 'package:chat/models/Chat.dart';
import 'package:chat/models/MessageThread.dart';
import 'package:chat/models/SendSMS.dart';
import 'package:chat/screens/messages/components/body.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField(
      {Key key,
      this.tn,
      this.messageThread,
      this.messageDatum,
      this.messageSent,
      @required this.press})
      : super(key: key);

  final List<ThreadDatum> messageThread;
  final MessageDatum messageDatum;
  final String tn;
  final Function messageSent;
  final VoidCallback press;

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  TextEditingController myController = TextEditingController();
  SendSMSData smsData = SendSMSData();

  void sendMessage() async {
    // send message action here
    print('send button tapped ' + myController.text);
    print('tn: ${widget.tn}');
    print('number: ${widget.messageDatum.contactNumber}');
    if (myController.text.isNotEmpty) {
      SendSMSData _smsData = await UserDefaults.sendSMS(
          widget.tn, widget.messageDatum.contactNumber, myController.text);
      if (_smsData != null) {
        if (_smsData.status) {
          setState(() {
            smsData = _smsData;
            myController.clear();
            widget.press();
          });
        }
      }

      // demeChatMessages.add(ChatMessage(
      //   messageType: ChatMessageType.text,
      //   messageStatus: MessageStatus.not_view,
      //   isSender: true,
      // ));

      // print(demeChatMessages.toString());

      // setState(() {

      // });
    }
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
                      // onPressed: widget.press,
                      onPressed: () async {
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
