import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plan_it/models/item.dart';
import 'package:plan_it/services/storage_services.dart';
import 'package:plan_it/shared/items_list.dart';
import 'package:plan_it/style/shadow_box.dart';
import 'package:plan_it/style/text_style.dart';
import 'package:plan_it/widgets/active_button.dart';
import 'package:plan_it/widgets/text_field.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

void newItem(BuildContext context, int globalIndex, void Function() refresh) {
  TextEditingController titleEditingController = TextEditingController();
  TextEditingController descEditingController = TextEditingController();
  int colorIndex = 0;
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "New Entry",
                        style: TextStyle(
                          fontFamily: "Quick",
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      activeButton(() {
                        if (titleEditingController.text.isNotEmpty) {
                          if (startDate != endDate) {
                            Item item = Item(
                                name: titleEditingController.text,
                                description: descEditingController.text,
                                start: startDate,
                                end: endDate,
                                color: colors[colorIndex]);
                            weekDays[globalIndex].tasks.add(item);
                            saveDaysList(weekDays);
                            Navigator.pop(context);
                            refresh();
                          }
                        }
                      }, "Save"),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: textInput(
                    titleEditingController,
                    context,
                    "Title",
                    false,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: textInput(
                    descEditingController,
                    context,
                    "Description",
                    true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Theme.of(context).canvasColor,
                      boxShadow: [shadow],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Start At",
                          style: textStyle,
                        ),
                        TimePickerSpinnerPopUp(
                          use24hFormat: false,
                          mode: CupertinoDatePickerMode.time,
                          initTime: startDate,
                          onChange: (dateTime) {
                            print(dateTime);
                            startDate = dateTime;
                            setState(() {});
                            // Implement your logic with selected dateTime
                          },
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "End At",
                          style: textStyle,
                        ),
                        TimePickerSpinnerPopUp(
                          mode: CupertinoDatePickerMode.time,
                          use24hFormat: false,
                          initTime: endDate,
                          onChange: (dateTime) {
                            endDate = dateTime;
                            setState(() {});
                            // Implement your logic with selected dateTime
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Set a Color:",
                    style: textStyle,
                  ),
                ),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: colors.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            colorIndex = index;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: colors[index],
                                ),
                              ),
                              if (index == colorIndex)
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).canvasColor.withOpacity(0.8),
                                  ),
                                  child: Icon(
                                    Icons.check,
                                    color: colors[index],
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}
