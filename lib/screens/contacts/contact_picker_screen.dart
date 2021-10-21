// import 'package:flutter/material.dart';
// import 'package:contact_picker/contact_picker.dart';

// class ContactPickerScreen extends StatefulWidget {
//   @override
//   _ContactPickerScreenState createState() => _ContactPickerScreenState();
// }

// class _ContactPickerScreenState extends State<ContactPickerScreen> {
//   String number, name;
//   final ContactPicker contactPicker = new ContactPicker();
//   Contact _contact;

//   @override
//   void initState() {
//     number = "";
//     name = "";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: "Test App",
//         home: Scaffold(
//           appBar: AppBar(
//               title: Text("Single Contact Picker"),
//               backgroundColor: Colors.redAccent),
//           body: Container(
//             padding: EdgeInsets.all(20),
//             color: Colors.purple.shade50,
//             child: Column(
//               children: [
//                 Text("Phone Number: $number"),
//                 Text("Name: $name"),
//                 Divider(),
//                 Container(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       Contact contact = await contactPicker.selectContact();
//                       if (contact != null) {
//                         number = contact.phoneNumber.number;
//                         name = contact.fullName;
//                         print("contact selected");
//                         print(contact);
//                         setState(() {
//                           print("contact selected");
//                           print(contact);
//                           _contact = contact;
//                         });
//                       }
//                     },
//                     child: new Text(
//                       _contact == null
//                           ? 'No contact selected'
//                           : _contact.toString(),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ));
//   }
// }
