import 'package:money_manager/contraints/db_keys.dart';
import 'package:money_manager/model/resources/transaction.dart' as resource;
import 'package:money_manager/repository/db_repository.dart';
import 'package:sembast/sembast.dart';

class TransactionDao{
  Future<Database> get _db async => DBRepository.instance.db;

  final StoreRef<int, Map<String, dynamic>> _store =
  intMapStoreFactory.store(DBKeys.DB_TRANSACTION_KEY);

  Future<void> updateOrInsert(resource.Transaction transaction) async {

    await _store
        .record(transaction.id)
        .put(await _db, transaction.toSembastMap());
  }

  Future<void> delete(resource.Transaction transaction) async {
    await _store.record(transaction.id).delete(await _db);
  }

  Future<List<resource.Transaction>> getAll() async {
    final List<RecordSnapshot<int, Map<String, dynamic>>> recordSnapshots =
    await _store.find(await _db);

    return recordSnapshots
        .map((RecordSnapshot<int, Map<String, dynamic>> snapshot) =>
        resource.Transaction(json: snapshot.value))
        .toList();
  }

}