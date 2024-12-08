import 'package:flutter/material.dart';
import 'package:plan_it/style/text_style.dart';

Widget textInput(
    TextEditingController controller, BuildContext context, String label,bool isExpanded) {
  return SizedBox(
    width: MediaQuery.sizeOf(context).width-50,
    height:isExpanded? MediaQuery.sizeOf(context).height/4 : null,
    child: TextField(
      maxLines: null,
      minLines: null,
      expands: isExpanded,
      textAlign: TextAlign.start,
      style: const TextStyle(
        fontFamily: "Quick",
        fontWeight: FontWeight.bold,
        fontSize: 18
      ),
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.withOpacity(.7),width: .5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.withOpacity(.7),width: .5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.withOpacity(.7),width: .5),
        ),
        label: Text(label,style: textStyle,),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.only(left: 8,top: 4,bottom: 4)
      ),
    ),
  );
}
