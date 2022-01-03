class RoleModel {
  String name;
  String imgPath;
  int assignNumber;
  RoleModel({this.imgPath, this.assignNumber, this.name});
}

List<RoleModel> roleModelList = [
  RoleModel(
      imgPath: "assets/images/guard.png", name: "Guard", assignNumber: 222),
  RoleModel(
      imgPath: "assets/images/account.png", name: "Admin", assignNumber: 111),
  RoleModel(
      imgPath: "assets/images/guard.png",
      name: "Commitee member",
      assignNumber: 333),
  RoleModel(
      imgPath: "assets/images/guard.png", name: "Resident", assignNumber: 444),
];
