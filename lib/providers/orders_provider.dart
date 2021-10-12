import 'package:dio/dio.dart';

const orderItemUrl =
    "https://practice-restful-apis.vercel.app/orderItems/placeOrderItems/";
const orderUrl = "https://practice-restful-apis.vercel.app/orders/placeOrder/";

class Order {
  var response;
  Dio dio = Dio();
  void orderItems(
      List<String> list, List<Map<String, String>> itemsList) async {
    // print("this is the condition of itemsList");
    // print(itemsList);
    dio.options.headers['content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    response = await dio.post(orderItemUrl, data: {
      "items": itemsList,
    });
    list.add(response.toString());
    orderDetails(list);

    // return response.data;
  }

  void orderDetails(List<String> list) async {
    dio.options.headers['content-Type'] = 'application/json; charset=UTF-8';
    dio.options.headers["Access-Control-Allow-Origin"] = "*";
    response = await dio.post(orderUrl, data: {
      "customerName": list[0],
      "address": list[1],
      "date": list[2],
      "orderTracker": list[3],
      "totalPrice": list[4],
      "orderItemsId": list[5],
    });

    // return response.data;
  }

  // void order2() async {
  //   print("Order 22 send");
  //   var client = http.Client();
  //   try {
  //     var response = await client.post(Uri.parse(url2),
  //         headers: <String, String>{
  //           'Content-Type': 'application/json; charset=UTF-8',
  //           // "Access-Control-Allow-Origin":
  //           //     "*", // Required for CORS support to work
  //           // "Access-Control-Allow-Credentials":
  //           //     "true", // Required for cookies, authorization headers with HTTPS
  //           // "Access-Control-Allow-Headers":
  //           //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
  //           // "Access-Control-Allow-Methods": "POST, OPTIONS"
  //           "Access-Control-Allow-Origin": "*"
  //         },
  //         body: jsonEncode({
  //           "items": [
  //             {"serial": "1", "productName": "Onion"},
  //             {"serial": "2", "productName": "Onion"}
  //           ]
  //         }));
  //     // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
  //     // var uri = Uri.parse(decodedResponse['uri'] as String);
  //     print("Order 2 receied");
  //     print(response.body);
  //   } catch (err) {
  //     print(err);
  //     client.close();
  //   }
  // }
}
