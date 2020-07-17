import 'package:flutter/material.dart';
import 'dart:io';
import 'package:my_notes/utils/colors.dart';

String good = "Good ";

enum moreOptionValues {
  clearAll,
  about,
}

Map<int, String> moreOptionMap = {
  moreOptionValues.clearAll.index: 'Clear Done',
  moreOptionValues.about.index: 'About',
};

class Utils {
  static void hideKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  static String getWelcomeMessage() {
    final hour = DateTime.now().hour;
    String msg;

    if (hour < 12) {
      msg = 'morning';
    } else if (hour < 18) {
      msg = 'afternoon';
    } else {
      msg = 'evening';
    }

    return msg;
  }

  static void showCustomDialog(BuildContext context,
      {String title,
      String msg,
      String noClear: 'No',
      Function onConfirm,
      String yesClear: 'Yes'}) {
    final dialog = AlertDialog(
      title: Text(title),
      content: Text(msg),
      actions: <Widget>[
        if (onConfirm != null)
          RaisedButton(
            color: Color(ToDosColor.secondaryColorInt),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              noClear,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        RaisedButton(
          color: Color(ToDosColor.primaryColorInt),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(
            yesClear,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }
}
