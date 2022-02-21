import 'package:cloud_firestore/cloud_firestore.dart';

class GeneratedPropertyModel {
  String address;
  String adminId;
  String city;
  String postalCode;
  String propertyCode;
  String provnice;
  String tokenid;
  String id;
  GeneratedPropertyModel(
      {this.address,
      this.adminId,
      this.city,
      this.id,
      this.postalCode,
      this.propertyCode,
      this.provnice,
      this.tokenid});

  GeneratedPropertyModel.fromSnamshot(DocumentSnapshot data) {
    id = data.id;
    address = data.data()["address"] ?? "";
    city = data.data()["city"] ?? "";
    postalCode = data.data()["postalCode"] ?? "";
    propertyCode = data.data()["propertyCode"].toString();
    provnice = data.data()["province"] ?? "";
    tokenid = data.data()["tokenId"] ?? "";
    adminId = data.data()["adminId"] ?? "";
    print("Address is $address");
  }
}
