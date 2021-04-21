import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/presentation/presenters/presenters.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/ui/pages/pages.dart';

class LoadProductsSpy extends Mock implements LoadProducts {
  List<ProductEntity> _list = [];
  Future<List<ProductEntity>> load() =>
      this.noSuchMethod(Invocation.method(#load, []),
          returnValue: Future.value(_list),
          returnValueForMissingStub: Future.value(_list));
}

class DeleteProductSpy extends Mock implements DeleteProduct {
  Future<void> delete(String code) =>
      this.noSuchMethod(Invocation.method(#delete, []),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

void main() {
  late LoadProductsSpy loadProducts;
  late DeleteProductSpy deleteProducts;
  late GetxHomePresenter sut;
  late List<ProductEntity> productList;
  late String code;

  List<ProductEntity> mockValidProducts() => [
        ProductEntity(
            name: 'Product 1',
            code: 'any_code',
            creationDate: DateTime(2021, 4, 21)),
        ProductEntity(
            name: 'Product 2',
            code: 'any_code2',
            creationDate: DateTime(2021, 4, 20))
      ];

  PostExpectation mockLoadProductsCall() => when(loadProducts.load());

  void mockLoadProducts() {
    productList = mockValidProducts();
    mockLoadProductsCall().thenAnswer((_) async => productList);
  }

  void mockLoadProductsError() =>
      mockLoadProductsCall().thenThrow(DomainError.unexpected);

  setUp(() {
    loadProducts = LoadProductsSpy();
    deleteProducts = DeleteProductSpy();
    code = 'any_code';
    sut = GetxHomePresenter(
        loadProductsData: loadProducts, deleteProductByCode: deleteProducts);
    mockLoadProducts();
  });

  test('Should call LoadProducts on loadProducts', () async {
    await sut.loadProducts();
    verify(loadProducts.load()).called(1);
  });

  test('Should emit correct events on success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.productsStream!.listen(expectAsync1((product) => expect(product, [
          ProductViewModel(
              name: productList[0].name,
              price: productList[0].price,
              stock: productList[0].stock,
              code: productList[0].code,
              creationDate: '21-04-2021'),
          ProductViewModel(
              name: productList[1].name,
              price: productList[1].price,
              stock: productList[1].stock,
              code: productList[1].code,
              creationDate: '20-04-2021')
        ])));

    await sut.loadProducts();
  });

  test('Should emit correct events on failure', () async {
    mockLoadProductsError();
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    sut.productsStream!.listen(null,
        onError: expectAsync1(
            (error) => expect(error, UIError.unexpected.description)));

    await sut.loadProducts();
  });

  test('Should call DeleteProduct on deleteProduct with correct values',
      () async {
    await sut.deleteProduct(code);
    verify(deleteProducts.delete(code));
  });

  test('Should emit correct events on deleteProduct success', () async {
    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
    expectLater(sut.deleteProductStream, emits(UIError.none));

    await sut.deleteProduct(code);
  });
}
