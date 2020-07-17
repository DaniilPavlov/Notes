import 'package:flutter/material.dart';
import 'package:my_notes/utils/colors.dart';

class SharedWidget {
  static Widget getCardHeader(
      {@required BuildContext context,
      @required String text,
      Color textColor = Colors.white,
      int backgroundColorCode = ToDosColor.primaryColorInt,
      double customFontSize}) {
    customFontSize ??= Theme.of(context).textTheme.headline6.fontSize;

    return Container(
      width: 85,
      alignment: AlignmentDirectional.center,
      margin: EdgeInsets.only(left: 40),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color(backgroundColorCode),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: textColor,
          fontSize: customFontSize,
        ),
      ),
    );
  }

  static Widget getOnDismissDeleteBackground() {
    return Container(
      alignment: Alignment.centerRight,
      color: Color.fromARGB(200, 205, 92, 92),
      padding: EdgeInsets.only(right: 10),
      child: Text(
        'SWIPE LEFT TO DELETE',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
