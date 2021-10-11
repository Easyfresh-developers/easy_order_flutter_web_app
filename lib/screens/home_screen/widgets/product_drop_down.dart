import 'package:flutter/material.dart';

class ProductDropDown extends StatelessWidget {
  const ProductDropDown({
    Key? key,
    required this.list,
    required this.currentValue,
    required this.onTap,
    this.validator,
  }) : super(key: key);
  final List<String> list;
  final String currentValue;
  final void Function(String? newValue) onTap;
  final dynamic validator;
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (FormFieldState<String> state) {
        return Expanded(
            flex: 3,
            child: InputDecorator(
              decoration: const InputDecoration(
                isCollapsed: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10, vertical: 5.5),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueAccent,
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(0),
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: currentValue,
                    isDense: true,
                    isExpanded: false,
                    onChanged: onTap,
                    items: list.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(value),
                            const Divider(
                              color: Colors.black,
                              height: 1,
                            ),
                            // Divider(),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
