import 'package:easy_order_web_app/screens/home_screen/widgets/table_column_header.dart';
import 'package:flutter/material.dart';

class TableHeader extends StatelessWidget {
  const TableHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          TableColumnHeader(text: "Serial #", flex: 1),
          TableColumnHeader(text: "Product Name", flex: 3),
          TableColumnHeader(text: "Quantity", flex: 2),
          TableColumnHeader(text: "Unit", flex: 2),
          TableColumnHeader(text: "Unit Price", flex: 2),
          TableColumnHeader(text: "Total Price", flex: 2),
        ]);
  }
}
