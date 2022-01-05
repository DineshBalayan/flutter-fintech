// @dart=2.10
class DemoListModel {
  final String picAsset, title, model, variant;
  final type;
  bool isExpanded = false;

  bool isEmpty() {
    return this.picAsset == null || this.picAsset.isEmpty;
  }

  DemoListModel(
      {this.picAsset, this.title, this.model, this.type, this.variant});
}
