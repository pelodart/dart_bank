import 'dart:async';

import 'account.dart';
import 'current_account.dart';
import 'savings_account.dart';
import 'students_account.dart';
import 'transaction.dart';

class Bank {
  String _name;
  List<Account> _accounts;
  StreamController _streamController;
  Stream<Transaction> _transactionsStream;

  Bank([String name = 'My Bank']) {
    _name = name;
    _accounts = List<Account>();
    _streamController = new StreamController<Transaction>();
    _transactionsStream = _streamController.stream;
  }

  // getter(s)
  String get Name => _name;

  num get TotalBalance {
    num total = 0;
    _accounts.forEach((account) => total += account.Balance);
    return total;
  }

  Stream<Transaction> get TransactionsStream => _transactionsStream;

  // public interface
  int createCurrentAccount({num limit = 0}) {
    CurrentAccount a = CurrentAccount(limit: limit);
    _accounts.add(a);
    return a.Number;
  }

  int createSavingsAccount({num interestRate = 1.5}) {
    SavingsAccount a = SavingsAccount(interestRate: interestRate);
    _accounts.add(a);
    return a.Number;
  }

  int createStudentsAccount() {
    StudentsAccount a = StudentsAccount();
    _accounts.add(a);
    return a.Number;
  }

  bool deposit(int number, num amount) {
    // search account
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].Number == number) {
        // credit account
        _accounts[i].deposit(amount);
        return true;
      }
    }
    return false;
  }

  bool depositEx(int number, num amount) {
    Iterable<Account> accounts =
        _accounts.where((account) => account.Number == number);
    assert(accounts.length == 1);
    if (accounts.length == 1) {
      accounts.elementAt(0).deposit(amount);
      return true;
    }
    return false;
  }

  bool withDraw(int number, num amount) {
    // search account
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].Number == number) {
        // charge account
        return _accounts[i].withDraw(amount);
      }
    }
    return false;
  }

  bool withDrawEx(int number, num amount) {
    Iterable<Account> accounts =
        _accounts.where((account) => account.Number == number);
    assert(accounts.length == 1);
    if (accounts.length == 1) {
      return accounts.elementAt(0).withDraw(amount);
    }
    return false;
  }

  bool transfer(int source, int target, num amount) {
    if (source == target) return false;

    // search account to charge
    Account chargeAccount = null;
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].Number == source) {
        chargeAccount = _accounts[i];
        break;
      }
    }
    if (chargeAccount == null) return false;

    // search account to credit
    Account creditAccount = null;
    for (int i = 0; i < _accounts.length; i++) {
      if (_accounts[i].Number == target) {
        creditAccount = _accounts[i];
        break;
      }
    }
    if (creditAccount == null) return false;

    bool success = chargeAccount.transfer(creditAccount, amount);

    if (success) {
      Transaction transaction = Transaction(
          sourceAccount: source, targetAccount: target, amount: amount);

      _streamController.add(transaction);
      return true;
    } else {
      return false;
    }
  }

  bool transferEx(int source, int target, num amount) {
    if (source == target) return false;

    Iterable<Account> chargeAccounts =
        _accounts.where((test) => test.Number == source);
    assert(chargeAccounts.length == 1);

    Iterable<Account> creditAccounts =
        _accounts.where((test) => test.Number == target);
    assert(creditAccounts.length == 1);

    if (chargeAccounts.length == 1 && creditAccounts.length == 1) {
      bool success = chargeAccounts
          .elementAt(0)
          .transfer(creditAccounts.elementAt(0), amount);

      if (success) {
        Transaction transaction = Transaction(
            sourceAccount: source, targetAccount: target, amount: amount);

        _streamController.add(transaction);
        return true;
      }
    }
    return false;
  }

  void subscribe(void onData(Transaction event)) {
    _transactionsStream.listen(onData);
  }

  void unsubscribe() {
    _streamController.close();
  }

  @override
  String toString() {
    String s = "${_name}\n";
    for (Account a in _accounts) {
      s += "  ${a}\n";
    }
    return s;
  }
}
