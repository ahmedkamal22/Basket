class SearchModel {
  bool? status;
  String? message;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<SearchData> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(SearchData.fromJson(element));
    });
  }
}

class SearchData {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;
  List<String>? images;
  bool? inFavorites;
  bool? inCart;

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
    images = json['images'].cast<String>();
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
