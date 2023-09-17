import 'package:get/get.dart';

class ProductFilter {
  String? page;
  String? perPage;
  RxString? search;
  bool? store;
  bool? user;
  List<int?>? prices;
  String? category;
  String? storeId;

  ProductFilter({
    this.page,
    this.perPage,
    this.search,
    this.store,
    this.user,
    this.prices,
    this.category,
    this.storeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'search': search,
      'store': store?.toString(),
      'user': user?.toString(),
      'prices': prices!.toString(),
      'category': category,
      'store_id': storeId.toString(),
    };
  }

  //make copy of this object
  ProductFilter copyWith({
    String? page,
    String? perPage,
    RxString? search,
    bool? store,
    bool? user,
    List<int>? prices,
    String? category,
    String? storeId,
  }) {
    return ProductFilter(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      store: store ?? this.store,
      user: user ?? this.user,
      prices: prices ?? this.prices,
      category: category ?? this.category,
      storeId: storeId ?? this.storeId,
    );
  }
}
