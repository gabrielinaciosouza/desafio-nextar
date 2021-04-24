import 'package:desafio_nextar/domain/helpers/helpers.dart';
import 'package:desafio_nextar/presentation/mixins/mixins.dart';
import 'package:desafio_nextar/ui/helpers/helpers.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:desafio_nextar/domain/entities/entities.dart';
import 'package:desafio_nextar/domain/usecases/usecases.dart';
import 'package:desafio_nextar/presentation/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {
  @override
  ValidationError validate({required String? field, required String? value}) =>
      this.noSuchMethod(Invocation.method(#validate, [field, value]),
          returnValue: ValidationError.none,
          returnValueForMissingStub: ValidationError.none);
}

class DeleteFromCacheSpy extends Mock implements DeleteFromCache {
  @override
  Future<void> delete(String code) =>
      this.noSuchMethod(Invocation.method(#delete, [code]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

class SaveProductSpy extends Mock implements SaveProduct {
  @override
  Future<void> save(ProductEntity product) =>
      this.noSuchMethod(Invocation.method(#save, [product]),
          returnValue: Future.value(),
          returnValueForMissingStub: Future.value());
}

class GetxProductPresenter extends GetxController
    with
        FormManager,
        ValidateFieldManager,
        UIErrorManager,
        LoadingManager,
        NavigationManager {
  final Validation validation;
  final SaveProduct saveProduct;
  final DeleteFromCache deleteFromCache;

  GetxProductPresenter(
      {required this.validation,
      required this.deleteFromCache,
      required this.saveProduct});

  String? _name;
  String? _code;
  String _price = '';
  String _stock = '';
  bool _isEditing = false;

  var _nameError = Rx<UIError>(UIError.none);
  var _codeError = Rx<UIError>(UIError.none);

  Stream<UIError?>? get nameErrorStream => _nameError.stream;
  Stream<UIError?>? get codeErrorStream => _codeError.stream;
  String get price => _price;
  set price(String value) => _price;
  String get stock => _stock;
  set stock(value) => _stock = value;
  bool get isEditing => _isEditing;
  set isEditing(value) => _isEditing = value;

  void validateName(String value) {
    _name = value;
    _nameError.value =
        validateField(field: 'name', value: value, validation: validation);
    _validateForm();
  }

  void validateCode(String value) {
    _code = value;
    _codeError.value =
        validateField(field: 'code', value: value, validation: validation);
    _validateForm();
  }

  _validateForm() {
    isFormValid = _nameError.value == UIError.none &&
        _codeError.value == UIError.none &&
        _name != null &&
        _code != null;
  }

  Future<void> submit({required String price, required String stock}) async {
    try {
      mainError = UIError.none;
      if ((!price.isNumericOnly || !stock.isNumericOnly) &&
          (price.isNotEmpty || stock.isNotEmpty)) {
        mainError = UIError.numericOnly;
        return;
      }
      isLoading = true;

      final product = ProductEntity(
          name: _name!,
          code: _code!,
          creationDate: CustomizableDateTime.current,
          price: price.isEmpty ? null : num.parse(price),
          stock: stock.isEmpty ? null : num.parse(stock));
      if (isEditing) {
        await deleteFromCache.delete(_code!);
      }
      await saveProduct.save(product);
      navigateTo = '/home';
    } on DomainError {
      mainError = UIError.unexpected;
    }
    isLoading = false;
  }
}

extension CustomizableDateTime on DateTime {
  static DateTime customTime = DateTime.now();
  static DateTime get current => customTime;
}

void main() {
  late GetxProductPresenter sut;
  late ValidationSpy validation;
  late DeleteFromCacheSpy deleteFromCache;
  late SaveProductSpy saveProduct;
  late String value;
  late String price;
  late String stock;
  late ProductEntity product;

  void mockValidation({
    required String value,
    required String field,
    required error,
  }) {
    when(validation.validate(field: field, value: value)).thenReturn(error);
  }

  setUp(() {
    validation = ValidationSpy();
    deleteFromCache = DeleteFromCacheSpy();
    saveProduct = SaveProductSpy();
    sut = GetxProductPresenter(
        validation: validation,
        deleteFromCache: deleteFromCache,
        saveProduct: saveProduct);
    value = 'any_value';
    price = '10';
    stock = '20';
    CustomizableDateTime.customTime = DateTime.parse("1969-07-20 20:18:04");
    product = ProductEntity(
        name: value,
        code: value,
        creationDate: CustomizableDateTime.current,
        price: price.isEmpty ? null : num.parse(price),
        stock: stock.isEmpty ? null : num.parse(stock));
  });
  test('Should call Validation with correct value value', () {
    sut.validateName(value);
    verify(validation.validate(field: 'name', value: value)).called(1);
  });

  test(
      'Should emit name error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'name', value: value, error: ValidationError.invalidField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test(
      'Should emit name error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'name', value: value, error: ValidationError.requiredField);

    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test('Should emit empty if validation succeeds', () {
    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateName(value);
    sut.validateName(value);
  });

  test('Should call Validation with correct password', () {
    sut.validateCode(value);

    verify(validation.validate(field: 'code', value: value)).called(1);
  });

  test(
      'Should emit code error if validation returns ValidationError.invalidField',
      () {
    mockValidation(
        field: 'code', value: value, error: ValidationError.invalidField);

    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.invalidField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test(
      'Should emit code error if validation return ValidationError.requiredField',
      () {
    mockValidation(
        field: 'code', value: value, error: ValidationError.requiredField);

    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.requiredField)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test('Should emit empty if validation succeeds', () {
    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.isFormValidStream!
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validateCode(value);
    sut.validateCode(value);
  });

  test('Should emit isFormValid true if validations succeeds', () async {
    sut.nameErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));
    sut.codeErrorStream!
        .listen(expectAsync1((error) => expect(error, UIError.none)));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validateName(value);
    await Future.delayed(Duration.zero);
    sut.validateCode(value);
  });

  test('Should call Submit with correct values on Editing', () async {
    sut.validateName(value);
    sut.validateCode(value);
    sut.isEditing = true;
    await sut.submit(price: price, stock: stock);

    verify(deleteFromCache.delete(value)).called(1);
    verify(saveProduct.save(product)).called(1);
  });

  test('Should call Submit with correct values on Saving', () async {
    sut.validateName(value);
    sut.validateCode(value);
    sut.isEditing = false;
    await sut.submit(price: price, stock: stock);

    verifyNever(deleteFromCache.delete(value));
    verify(saveProduct.save(product)).called(1);
  });

  test('Should emit correct events on Submit success', () async {
    sut.validateName(value);
    sut.validateCode(value);

    expectLater(sut.isLoadingStream, emits(true));

    await sut.submit(price: price, stock: stock);
  });

  // test('Should emit correct events on InvalidCredentialsError', () async {
  //   mockAuthenticationError(error: DomainError.invalidCredentials);

  //   sut.validateEmail(email);
  //   sut.validatePassword(password);

  //   expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
  //   expectLater(sut.mainErrorStream,
  //       emitsInOrder([UIError.none, UIError.invalidCredentials]));

  //   await sut.auth();
  // });

  // test('Should emit correct events on UnexpectedError', () async {
  //   mockAuthenticationError(error: DomainError.unexpected);

  //   sut.validateEmail(email);
  //   sut.validatePassword(password);

  //   expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
  //   expectLater(
  //       sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

  //   await sut.auth();
  // });

  // test('Should call SaveCurrentAccount with correct values', () async {
  //   sut.validateEmail(email);
  //   sut.validatePassword(password);

  //   await sut.auth();

  //   verify(saveCurrentAccount.save(AccountEntity(token: token))).called(1);
  // });

  // test('Should emit UnexpectedError if SaveCurrentAccount fails', () async {
  //   mockSaveCurrentAccountError();

  //   sut.validateEmail(email);
  //   sut.validatePassword(password);

  //   expectLater(sut.isLoadingStream, emitsInOrder([true, false]));
  //   expectLater(
  //       sut.mainErrorStream, emitsInOrder([UIError.none, UIError.unexpected]));

  //   await sut.auth();
  // });

  // test('Should change page on success success', () async {
  //   sut.validateEmail(email);
  //   sut.validatePassword(password);

  //   sut.navigateToStream!.listen(expectAsync1((page) => expect(page, '/home')));

  //   await sut.auth();
  // });
}
