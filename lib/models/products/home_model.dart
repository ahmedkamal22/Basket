class HomeModel {
  bool? status;
  String? message;
  HomeData? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? HomeData.fromJson(json["data"]) : null;
  }
}

class HomeData {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];

  HomeData.fromJson(Map<String, dynamic> json) {
    json["banners"].forEach((element) {
      banners.add(BannersModel.fromJson(element));
    });
    json["products"].forEach((element) {
      products.add(ProductsModel.fromJson(element));
    });
  }
}

class BannersModel {
  int? id;
  String? image;

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    image = json["image"];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  List<String> images = [];
  bool? inFavourites;
  bool? inCart;

  ProductsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    price = json["price"];
    oldPrice = json["old_price"];
    discount = json["discount"];
    image = json["image"];
    name = json["name"];
    description = json["description"];
    images = json['images'].cast<String>();
    inFavourites = json["in_favorites"];
    inCart = json["in_cart"];
  }
}
