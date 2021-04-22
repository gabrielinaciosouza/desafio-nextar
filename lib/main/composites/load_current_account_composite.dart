import '../../data/usecases/load_current_account/load_current_account.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class LoadCurrentAccountComposite implements LoadCurrentAccount {
  final SecureLocalLoadCurrentAccount secure;
  final LocalLoadCurrentAccount local;

  LoadCurrentAccountComposite({
    required this.secure,
    required this.local,
  });

  @override
  Future<AccountEntity> load() async {
    try {
      return await secure.load();
    } catch (error) {
      return await local.load();
    }
  }
}
