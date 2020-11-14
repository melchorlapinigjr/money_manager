enum TransactionType{
  income,
  expense,
  investment
}

extension TransactionTypeToString on TransactionType{
  String get convertString{
    String val;

    switch (this){
      case TransactionType.income:
        val = 'income';
      break;

      case TransactionType.expense:
        val = 'expense';
        break;

      case TransactionType.investment:
        val = 'investment';
        break;
    }
    return val;
  }
}