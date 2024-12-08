import 'package:flutter/material.dart';
import 'package:plan_it/keys/size_key.dart';
import 'package:plan_it/models/item.dart';
import 'package:plan_it/style/shadow_box.dart';
import 'package:plan_it/style/text_style.dart';

// Define a milk-like color
const Color milkLikeColor = Color(0xFFF5F5DC); // Light beige

Widget actionItem(Item item, void Function() action) {
  Duration difference = item.end.difference(item.start);
  double value = double.parse("${difference.inHours}.0");
  if (value < 0) {
    value = value * -1;
  }

  // Apply a milk-like tint over the original color
  Color itemColor = item.color.withOpacity(.4);
  Color milkLikeTintColor =
      milkLikeColor.withOpacity(0.5); // Adjust opacity as needed
  double height = cellSize * value;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      height: height >= 80? height : 90,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color:
            itemColor.withOpacity(0.5).blend(milkLikeTintColor), // Blend colors
        boxShadow: [
          BoxShadow(
              color: itemColor.withOpacity(.5),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(2, 0))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  item.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontFamily: "Quick",
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ),
              if(height != cellSize)
              Text(
                item.description,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(.5),
                  fontWeight: FontWeight.bold,
                  fontFamily: "Quick",
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

// Extension to blend two colors
extension ColorBlend on Color {
  Color blend(Color other) {
    return Color.fromARGB(
      (0.5 * this.alpha + 0.5 * other.alpha).toInt(),
      (0.5 * this.red + 0.5 * other.red).toInt(),
      (0.5 * this.green + 0.5 * other.green).toInt(),
      (0.5 * this.blue + 0.5 * other.blue).toInt(),
    );
  }
}
