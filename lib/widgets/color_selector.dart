import 'package:flutter/material.dart';

class ColorDropdown extends StatefulWidget {
  final Color? selectedColor;
  final ValueChanged<Color?> onChanged;

  const ColorDropdown({
    Key? key,
    required this.selectedColor,
    required this.onChanged,
  }) : super(key: key);

  @override
  _ColorDropdownState createState() => _ColorDropdownState();
}

class _ColorDropdownState extends State<ColorDropdown> {
  final List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
  ];

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Color>(
      value: widget.selectedColor,
      hint: const Text('Select a color'),
      onChanged: widget.onChanged,
      items: _colors.map<DropdownMenuItem<Color>>((Color color) {
        return DropdownMenuItem<Color>(
          value: color,
          child: Container(
            width: 100,
            height: 40,
            color: color,
            child: Center(
              child: Text(
                _colorName(color),
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  String _colorName(Color color) {
    if (color == Colors.red) return 'Red';
    if (color == Colors.green) return 'Green';
    if (color == Colors.blue) return 'Blue';
    if (color == Colors.yellow) return 'Yellow';
    if (color == Colors.orange) return 'Orange';
    if (color == Colors.purple) return 'Purple';
    return 'Unknown';
  }
}
