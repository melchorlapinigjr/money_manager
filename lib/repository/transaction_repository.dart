import 'package:money_manager/dao/transaction_dao.dart';
import 'package:money_manager/model/resources/transaction.dart';

class TransactionRepository{
  final TransactionDao _dao = TransactionDao();

  Future<void> upsert(Transaction transaction) async {
    //update db
    _dao.updateOrInsert(transaction);
  }

  Future<void> delete(Transaction transaction) async {
    _dao.delete(transaction);
  }

  Future<List<Transaction>> getAll() async {
    return await _dao.getAll();
  }

}