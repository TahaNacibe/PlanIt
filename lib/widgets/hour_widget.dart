import 'package:flutter/material.dart';
import 'package:plan_it/style/text_style.dart';

Widget hourWidget(String hour, void Function() action, int height,BuildContext context) {
  return Row(
    children: [
      Container(
          height: height * 1.1,
          width: 70,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.black.withOpacity(.5), width: .3),
              bottom:
                  BorderSide(color: Colors.black.withOpacity(.5), width: .3),
            ),
            color: Theme.of(context).canvasColor,
          ),
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              hour,
              style: textStyle,
            ),
          )),
    ],
  );
}
