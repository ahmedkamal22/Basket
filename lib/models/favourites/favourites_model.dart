class FavouritesModel {
  bool? status;
  String? message;
  DataModel? data;

  FavouritesModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? DataModel.fromJson(json["data"]) : null;
  }
}

class DataModel {
  int? currentPage;
  List<FavouritesData> data = [];

  DataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json["current_page"];
    json["data"].forEach((element) {
      data.add(FavouritesData.fromJson(element));
    });
  }
}

class FavouritesData {
  int? id;
  ProductData? product;

  FavouritesData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    product =
        json["product"] != null ? ProductData.fromJson(json["product"]) : null;
  }
}

class ProductData {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
  }
}
