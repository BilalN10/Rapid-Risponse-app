import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String email;
  String phoneNumber;
  String image;
  String uniCode;
  String id;
  String role;
  int assignNumber;
  String tokeID;
  String roleImage;
  List<String> tokenList;
  bool isaAccountapprove = false;
  String propertyCode;
  String adminId;
  String adminTokenId;

  UserModel(
      {this.email,
      this.image,
      this.name,
      this.phoneNumber,
      this.uniCode,
      this.assignNumber,
      this.id,
      this.role,
      this.tokeID,
      this.roleImage,
      this.isaAccountapprove});
  UserModel.fromSnamshot(DocumentSnapshot data) {
    id = data.id;
    email = data.data()["email"] ?? "";
    image = data.data()["image"] ?? "";
    name = data.data()["name"] ?? "";
    phoneNumber = data.data()["phoneNumber"].toString();
    uniCode = data.data()["unitCode"] ?? "";
    assignNumber = data.data()["assignNumber"] ?? 0;
    role = data.data()["role"] ?? "";
    tokeID = data.data()["tokenId"] ?? "";
    roleImage = data.data()["roleImage"] ?? "";
    isaAccountapprove = data.data()["isaAccountapprove"];
    propertyCode = data.data()["propertyCode"];
    adminId = data.data()["adminId"];
    adminTokenId = data.data()["adminTokenId"];
    print("Admin id is  $adminId");

    print("user email is $email");
    print("phone Number $phoneNumber");
    print(roleImage);
  }
  UserModel.snamShotData(DocumentSnapshot data) {}
}
