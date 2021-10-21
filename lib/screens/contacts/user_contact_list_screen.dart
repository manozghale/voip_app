import 'package:chat/models/GetContactList.dart';
import 'package:chat/screens/chats/add_new_chat_screen.dart';
import 'package:chat/screens/chats/chat_list_screen.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class UserContactList extends StatefulWidget {
  const UserContactList({Key key, this.tn}) : super(key: key);
  final String tn;

  @override
  _UserContactListState createState() => _UserContactListState();
}

class _UserContactListState extends State<UserContactList> {
  List<GetContactListData> contacts = [];
  @override
  void initState() {
    super.initState();
    getContactList();
  }

  getContactList() async {
    List<GetContactListData> _contacts =
        await UserDefaults.getUserContactList(widget.tn);
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('My Contact List', Icon(Icons.add)),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          // ContactModel contact = contacts[index];
          var contact = contacts[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  // fullscreenDialog: true,
                  builder: (context) => ChatListScreen(
                    tn: contact.tn,
                  ), //MessageScreen(), //
                ),
              );
            },
            // leading: CircleAvatarWithActiveIndicator(
            //   image:
            //       "assets/images/user_avatar.png", //contact.avatar, // use image data instead of image string
            //   isActive: index.isEven,
            //   radius: 28,
            // ),
            title: Text(contact.firstName),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding / 2),
              child: Text(
                contact.tn,
                style: TextStyle(
                  color: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .color
                      .withOpacity(0.64),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

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
              builder: (context) => AddNewChatScreen(),
            ),
          ),
          // },
          icon: iconButton,
        ),
      ],
    );
  }
}
