import 'package:chat/constants.dart';
// import 'package:chat/screens/calls/calls_hsitory_screen.dart';
import 'package:chat/screens/chats/components/body.dart';
import 'package:chat/screens/contacts/contact_picker_screen.dart';
import 'package:chat/screens/contacts/contacts_screen.dart';
import 'package:chat/screens/profile/profile_screen.dart';
import 'package:contact_picker/contact_picker.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[
    Body(),
    ContactsScrenState(),
    // CallsHistoryScreen(),
    ProfileScreen(),
  ];

  List<Widget> barButtonActionList = <Widget>[
    ContactPickerScreen(),
    ContactPickerScreen(),
    // ContactPickerScreen(),
    ContactPickerScreen(),
  ];

  List<String> appTitle = <String>[
    "Message",
    "Contacts",
    // "Calls",
    "Profile",
  ];

  List<Icon> iconList = <Icon>[
    Icon(Icons.add),
    Icon(Icons.search),
    // Icon(Icons.search),
    Icon(Icons.settings),
  ];

  String number, name;
  final ContactPicker contactPicker = new ContactPicker();

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
              _selectedIndex]), //buildAppBar(), //onpressed action to be implemented
      body: pageList[_selectedIndex], //Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
        BottomNavigationBarItem(icon: Icon(Icons.message), label: "Messages"),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
        // BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
        BottomNavigationBarItem(
          icon: CircleAvatar(
            radius: 14,
            backgroundImage: AssetImage("assets/images/user_2.png"),
          ),
          label: "Profile",
        ),
      ],
    );
  }

  Widget appBar(String text, Icon iconButton) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(text),
      actions: [
        IconButton(
          onPressed: () async {
            Contact contact = await contactPicker.selectContact();
            if (contact != null) {
              number = contact.phoneNumber.number;
              name = contact.fullName;
              print("contacts:");
              print(contact);
              setState(() {
                print("contact selected");
                print(contact.toString());
                // contact == null ? 'No contact selected' : contact.toString(),
              });
            }
            // switch (_selectedIndex) {
            //   case 0:
            //     Contact contact = await contactPicker.selectContact();
            //     if (contact != null) {
            //       number = contact.phoneNumber.number;
            //       name = contact.fullName;
            //       print("contacts:");
            //       print(contact);
            //       setState(() {
            //         print("contact selected");
            //         print(contact.toString());
            //         // contact == null ? 'No contact selected' : contact.toString(),
            //       });
            //     }
            //     break;
            //   default:
            //     // () => Navigator.push(
            //     //       context,
            //     //       MaterialPageRoute(
            //     //         builder: (context) =>
            //     //             barButtonActionList[_selectedIndex],
            //     //         fullscreenDialog: true,
            //     //       ),
            //     //     );
            //     break;
            // }
          },
          // onPressed: () => Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => barButtonActionList[_selectedIndex],
          //     fullscreenDialog: true,
          //   ),
          // ),
          icon: iconButton,
        ),
      ],
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
