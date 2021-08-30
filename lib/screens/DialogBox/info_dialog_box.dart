import 'package:flutter/material.dart';

class InfoDialogBox extends StatelessWidget {
  const InfoDialogBox({
    Key key,
    this.boxTitle,
    this.boxContent,
  }) : super(key: key);

  final boxTitle;
  final boxContent;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(boxTitle),
          content: Text(boxContent),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        ),
      ),
      // child: const Text('Show Dialog'),
    );
  }
}
