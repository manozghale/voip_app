import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/AddNewContact.dart';
import 'package:chat/screens/add_contacts/add_new_contact_screen.dart';
import 'package:chat/screens/call_forwarding/call_forwarding_screen.dart';
import 'package:chat/screens/changePassword/change_password_screen.dart';
import 'package:chat/screens/contacts/user_contact_list_screen.dart';
import 'package:chat/screens/signinOrSignup/signin_or_signup_screen.dart';
import 'package:chat/services/user_defaults.dart';
import 'package:flutter/material.dart';

import 'components/info.dart';
import 'components/profile_pic.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData user = UserData();
  List<String> listData = [
    'Call Forwarding',
    'Add Contact',
    'Edit Contact',
    'Change password',
    'Sign Out'
  ];

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async {
    // Get all contacts (fully fetched)
    // call api services
    UserData value = await UserDefaults.getUser();
    setState(() {
      user = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 0.5,
            height: 1,
            color: kPrimaryColor,
          );
        },
        shrinkWrap: true,
        itemCount: listData.length,
        itemBuilder: (context, index) {
          // ContactModel contact = contacts[index];
          // var contact = listData[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(
                horizontal: kDefaultPadding, vertical: kDefaultPadding / 2),

            onTap: () {
              switch (index) {
                case 0:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // fullscreenDialog: true,
                      builder: (context) => CallForwardingScreen(),
                    ),
                  );
                  break;
                case 1:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // fullscreenDialog: true,
                      builder: (context) => AddNewContactScreen(),
                    ),
                  );
                  break;
                case 2:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // fullscreenDialog: true,
                      builder: (context) => UserContactList(),
                    ),
                  );
                  break;
                case 3:
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // fullscreenDialog: true,
                      builder: (context) => ChangePasswordScreen(),
                    ),
                  );
                  break;
                default:
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _buildPopupDialog(context),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     // fullscreenDialog: true,
                  //     builder: (context) => ChangePasswordScreen(),
                  //   ),
                  // );
                  break;
              }
            },
            title: Text(listData[index]),
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
    // return Scaffold(
    //   // appBar: AppBar(
    //   //   title: Text("Profile"),
    //   //   actions: [
    //   //     IconButton(
    //   //       icon: Icon(Icons.settings_outlined),
    //   //       onPressed: () {},
    //   //     )
    //   //   ],
    //   // ),
    //   body: SingleChildScrollView(
    //     padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
    //     child: Column(
    //       children: [
    //         ProfilePic(image: "assets/images/user_avatar.png"),
    //         Text(
    //           "John Doe",
    //           style: Theme.of(context).textTheme.headline6,
    //         ),
    //         Divider(height: kDefaultPadding * 2),
    //         Info(
    //           infoKey: "User ID",
    //           info: "",
    //         ),
    //         Info(
    //           infoKey: "Location",
    //           info: "",
    //         ),
    //         Info(
    //           infoKey: "Phone",
    //           info: "",
    //         ),
    //         Info(
    //           infoKey: "Email Address",
    //           info: "", //user.emailAddress,
    //         ),
    //         SizedBox(height: kDefaultPadding),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: SizedBox(
    //                 width: 150,
    //                 child: PrimaryButton(
    //                   padding: EdgeInsets.all(5),
    //                   text: "Call forwarding",
    //                   press: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => CallForwardingScreen(),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: kDefaultPadding),
    //             Align(
    //               alignment: Alignment.centerRight,
    //               child: SizedBox(
    //                 width: 160,
    //                 child: PrimaryButton(
    //                   padding: EdgeInsets.all(5),
    //                   text: "Change Password",
    //                   press: () {
    //                     Navigator.push(
    //                       context,
    //                       MaterialPageRoute(
    //                         builder: (context) => ChangePasswordScreen(),
    //                       ),
    //                     );
    //                   },
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    title: const Text('Sign Out'),
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Are you sure you want to sign out?"),
      ],
    ),
    actions: <Widget>[
      new TextButton(
        onPressed: () {
          // dismiss popup
          Navigator.of(context).pop();
          // clear userdefaults
          UserDefaults.removeUser();
          // navigate to login view
          Navigator.of(context).pushAndRemoveUntil(
              new MaterialPageRoute(
                  builder: (context) => new SigninOrSignupScreen()),
              (route) => false);
        },
        child: Text(
          'OK',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
      new TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        // textColor: Theme.of(context).primaryColor,
        child: Text(
          'Cancel',
          style: TextStyle(color: Theme.of(context).primaryColor),
        ),
      ),
    ],
  );
}
