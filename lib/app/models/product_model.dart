import 'package:refilin_mobile/app/common/utils.dart';
import 'package:refilin_mobile/app/models/store_model.dart';

class ProductModel {
  int? id;
  int? storeId;
  String? slug;
  String? name;
  String? price;
  String? stock;
  String? image;
  String? category;
  String? description;
  String? createdAt;
  String? updatedAt;
  StoreModel? store;

  ProductModel(
      {this.id,
      this.storeId,
      this.slug,
      this.name,
      this.price,
      this.stock,
      this.image,
      this.category,
      this.description,
      this.store,
      this.createdAt,
      this.updatedAt});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    slug = json['slug'];
    name = json['name'];
    price = json['price'];
    stock = json['stock'];
    image = json['image'];
    category = json['category'];
    description = json['description'];
    store = json['store'] != null ? StoreModel.fromJson(json['store']) : null;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_id'] = storeId;
    data['slug'] = slug;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    data['image'] = image;
    data['category'] = category;
    data['description'] = description;
    data['store'] = store?.toJson();

    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  Map<String, dynamic> toForm() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['name'] = name;
    data['price'] = price;
    data['stock'] = stock;
    data['image'] = image;
    data['category'] = category;
    data['description'] = description;
    return data;
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, storeId: $storeId, slug: $slug, name: $name, price: $price, stock: $stock, image: $image, category: $category, description: $description, store: $store, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  String get priceFormatted => Utils.formatCurrency(
        double.parse(price!),
        locale: 'id',
      );
}
