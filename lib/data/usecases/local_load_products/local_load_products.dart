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
        throw Exception();
      }
      return data
          .map<ProductEntity>(
              (json) => LocalProductModel.fromJson(json).toEntity())
          .toList();
    } catch (error) {
      throw DomainError.unexpected;
    }
  }
}
