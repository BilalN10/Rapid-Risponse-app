import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserInfoReferanceModel {
  DocumentReference documentReference;
  RxString name = "".obs;
  RxString email = "".obs;
  RxString phoneNumber = "".obs;
  RxString image = "".obs;
  RxString uniCode = "".obs;
  String id;
  RxString role = "".obs;
  RxInt assignNumber = 0.obs;
  RxString tokeID = "".obs;
  RxString roleImage = "assets/images/guard.png".obs;
  RxBool isaAccountapprove = false.obs;
  RxString propertyCode = "".obs;
  RxString adminId = "".obs;
  RxString adminTokenId = "".obs;
  UserInfoReferanceModel(
      {this.documentReference,
      this.email,
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

  UserInfoReferanceModel.fromSnapShor(DocumentSnapshot data) {
    id = data.id;

    documentReference = data.data()["userDataReferance"];
    documentReference.get().then((data) {
      if (data.exists) {
        email.value = data.data()["email"] ?? "";
        image.value = data.data()["image"] ?? "";
        name.value = data.data()["name"] ?? "";
        phoneNumber.value = data.data()["phoneNumber"].toString();
        uniCode.value = data.data()["unitCode"] ?? "";
        assignNumber.value = data.data()["assignNumber"] ?? 0;
        role.value = data.data()["role"] ?? "";
        tokeID.value = data.data()["tokenId"] ?? "";
        roleImage.value = data.data()["roleImage"] ?? "";
        isaAccountapprove.value = data.data()["isaAccountapprove"];
        propertyCode.value = data.data()["propertyCode"];
        adminId.value = data.data()["adminId"];
        adminTokenId.value = data.data()["adminTokenId"];
        print("user email is $email");
        print("user  id is $id");
      } else {
        // eventTitle.value = "no data";
      }
      print("event title is ");
      // print("event titile is ${chatController.eventTitle.value}");
    });
    print(documentReference);
  }
}
