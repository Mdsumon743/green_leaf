import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FilterWidget extends StatefulWidget {
  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  int selectedIndex = 0;
  final List<String> options = ['All', 'Pending', 'Past'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: List.generate(options.length, (index) {
          bool isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => selectedIndex = index),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // Apply dark green to the selected item
                  color: isSelected ? const Color(0xFF0F4A11) : Colors.transparent,
                  // Keep outer corners rounded, keep internal borders straight
                  borderRadius: _getBorderRadius(index),
                  // Add a vertical divider line between non-selected items
                  border: index != 0 && !isSelected && selectedIndex != index - 1
                      ? Border(left: BorderSide(color: Colors.grey.shade300))
                      : null,
                ),
                child: Text(
                  options[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.blueGrey,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  BorderRadius _getBorderRadius(int index) {
    if (index == 0) {
      return BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8));
    } else if (index == options.length - 1) {
      return BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8));
    }
    return BorderRadius.zero;
  }
}