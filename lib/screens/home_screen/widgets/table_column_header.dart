import 'package:flutter/material.dart';

class TableColumnHeader extends StatelessWidget {
  const TableColumnHeader({
    required this.flex,
    required this.text,
    this.alignment = TextAlign.center,
    Key? key,
  }) : super(key: key);
  final int flex;
  final String text;
  final TextAlign alignment;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: Text(
          text,
          textAlign: alignment,
          style: const TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ));
  }
}
