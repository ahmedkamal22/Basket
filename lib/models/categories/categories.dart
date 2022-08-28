class CategoriesModel {
  bool? status;
  String? message;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null
        ? CategoriesDataModel.fromJson(json["data"])
        : null;
  }
}

class CategoriesDataModel {
  int? currentPage;
  List<CategoriesData> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((element) {
      data.add(CategoriesData.fromJson(element));
    });
  }
}

class CategoriesData {
  int? id;
  String? name;
  String? image;

  CategoriesData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
    name = json["name"];
  }
}
