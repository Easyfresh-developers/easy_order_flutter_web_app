import 'package:easy_order_web_app/screens/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  const CustomTableCell({
    this.controller,
    required this.flex,
    this.isTotalColumn = false,
    required this.index,
    Key? key,
  }) : super(key: key);
  final int flex;
  final TextEditingController? controller;
  final bool isTotalColumn;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: flex,
        child: TextFormField(
          textAlign: TextAlign.center,
          enabled: isTotalColumn ? false : true,
          onChanged: (value) {
            HomeScreenController.to.productPrice(index);
            HomeScreenController.to.setTotalPrice();
            // if (isTotalColumn) {

            // }
            //   if (value != "") {
            //     Get.find<HomeScreenController>()
            //         .increaseTotalPrice(int.parse(value));
            //   }
            // }
          },
          // initialValue: "1",
          controller: controller,
          decoration: const InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.blueAccent,
                width: 0.5,
              ),
              borderRadius: BorderRadius.all(Radius.circular(0)),
            ),
          ),
        ));
  }
}
