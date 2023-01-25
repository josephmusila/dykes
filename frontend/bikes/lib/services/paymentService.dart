
import 'dart:convert';

import 'package:bikes/services/authService.dart';
import "package:http/http.dart" as http;

import '../models/paymentModel.dart';

class PaymentUrls{

  final paymentUrl=Uri.parse("${BaseUrl().baseUrl}submit/");
}


class PaymentService{



  Future<dynamic> pay(
     String amount,
     String phone,
      String bike
  ) async {

    try {
      var response = await http.post(PaymentUrls().paymentUrl, body: {
        "amount": amount,
        "phone": phone,
        "bike":bike
      }).timeout(const Duration(seconds: 30));

      // res["message"] = json.decode(response.body);
      if(response.statusCode == 200){
        return PaymentModel.fromJson(json.decode(response.body));
      }else{
        return Future.error("An error occurred while processing the transaction");
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
  }