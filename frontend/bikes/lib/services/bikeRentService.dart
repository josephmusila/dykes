import 'dart:convert';

import 'package:bikes/models/bikesDataModel.dart';
import 'package:bikes/services/authService.dart';
import "package:http/http.dart" as http;

Future<void> main() async {
  BikeRentalService bikeRentalService = BikeRentalService();

  bikeRentalService.searchBike("Mountain");
}


class BikeRentalService {
  final addBikeUrl = Uri.parse("${BaseUrl().baseUrl}bikes/add");
  final listAllBikesUrl=Uri.parse("${BaseUrl().baseUrl}bikes/list");
  final rentBikeUrl=Uri.parse("${BaseUrl().baseUrl}rentals/new");
  final searchBikeUrl=Uri.parse("${BaseUrl().baseUrl}bikes/search");


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
      List<BikesDataModel> bikesData=[];
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

  Future<dynamic> newRental() async{
    var response=await http.post(rentBikeUrl,body:{
      "customer":"1",
      "bike":"1",
      "date_of_renting":"10-10-2020",
      "rent_status":"rented",
      "date_of_return":"20-10-2020",
      "paid":"True"
    });

    print(response.body);
    return response;
  }

  Future<List<BikesDataModel>> searchBike(String query) async{
   try{
     var response = await http.get(Uri.parse("${BaseUrl().baseUrl}bikes/search/$query"));
     print(bikesDataModelFromJson(response.body));
     return bikesDataModelFromJson(response.body);
   }catch (e){
     throw Future.error(e);
   }
  }
}
