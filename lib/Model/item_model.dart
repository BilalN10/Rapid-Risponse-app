class ItemModel {
  bool expanded;
  String headerItem;
  int responderBadge;
  bool isActive;
  String selectedItem;
  bool selected;
  List<String> list;
  bool warning;

  ItemModel(
      {this.expanded = false,
      this.warning = false,
      this.isActive = false,
      this.selected = false,
      this.headerItem,
      this.list,
      this.selectedItem,
      this.responderBadge});
}
