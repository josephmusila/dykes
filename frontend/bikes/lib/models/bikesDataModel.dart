// To parse this JSON data, do
//
//     final bikesDataModel = bikesDataModelFromJson(jsonString);

import 'dart:convert';

List<BikesDataModel> bikesDataModelFromJson(String str) => List<BikesDataModel>.from(json.decode(str).map((x) => BikesDataModel.fromJson(x)));

String bikesDataModelToJson(List<BikesDataModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BikesDataModel {
  BikesDataModel({
    required this.id,
    required this.owner,
    required this.name,
    required  this.description,
    required this.price,
    required this.image,
    required this.rentStatus
  });

  Owner owner;
  String name;
  String description;
  String price;
  dynamic image;
  String?  rentStatus;
  int id;

  factory BikesDataModel.fromJson(Map<String, dynamic> json) => BikesDataModel(
    id: json["id"],
    owner: Owner.fromJson(json["owner"]),
    name: json["name"],
    description: json["description"],
    price: json["price"],
    image: json["image"],
    rentStatus: json["rent_status"]
  );

  Map<String, dynamic> toJson() => {
    "owner": owner.toJson(),
    "name": name,
    "description": description,
    "price": price,
    "image": image,
    "rent_status":rentStatus
  };
}

class Owner {
  Owner({
   required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.avatar,
    required this.location,
    required this.accountType,
  });

  int id;
  String firstName;
  String lastName;
  String phone;
  String email;
  String avatar;
  String location;
  String accountType;

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: json["phone"],
    email: json["email"],
    avatar: json["avatar"],
    location: json["location"],
    accountType: json["account_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone,
    "email": email,
    "avatar": avatar,
    "location": location,
    "account_type": accountType,
  };
}
