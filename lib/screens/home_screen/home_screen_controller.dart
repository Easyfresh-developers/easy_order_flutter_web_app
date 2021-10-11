import 'package:easy_order_web_app/constants.dart';
import 'package:easy_order_web_app/providers/orders_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:get/state_manager.dart';

class HomeScreenController extends GetxController {
  static HomeScreenController get to => Get.find<HomeScreenController>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController trackerController = TextEditingController();
  bool listFirstEntry = true;
  String currentProductValue = "Select Product";
  int tableLength = 5;
  double totalPrice = 0;

  List<Map<String, TextEditingController>> tableList = [];

  void productPrice(int index) {
    double quantity = 0;
    double unitPrice = 0;
    if (getCellValue(index, "unitPrice")!.text != "" &&
        getCellValue(index, "quantity")!.text != "") {
      quantity = double.parse(getCellValue(index, "quantity")!.text.toString());
      unitPrice =
          double.parse(getCellValue(index, "unitPrice")!.text.toString());
    }
    getCellValue(index, "totalPrice")!.text =
        (quantity * unitPrice).toStringAsFixed(2);
  }

  void setProductValue(String value, int index) {
    // currentProductValue = value;
    setCellValue(index, "productName", value);

    // print("this is unit price from my Map ${unitAndPriceMap[value]![1]}");
    setCellValue(index, "unitPrice", unitAndPriceMap[value]![1]);
    setCellValue(index, "unit", unitAndPriceMap[value]![0]);
    if (getCellValue(index, "serial")!.text.isEmpty) {
      setCellValue(index, "serial", (index + 1).toString());
    }
    if (getCellValue(index, "quantity")!.text.isEmpty) {
      setCellValue(index, "quantity", "1");
    }
    productPrice(index);
    setTotalPrice();
    update();
  }

  void setTotalPrice() {
    double temptotalPrice = 0;
    tableList.asMap().forEach((i, value) {
      // print("this is total price: ${value["totalPrice"]!.text}");
      if (value["totalPrice"]!.text.isNotEmpty) {
        temptotalPrice += double.parse(value["totalPrice"]!.text);
      }
    });
    totalPrice = temptotalPrice;
    update();
  }

  get getProductValue => currentProductValue;

  TextEditingController? getCellValue(int index, String key) {
    // print(
    //     "getting index: $index sending key: $key value: ${tableList[index][key]!.text}");
    return tableList[index][key];
  }

  void setCellValue(int index, String key, String value) {
    // print("sending index: $index sending key: $key value: $value");
    tableList[index][key]!.text = value;
    update();
  }

  void increaseTableList() {
    // if (listFirstEntry) {
    //   tableList.clear();
    //   listFirstEntry = false;
    // }
    tableList.add(<String, TextEditingController>{
      "serial": TextEditingController(text: ""),
      "quantity": TextEditingController(text: ""),
      "productName": TextEditingController(text: "Select Product"),
      "unit": TextEditingController(text: ""),
      "unitPrice": TextEditingController(text: ""),
      "totalPrice": TextEditingController(text: ""),
    });
    // update();
  }

  get getTableLength => tableLength;
  increaseTableLength() {
    tableLength++;
    update();
  }

  increaseTotalPrice(int value) => totalPrice += value;
  String? passwordValidator(String? val) {
    if (val!.isEmpty) {
      return 'Password is required';
    } else if (val.length < 8) {
      return 'password must be at least 8 digits long';
    }
    // else if (!val.contains(RegExp(r'(?=.*?[#?!@$%^&*-])'))) {
    //   return 'passwords must have at least one special character';
    // }
    return null;
  }

  String? emailValidator(String? val) {
    if (val!.isEmpty) {
      return 'Email is required';
    } else if (!val.isEmail) {
      return 'Enter a valid email address';
    }
    return null;
  }

  void resetAllData() {
    nameController.clear();
    addressController.clear();
    dateController.clear();
    trackerController.clear();
    // tableList.clear();
    for (int a = 0; a < 5; a++) {
      // increaseTableList();
      tableList[a]["serial"]!.text = "";
      tableList[a]["quantity"]!.text = "";
      tableList[a]["productName"]!.text = "Select Product";
      tableList[a]["unit"]!.text = "";
      tableList[a]["unitPrice"]!.text = "";
      tableList[a]["totalPrice"]!.text = "";
    }

    totalPrice = 0;
    update();
  }

  void saveToDatabase() {
    List<String> userDetailsList = [
      nameController.text,
      addressController.text,
      dateController.text,
      trackerController.text,
      totalPrice.toString(),
    ];
    List<Map<String, String>> itemList = [];
    for (int a = 0; a < 5; a++) {
      itemList.add({
        "serial": tableList[a]["serial"]!.text,
        "quantity": tableList[a]["quantity"]!.text,
        "productName": tableList[a]["productName"]!.text,
        "unit": tableList[a]["unit"]!.text,
        "unitPrice": tableList[a]["unitPrice"]!.text,
        "totalPrice": tableList[a]["totalPrice"]!.text
      });
      // itemList.add({"quantity": tableList[a]["quantity"]!.text});
      // itemList.add({"productName": tableList[a]["productName"]!.text});
      // itemList.add({"unit": tableList[a]["unit"]!.text});
      // itemList.add({"unitPrice": tableList[a]["unitPrice"]!.text});
      // itemList.add({"totalPrice": tableList[a]["totalPrice"]!.text});
    }

    Order().orderItems(userDetailsList, itemList);
  }
}
