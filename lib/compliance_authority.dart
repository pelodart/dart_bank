import 'transaction.dart';

class ComplianceAuthority {
  void monitor(Transaction transaction) {
    int from = transaction.SourceAccount;
    int to = transaction.TargetAccount;
    num amount = transaction.Amount;

    print('Noticed transaction:\n  From:${from} -> To:${to}:\n  Amount=${amount}');
  }
}
