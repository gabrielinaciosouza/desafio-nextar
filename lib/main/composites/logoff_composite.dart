import '../../domain/usecases/usecases.dart';

class LogoffComposite implements DeleteFromCache {
  DeleteFromCache secure;
  DeleteFromCache local;

  LogoffComposite({required this.local, required this.secure});

  @override
  Future<void> delete(String code) async {
    try {
      await secure.delete(code);
    } catch (error) {
      await local.delete(code);
    }
  }
}
