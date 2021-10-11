import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField({
    Key? key,
    required this.fieldName,
    required this.controller,
    this.autofillHints,
    this.isEnable = true,
    this.onTap,
  }) : super(key: key);

  final String fieldName;
  final TextEditingController controller;
  final List<String>? autofillHints;
  final void Function()? onTap;
  final bool isEnable;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(fieldName,
                style: const TextStyle(
                  fontSize: 16,
                )),
          ),
          Expanded(
            child: TextField(
              enabled: isEnable,
              onTap: onTap,
              autofillHints: autofillHints,
              controller: controller,
              decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(),
              ),
            ),
          )
        ],
      ),
    );
  }
}
