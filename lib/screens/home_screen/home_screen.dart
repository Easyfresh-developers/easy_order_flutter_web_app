import 'package:easy_order_web_app/constants.dart';
import 'package:easy_order_web_app/screens/home_screen/home_screen_controller.dart';
import 'package:easy_order_web_app/screens/home_screen/widgets/custom_field.dart';
import 'package:easy_order_web_app/screens/home_screen/widgets/product_drop_down.dart';
import 'package:easy_order_web_app/screens/home_screen/widgets/table_cell.dart';
import 'package:easy_order_web_app/screens/home_screen/widgets/table_header.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({Key? key}) : super(key: key);
  final HomeScreenController _ = Get.put(HomeScreenController());
  final DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2021, 10, DateTime.now().day),
      lastDate: DateTime(2021, 10, DateTime.now().day + 2),
    );
    if (picked != null && picked != selectedDate) {
      _.dateController.text = picked.toString().substring(0, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(title: const Text('Easy Order Web App')),
        //For dynamicall adding the rows
        // floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       // controller.increaseTableLength();
        //       // print("Table Length: ${controller.getTableLength}");
        //     },
        //     child: const Icon(
        //       Icons.add,
        //     )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Center(
            child: SizedBox(
              width: 820,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  AutofillGroup(
                    child: Form(
                      child: Column(
                        children: [
                          CustomField(
                            fieldName: "Customer Name",
                            controller: _.nameController,
                            autofillHints: const [AutofillHints.username],
                          ),
                          CustomField(
                            fieldName: "Customer Address",
                            controller: _.addressController,
                            autofillHints: const [AutofillHints.addressCity],
                          ),
                          GestureDetector(
                            onTap: () {
                              _selectDate(context);
                            },
                            child: CustomField(
                              fieldName: "Delivery Date",
                              controller: _.dateController,
                              // autofillHints: const [AutofillHints.birthdayDay],
                              onTap: () {
                                _selectDate(context);
                              },
                              isEnable: false,
                            ),
                          ),
                          CustomField(
                            fieldName: "Order Tracker",
                            controller: _.trackerController,
                            autofillHints: const [AutofillHints.username],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const TableHeader(),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 140,
                    child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _.tableLength,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        _.increaseTableList();
                        return SizedBox(
                          height: 27.5,
                          child: Row(
                            children: [
                              CustomTableCell(
                                index: index,
                                flex: 1,
                                controller: _.getCellValue(index, "serial"),
                              ),
                              GetBuilder<HomeScreenController>(
                                builder: (_) {
                                  return ProductDropDown(
                                      list: productsList,
                                      currentValue: _
                                          .getCellValue(index, "productName")!
                                          .text
                                          .toString(),
                                      onTap: (String? value) {
                                        _.setProductValue(
                                            value.toString(), index);
                                      });
                                },
                              ),
                              CustomTableCell(
                                  flex: 1,
                                  index: index,
                                  controller:
                                      _.getCellValue(index, "quantity")),
                              CustomTableCell(
                                  index: index,
                                  flex: 2,
                                  controller: _.getCellValue(index, "unit")),
                              CustomTableCell(
                                  flex: 1,
                                  index: index,
                                  controller:
                                      _.getCellValue(index, "unitPrice")),
                              CustomTableCell(
                                index: index,
                                flex: 2,
                                controller: _.getCellValue(index, "totalPrice"),
                                isTotalColumn: true,
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.center,
                          child: MaterialButton(
                            color: Colors.blue,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (tan) => AlertDialog(
                                        title: Text(
                                            "Total price for the order is Rs. ${controller.totalPrice}"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel")),
                                          TextButton(
                                              onPressed: () {
                                                _.saveToDatabase();
                                                _.resetAllData();
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Confirm")),
                                        ],
                                      ));
                            },
                            child: const Text("Order"),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: GetBuilder<HomeScreenController>(
                          builder: (tan) => Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "Total Price: Rs. ${tan.totalPrice}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
