import 'dart:convert';

import '../../cache/cache.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalSaveProduct implements SaveProduct {
  final SaveCacheStorage saveCacheStorage;
  final FetchCacheStorage fetchCacheStorage;

  LocalSaveProduct(
      {required this.saveCacheStorage, required this.fetchCacheStorage});
  @override
  Future<void> save(ProductEntity product) async {
    try {
      final products = await fetchCacheStorage.fetch('products');
      String result = product.code;
      if (products != null && products.isNotEmpty) {
        List<String> productsList = products.split(',');
        if (productsList.contains(product.code)) {
          throw DomainError.duplicatedCode;
        }
        if (productsList.length != 0) {
          result = '$products,${product.code}';
        }
      }
      await saveCacheStorage.save(key: 'products', value: result);
      print(product.toString());
      await saveCacheStorage.save(
          key: product.code, value: json.encode(toJson(product)));
    } catch (error) {
      throw DomainError.unexpected;
    }
  }

  Map<String, String> toJson(ProductEntity product) {
    final Map<String, String> data = new Map<String, String>();
    data['name'] = product.name;
    data['code'] = product.code;
    data['imagePath'] = product.imagePath.toString();
    data['creationDate'] = product.creationDate.toIso8601String();
    data['price'] = product.price.toString();
    data['stock'] = product.stock.toString();
    return data;
  }
}
