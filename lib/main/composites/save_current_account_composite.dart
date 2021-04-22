import '../../data/usecases/save_current_account/save_current_account.dart';
import '../../data/usecases/usecases.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

class SaveCurrentAccountComposite implements SaveCurrentAccount {
  final SecureLocalSaveCurrentAccount secure;
  final LocalSaveCurrentAccount local;

  SaveCurrentAccountComposite({required this.secure, required this.local});
  @override
  Future<void> save(AccountEntity account) async {
    try {
      return await secure.save(account);
    } catch (error) {
      return await local.save(account);
    }
  }
}
