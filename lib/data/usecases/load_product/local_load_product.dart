import 'dart:convert';

import '../../cache/cache.dart';
import '../../models/models.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/helpers/helpers.dart';
import '../../../domain/usecases/usecases.dart';

class LocalLoadProduct implements LoadProduct {
  final FetchCacheStorage fetchCacheStorage;

  LocalLoadProduct({required this.fetchCacheStorage});
  @override
  Future<ProductEntity?> load(String code) async {
    try {
      final String product = await fetchCacheStorage.fetch(code) ?? '';

      if (product.isNotEmpty) {
        return LocalProductModel.fromJson(json.decode(product)).toEntity();
      }
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
