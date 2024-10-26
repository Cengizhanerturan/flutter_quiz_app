class CategoryModel {
  CategoryModel({
    required this.id,
    required this.cid,
    required this.categoryName,
    required this.img,
    required this.color,
  });

  final int id;
  final String cid;
  final String categoryName;
  final String img;
  final String color;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["id"],
        cid: json["cid"],
        categoryName: json["category_name"],
        img: json["img"],
        color: json["color"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "cid": cid,
        "category_name": categoryName,
        "img": img,
        "color": color,
      };

  static List<CategoryModel> decode(dynamic data) {
    return (data as List)
        .map((element) => CategoryModel.fromJson(element))
        .toList();
  }
}
