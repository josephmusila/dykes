// To parse this JSON data, do
//
//     final rentalHistory = rentalHistoryFromJson(jsonString);

import 'dart:convert';

List<RentalHistory> rentalHistoryFromJson(String str) => List<RentalHistory>.from(json.decode(str).map((x) => RentalHistory.fromJson(x)));

String rentalHistoryToJson(List<RentalHistory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RentalHistory {
  RentalHistory({
    required this.id,
    required this.customer,
    required this.owner,
    required this.bike,
    required this.dateOfRenting,
    required this.dateOfReturn,
    required this.paid,
    required this.client,
  });

  int id;
  int customer;
  int owner;
  Bike bike;
  DateTime dateOfRenting;
  DateTime dateOfReturn;
  bool paid;
  Client client;

  factory RentalHistory.fromJson(Map<String, dynamic> json) => RentalHistory(
    id: json["id"],
    customer: json["customer"],
    owner: json["owner"],
    bike: Bike.fromJson(json["bike"]),
    dateOfRenting: DateTime.parse(json["date_of_renting"]),
    dateOfReturn: DateTime.parse(json["date_of_return"]),
    paid: json["paid"],
    client: Client.fromJson(json["client"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer": customer,
    "owner": owner,
    "bike": bike.toJson(),
    "date_of_renting": "${dateOfRenting.year.toString().padLeft(4, '0')}-${dateOfRenting.month.toString().padLeft(2, '0')}-${dateOfRenting.day.toString().padLeft(2, '0')}",
    "date_of_return": "${dateOfReturn.year.toString().padLeft(4, '0')}-${dateOfReturn.month.toString().padLeft(2, '0')}-${dateOfReturn.day.toString().padLeft(2, '0')}",
    "paid": paid,
    "client": client.toJson(),
  };
}

class Bike {
  Bike({
    required this.id,
    required this.owner,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  int id;
  Client owner;
  String name;
  String description;
  String price;
  String image;

  factory Bike.fromJson(Map<String, dynamic> json) => Bike(
    id: json["id"],
    owner: Client.fromJson(json["owner"]),
    name: json["name"],
    description: json["description"],
    price: json["price"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "owner": owner.toJson(),
    "name": name,
    "description": description,
    "price": price,
    "image": image,
  };
}

class Client {
  Client({
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

  factory Client.fromJson(Map<String, dynamic> json) => Client(
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
