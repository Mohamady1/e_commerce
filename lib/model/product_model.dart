class ProductModel {
  String? gender;
  String? name;
  int? id;
  double? price;

  ProductModel({
    required this.id,
    required this.gender,
    required this.name,
    required this.price,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    this.gender = json['Gender '];
    this.id = json["ID"];
    this.name = json['Name '];
    this.price = json['Price '].toDouble();
  }

  Map<String, dynamic> toJson() {
    return {
      'Gender ': gender,
      "ID": id,
      'Name ': name,
      'Price ': price,
    };
  }
}
