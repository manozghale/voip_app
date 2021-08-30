import 'dart:ffi';

import 'package:chat/components/circle_avatar_with_active_indicator.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:chat/constants.dart';

class ContactsScrenState extends StatefulWidget {
  const ContactsScrenState({Key key}) : super(key: key);

  @override
  _ContactsScrenStateState createState() => _ContactsScrenStateState();
}

class _ContactsScrenStateState extends State<ContactsScrenState> {
  List<Contact> contacts = [];

  @override
  Void initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    // Get all contacts (fully fetched)
    List<Contact> _contacts =
        (await ContactsService.getContacts(withThumbnails: true)).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),
            onTap: () {},
            leading: CircleAvatarWithActiveIndicator(
              image:
                  "assets/images/user_5.png", //contact.avatar, // use image data instead of image string
              isActive: index.isEven,
              radius: 28,
            ),
            title: Text(contact.displayName),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: kDefaultPadding / 2),
              child: Text(
                contact.phones.elementAt(0).value,
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

          // return ListTile(
          //   title: Text(contact.displayName),
          //   subtitle: Text(contact.phones.elementAt(0).value),
          // );
        },
      ),
    );
  }
}
