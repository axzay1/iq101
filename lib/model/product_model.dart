
class ProductModel {
  final int id;
  final String name;
  final double cost;
  final String description;
  final String type;
  final String createdBy;
  final String image;

  ProductModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.description,
    required this.type,
    required this.createdBy,
    required this.image,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      cost: double.parse(json['cost']),
      description: json['description'],
      type: json['type'],
      createdBy: json['created_by'],
      image: json['image'],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel &&
        other.id == id &&
        other.name == name &&
        other.cost == cost &&
        other.description == description &&
        other.type == type &&
        other.createdBy == createdBy &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    name.hashCode ^
    cost.hashCode ^
    description.hashCode ^
    type.hashCode ^
    createdBy.hashCode ^
    image.hashCode;

  }
}
