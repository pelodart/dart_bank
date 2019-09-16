class Transaction {
  int _sourceAccount;
  int _targetAccount;
  num _amount;

  Transaction({int sourceAccount, int targetAccount, num amount}) {
    _sourceAccount = sourceAccount;
    _targetAccount = targetAccount;
    _amount = amount;
  }

  // getter(s)
  int get SourceAccount => _sourceAccount;
  int get TargetAccount => _targetAccount;
  num get Amount => _amount;
}
