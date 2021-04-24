import 'dart:convert';

import '../../cache/cache.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalSaveProduct implements SaveProduct {
  final SaveCacheStorage saveCacheStorage;

  LocalSaveProduct({required this.saveCacheStorage});
  @override
  Future<void> save(ProductEntity product) async {
    try {
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
    data['creationDate'] = product.creationDate.toIso8601String();
    data['price'] = product.price.toString();
    data['stock'] = product.stock.toString();
    return data;
  }
}
