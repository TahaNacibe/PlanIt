import 'package:flutter/material.dart';
import 'package:plan_it/services/time_services.dart';

Widget dayWidget(
    String name, int index, int globalIndex, void Function() action,BuildContext context) {
  Map<String, int> numbers = getDayNumber();
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: globalIndex == index ? Colors.indigo : Theme.of(context).canvasColor,
        border: globalIndex == index
            ? Border.all(color: Theme.of(context).canvasColor, width: .5)
            : null,
        boxShadow: [
          BoxShadow(
              color:globalIndex == index? Colors.indigo.withOpacity(.1) : Colors.transparent,
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(3, 0))
        ]),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(children: [
          TextSpan(text: "$name\n"),
          TextSpan(
              text: numbers[name].toString(),
              style: const TextStyle(fontSize: 22)),
        ]),
        style: TextStyle(
            fontFamily: "Quick",
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: index == globalIndex ? Colors.white : Theme.of(context).iconTheme.color),
      ),
    ),
  );
}
