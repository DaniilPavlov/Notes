import 'package:flutter/material.dart';
import 'package:my_notes/model/db_wrapper.dart';
import 'package:my_notes/utils/utils.dart';

class Popup extends StatelessWidget {
  Function getTodosAndDones;

  Popup({this.getTodosAndDones});

  @override
  Widget build(BuildContext context) {

    return PopupMenuButton<int>(
        elevation: 4,
        icon: Icon(Icons.more_vert),
        onSelected: (value) {
          print('Selected value: $value');
          if (value == moreOptionValues.clearAll.index) {
            Utils.showCustomDialog(context,
                title: 'Are you sure?',
                msg: 'All done todos will be deleted permanently',
                onConfirm: () {
              DBWrapper.sharedInstance.deleteAllDoneTodos();
              getTodosAndDones();
            });
          } else if (value == moreOptionValues.about.index) {
            // TODO ABOUT
          }
        },
        itemBuilder: (context) {
          List list = List<PopupMenuEntry<int>>();
          for (int i = 0; i < moreOptionMap.length; ++i) {
            list.add(PopupMenuItem(value: i, child: Text(moreOptionMap[i])));
          }
          return list;
        });
  }
}
