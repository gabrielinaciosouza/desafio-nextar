import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetxHomePresenter {
  final LoadProducts loadProductsData;
  GetxHomePresenter({required this.loadProductsData});
  Future<void> loadProducts() async {
    await loadProductsData.load();
  }
}

class LoadProductsSpy extends Mock implements LoadProducts {
  List<ProductEntity> _list = [];
  Future<List<ProductEntity>> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(_list),
          returnValueForMissingStub: Future.value(_list));
}

void main() {
  late LoadProductsSpy loadProducts;
  late GetxHomePresenter sut;

  setUp(() {
    loadProducts = LoadProductsSpy();
    sut = GetxHomePresenter(loadProductsData: loadProducts);
  });

  test('Should call LoadProducts on loadProducts', () async {
    await sut.loadProducts();
    verify(loadProducts.load()).called(1);
  });
}
