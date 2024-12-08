import 'package:flutter/material.dart';
import 'package:plan_it/style/shadow_box.dart';
import 'package:plan_it/style/text_style.dart';

Widget actionBar(String name, void Function() action) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [shadow]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            name,
            style: textStyle,
          ),
        ),
        IconButton(
            onPressed: () {
              action();
            },
            icon: const Icon(Icons.add))
      ],
    ),
  );
}
