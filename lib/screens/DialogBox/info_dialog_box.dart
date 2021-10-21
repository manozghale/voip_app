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
    return new AlertDialog(
      title: const Text('Contact Admin'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Please contact admin for your password query"),
        ],
      ),
      actions: <Widget>[
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'OK',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
