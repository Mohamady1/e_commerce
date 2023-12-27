class RecProductModel {
  String? gender;
  String? name;
  int? id;
  String? weight;

  RecProductModel({
    required this.id,
    required this.gender,
    required this.name,
    required this.weight,
  });

  RecProductModel.fromJson(Map<String, dynamic> json) {
    this.gender = json['Gender'];
    this.id = json["ID"];
    this.name = json['Name'];
    this.weight = json['Weight'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Gender ': gender,
      "ID": id,
      'Name ': name,
      'Price ': weight,
    };
  }
}
