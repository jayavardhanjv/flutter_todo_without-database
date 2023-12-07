import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> MyError(
  BuildContext context,
  String text,
  String title,
) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          actions: [
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      });
}
