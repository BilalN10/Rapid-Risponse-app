class BottomNavBarModel {
  String title;
  String img;
  BottomNavBarModel({this.img, this.title});
}

List<BottomNavBarModel> bottomNavBarModelList = [
  BottomNavBarModel(img: "assets/images/map.png", title: "Map"),
  BottomNavBarModel(img: "assets/images/Vector.png", title: "Navigate"),
  BottomNavBarModel(img: "assets/images/onscene.png", title: "OnScene"),
  BottomNavBarModel(img: "assets/images/preplans.png", title: "Preplan"),
];
