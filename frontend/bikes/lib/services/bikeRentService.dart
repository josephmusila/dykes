import 'dart:convert';

import 'package:bikes/models/bikesDataModel.dart';
import 'package:bikes/models/rentingHistoryModel.dart';
import 'package:bikes/services/authService.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

Future<void> main() async {
  BikeRentalService bikeRentalService = BikeRentalService();

  bikeRentalService.searchBike("Mountain");
}


class BikeRentalService {
  final addBikeUrl = Uri.parse("${BaseUrl().baseUrl}bikes/add");
  final listAllBikesUrl=Uri.parse("${BaseUrl().baseUrl}bikes/list");
  final rentBikeUrl=Uri.parse("${BaseUrl().baseUrl}rentals/new");
  final searchBikeUrl=Uri.parse("${BaseUrl().baseUrl}bikes/search");

  List<BikesDataModel> bikesData=[];
  List locations=[];
  List history=[];


  Future<dynamic> addBike(
      {required String owner,
      required String name,
      required String description,
      required String price,
      required String image}) async {
    var request = http.MultipartRequest("POST",addBikeUrl);
    request.fields["owner"]=owner;
    request.fields["name"]=name;
    request.fields["description"]=description;
    request.fields["price"]=price;
    request.files.add(await http.MultipartFile.fromPath("image", image));

    var res=await request.send();
    var response = await http.Response.fromStream(res);
    // print(response.body);
    return response.body;
  }

  Future<List<BikesDataModel>> listAllBikes() async{

      try {
        var response= await http.get(listAllBikesUrl);
        // print(bikesDataModelFromJson(json.decode(response.body)));
        // return bikesDataModelFromJson(json.decode(response.body));
        bikesData=bikesDataModelFromJson(response.body);


        return bikesData;
      }catch (e){
        throw Future.error(e);
    }

  }

 Future<List> getlocations() async {
    List bikes=[];
   try {
     var response= await http.get(listAllBikesUrl);
     // print(bikesDataModelFromJson(json.decode(response.body)));
     // return bikesDataModelFromJson(json.decode(response.body));
     bikesData=bikesDataModelFromJson(response.body);
     bikesData.forEach((element) {
       bikes.add(element.owner.location);
     });
     print(locations);
     return bikes;
   }catch (e){
     throw Future.error(e);
   }
  }

  Future<dynamic> newRental(
  {
  required String customer,
    required String bike_id,
    required String owner,
    required String rent_status,
    required String date_of_return,
    required String paid
  }
      ) async{
    var response=await http.post(rentBikeUrl,body:{
      "customer":customer,
      "bike":bike_id,
      "owner":owner,
      "rent_status":rent_status,
      "date_of_return":date_of_return,
      "paid":paid
    });

    print(response.body);
    return response;
  }

  Future<dynamic> searchBike(String query) async{
   try{
     var response = await http.get(Uri.parse("${BaseUrl().baseUrl}bikes/search/$query"));
     print(bikesDataModelFromJson(response.body));
     return bikesDataModelFromJson(response.body);
   }catch (e){
     throw Future.error(e);
   }
  }
  
  
  Future<List<RentalHistory>> getRentalsHistory(int id) async{
    List <RentalHistory>history=[];

    try{
      var response=await http.get(Uri.parse("${BaseUrl().baseUrl}rentals/history/$id"));
      var myhistory = rentalHistoryFromJson(response.body);

      myhistory.forEach((element) {
        history.add(element);
      });
      return history;
    }catch (e){
      throw Future.error(e);
    }
  }
}
