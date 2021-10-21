import 'dart:convert';

import 'package:chat/components/circle_avatar_with_active_indicator.dart';
import 'package:chat/screens/chats/chat_list_screen.dart';
import 'package:chat/services/url_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chat/constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ContactsScrenState extends StatefulWidget {
  const ContactsScrenState({Key key}) : super(key: key);

  @override
  _ContactsScrenStateState createState() => _ContactsScrenStateState();
}

class _ContactsScrenStateState extends State<ContactsScrenState> {
  // List<Contact> contacts = [];
  // List<ContactModel> contacts = [];
  dynamic contacts = [];

  @override
  initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    // Get all contacts (fully fetched)
    // call api services
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var getApiKey = prefs.getString(apiKey);
    var getUserId = prefs.getInt(userId);
    var getSessionToken = prefs.getString(sessionToken);

    print(getApiKey);
    var response = await http.post(baseUrl, body: {
      'appAction': 'getUserPhoneNumbers',
      'apiKey': getApiKey,
      'userID': getUserId.toString(),
      'token': getSessionToken
    });

    // List<ContactModel> _user = jsonDecode(response.body);
    Map<String, dynamic> userMap = jsonDecode(response.body);
    print('response: $userMap');

    setState(() {
      if (!userMap['error']) {
        var array = userMap['data'];
        print('userMap: $array');
        // List<ContactModel> userList =
        //     List<ContactModel>.from(array); //userMap['data'];
        // List<ContactModel> data = userMap['data'];
        contacts = userMap['data'];
        print(array[0]['displayNumber']);
      }
    });

    // List<Contact> _contacts =
    //     (await ContactsService.getContacts(withThumbnails: true)).toList();
    // setState(() {
    //   contacts = _contacts;
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                CupertinoPageRoute(
                  // fullscreenDialog: true,
                  builder: (context) => ChatListScreen(
                    tn: contact['tn'],
                  ), //MessageScreen(), //
                ),
              );
            },
            leading: CircleAvatarWithActiveIndicator(
              image:
                  "assets/images/user_avatar.png", //contact.avatar, // use image data instead of image string
              isActive: index.isEven,
              radius: 28,
            ),
            title: Text(contact['tn']),
            // subtitle: Padding(
            //   padding: const EdgeInsets.only(top: kDefaultPadding / 2),
            //   child: Text(
            //     contact.phones.elementAt(0).value,
            //     contact.
            //     style: TextStyle(
            //       color: Theme.of(context)
            //           .textTheme
            //           .bodyText1
            //           .color
            //           .withOpacity(0.64),
            //     ),
            //   ),
            // ),
          );
        },
      ),
    );
  }
}
