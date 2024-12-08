import 'package:flutter/material.dart';

Widget activeButton(void Function() action, String name){
  return GestureDetector(
                          onTap: () {
                            action();
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
                            child: Text(
                              name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quick",
                                  fontSize: 18,
                                  color: Colors.white),
                            ),
                          ),
                        );
}