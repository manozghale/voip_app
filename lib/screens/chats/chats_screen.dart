import 'package:chat/constants.dart';
import 'package:chat/screens/contacts/contacts_screen.dart';
import 'package:chat/screens/contacts/user_contact_list_screen.dart';
import 'package:chat/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[
    // ChatListScreen(),
    ContactsScrenState(),
    // CallsHistoryScreen(),
    ProfileScreen(),
  ];

  // List<Widget> barButtonActionList = <Widget>[
  //   // ContactPickerScreen(),
  //   ContactPickerScreen(),
  //   // ContactPickerScreen(),
  //   ContactPickerScreen(),
  // ];

  List<String> appTitle = <String>[
    // "Message",
    "My Numbers",
    // "Calls",
    "Profile",
  ];

  List<Icon> iconList = <Icon>[
    // Icon(Icons.add),
    Icon(Icons.add),
    // Icon(Icons.search),
    Icon(Icons.settings),
  ];

  String number, name;

  @override
  void initState() {
    number = "";
    name = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
          appTitle[_selectedIndex],
          iconList[
              _selectedIndex]), //buildAppBar(), //iconlist is disabled in appBar
      body: pageList[_selectedIndex], //Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                UserContactList(), //AddNewChatScreen(), //MessageScreen(), //
            // fullscreenDialog: true,
          ),
        ),
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.person_add_alt_1,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
          print(_selectedIndex);
        });
      },
      items: [
        // BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
        // BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          // CircleAvatar(
          //   radius: 14,
          //   backgroundImage: AssetImage("assets/images/user_2.png"),
          // ),
          label: "Profile",
        ),
      ],
    );
  }

  Widget appBar(String text, Icon iconButton) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(text),
      // uncomment if needed -> shows actionable icon in right side of nav bar

      // actions: [
      //   IconButton(
      //     onPressed: () async {
      //       Contact contact = await contactPicker.selectContact();
      //       if (contact != null) {
      //         number = contact.phoneNumber.number;
      //         name = contact.fullName;
      //         setState(() {
      //           // contact == null ? 'No contact selected' : contact.toString(),
      //         });
      //       }
      //     },
      //     icon: iconButton,
      //   ),
      // ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text("Messages"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.search),
        ),
      ],
    );
  }
}
