
class myclass {
  int? id;
  String? title;
  String? description;
  int? price;
  double? discountPercentage;
  dynamic? rating;
  int? stock;
  String? brand;
  String? category;
  String? thumbnail;
  List<String>? images;

  myclass(
      {this.id,
        this.title,
        this.description,
        this.price,
        this.discountPercentage,
        this.rating,
        this.stock,
        this.brand,
        this.category,
        this.thumbnail,
        this.images});

  myclass.fromJson(json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    discountPercentage = json['discountPercentage'];
    rating = json['rating'];
    stock = json['stock'];
    brand = json['brand'];
    category = json['category'];
    thumbnail = json['thumbnail'];
    images = json['images'].cast<String>();
  }

}