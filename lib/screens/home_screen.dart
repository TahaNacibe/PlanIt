import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:plan_it/dialog/delete_dialog.dart';
import 'package:plan_it/dialog/new_entrey.dart';
import 'package:plan_it/models/item.dart';
import 'package:plan_it/provider/theme_provider.dart';
import 'package:plan_it/services/storage_services.dart';
import 'package:plan_it/services/time_services.dart';
import 'package:plan_it/shared/items_list.dart';
import 'package:plan_it/widgets/action_item.dart';
import 'package:plan_it/widgets/day_widget.dart';
import 'package:plan_it/widgets/hour_widget.dart';
import 'package:provider/provider.dart';

class SchedularPage extends StatefulWidget {
  const SchedularPage({super.key});

  @override
  State<SchedularPage> createState() => _SchedularPageState();
}

class _SchedularPageState extends State<SchedularPage> {
  int globalIndex = dayNames.indexOf(getCurrentDay());
  List<String> dayHours = getAllDayHours();
  final ScrollController _timeSlotController = ScrollController();
  final ScrollController _taskController = ScrollController();

  @override
  void initState() {
    super.initState();

    _timeSlotController.addListener(() {
      double offset = _timeSlotController.offset;
      if (_taskController.hasClients) {
        _taskController.animateTo(offset,
            duration: const Duration(milliseconds: 1), curve: Curves.linear);
      }
    });

    _taskController.addListener(() {
      double offset = _taskController.offset;
      if (_timeSlotController.hasClients) {
        _timeSlotController.animateTo(offset,
            duration: const Duration(milliseconds: 1), curve: Curves.linear);
      }
    });
  }

  @override
  void dispose() {
    _timeSlotController.dispose();
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              themeProvider.updateThemeBasedOnBool(isDarkMood);
              isDarkMood = !isDarkMood;
            },
            icon: isDarkMood
                ? const Icon(Icons.light_mode)
                : const Icon(Icons.dark_mode)),
        backgroundColor: Theme.of(context).canvasColor,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(25)),
                color: Theme.of(context).appBarTheme.backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Today",
                          style: TextStyle(
                              fontFamily: "Quick",
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        GestureDetector(
                          onTap: () {
                            newItem(context, globalIndex, () {
                              setState(() {});
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: Colors.indigo,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.indigo.withOpacity(.2),
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                      offset: const Offset(3, 0))
                                ]),
                            child: const Text(
                              "New Task",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quick",
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        )
                      ],
                    ),
                    Text(qut,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Quick",
                          color: Colors.grey.withOpacity(.8),
                          fontSize: 16,
                        )),
                    Text(formatDate(),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Quick",
                          fontSize: 22,
                        )),
                  ],
                ),
              ),
            )),
      ),
      body: Column(
        children: [
          // Week days horizontal list
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).canvasColor,
            ),
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: weekDays.length,
              itemBuilder: (context, parentIndex) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        globalIndex = parentIndex;
                      });
                    },
                    child: dayWidget(weekDays[parentIndex].day, parentIndex,
                        globalIndex, () {}, context),
                  ),
                );
              },
            ),
          ),
          DottedDashedLine(
            height: 0,
            width: MediaQuery.sizeOf(context).width,
            axis: Axis.horizontal,
            dashColor: Colors.grey.withOpacity(.5),
          ),
          // Time slots and tasks
          Expanded(
            child: Row(
              children: [
                // Time slots vertical list
                Container(
                  width: 80,
                  color: Theme.of(context).canvasColor,
                  child: ListView.builder(
                    controller: _timeSlotController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: dayHours.length + 1,
                    itemBuilder: (context, index) {
                      if (index == dayHours.length) {
                        return hourWidget("out of time", () {}, 500, context);
                      } else {
                        return hourWidget(dayHours[index], () {}, 70, context);
                      }
                    },
                  ),
                ),
                // Tasks vertical list aligned with time slots
                Expanded(
                  child: ListView.builder(
                    controller: _taskController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: dayHours.length,
                    itemBuilder: (context, index) {
                      final timeSlot = dayHours[index];
                      final tasks = _getTasksForTimeSlot(timeSlot);

                      if (tasks.isEmpty) {
                        return Container(
                          height: 80, // Adjust height to match time slot
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                  color: Colors.grey.withOpacity(.2)),
                            ),
                          ),
                        );
                      }

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: tasks.map((task) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Dismissible(
                              direction: DismissDirection.startToEnd,
                                confirmDismiss: (direction) async {
                                  return await showConfirmationDialog(context);
                                },
                                onDismissed: (_) {
                                  weekDays[globalIndex].tasks.remove(task);
                                  saveDaysList(weekDays);
                                  setState(() {});
                                },
                                key: Key("${task.name}${task.color}"),
                                child: actionItem(task, () {})),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int extraLength() {
    int totalHours = 0;
    for (var task in weekDays[globalIndex].tasks) {
      int quickMath = task.end.difference(task.start).inHours;
      totalHours += quickMath;
    }
    return totalHours;
  }

  // Get tasks for a specific time slot
  List<Item> _getTasksForTimeSlot(String timeSlot) {
    // Extract hour and minute from the timeSlot string
    final parts = timeSlot.split(':');
    if (parts.length != 2) return [];

    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1].split(' ')[0]);

    final isPM = timeSlot.contains('PM');
    if (isPM && hour != 12) {
      hour += 12;
    }
    if (!isPM && hour == 12) {
      hour = 0;
    }

    return weekDays[globalIndex].tasks.where((task) {
      final startHour = task.start.hour;
      const startMinute = 00;
      final endHour = task.start.hour;
      const endMinute = 00;

      return (startHour < hour ||
              (startHour == hour && startMinute <= minute)) &&
          (endHour > hour || (endHour == hour && endMinute >= minute));
    }).toList();
  }
}
