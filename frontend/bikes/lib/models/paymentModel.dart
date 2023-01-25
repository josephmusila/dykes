class PaymentModel {
  String status;
  int transactiond_id;

  PaymentModel({required this.status, required this.transactiond_id});


  factory PaymentModel.fromJson(Map<String,dynamic> json)=>PaymentModel(status: json["status"], transactiond_id: json["transaction_id"]);
}
