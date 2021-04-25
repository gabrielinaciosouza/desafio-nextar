import 'dart:convert';

import '../../../domain/helpers/helpers.dart';
import '../../../domain/entities/entities.dart';

import '../../../domain/usecases/usecases.dart';
import '../../models/models.dart';
import '../../cache/cache.dart';

class LocalLoadProducts implements LoadProducts {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadProducts({required this.fetchCacheStorage});
  @override
  Future<List<ProductEntity>> load() async {
    try {
      final data = await fetchCacheStorage.fetch('products');
      if (data?.isEmpty != false) {
        return [];
      }
      final productList = data.split(',');

      List<ProductEntity> productEntityList = [];
      for (String product in productList) {
        final res = await fetchCacheStorage.fetch(product);

        if (res != null) {
          productEntityList
              .add(LocalProductModel.fromJson(json.decode(res)).toEntity());
        }
      }
      return productEntityList;
    } catch (error) {
      print(error.toString());
      throw DomainError.unexpected;
    }
  }
}
