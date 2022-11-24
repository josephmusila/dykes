import 'package:bikes/services/authService.dart';
import "package:http/http.dart" as http;

Future<void> main() async {
  BikeRentalService bikeRentalService = BikeRentalService();
  // bikeRentalService.addBike(description: "some description",image: "jdjfjd",name: "name",owner: "1",price: "300");
  bikeRentalService.newRental();
}


class BikeRentalService {
  final addBikeUrl = Uri.parse("${BaseUrl().baseUrl}bikes/add");
  final listAllBikesUrl=Uri.parse("${BaseUrl().baseUrl}bikes/list");
  final rentBikeUrl=Uri.parse("${BaseUrl().baseUrl}rentals/new");


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

    return response;
  }

  Future<dynamic> listAllBikes() async{
    var response= await http.get(listAllBikesUrl);
    if(response.statusCode ==200){
      print(response.body);
    }else{
      print(response.statusCode);
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
}
