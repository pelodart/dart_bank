abstract class Account {
  // member data
  int _number;
  num _balance;

  static int _nextNumber = 1000;

  // c'tor(s)
  Account()
      : _number = _nextNumber,
        _balance = 0.0 {
    _nextNumber++;
  }

  // getter/setter
  int get Number => _number;
  num get Balance => _balance;
  set Balance(num value) => _balance = value;

  // public interface
  void deposit(num amount) {
    _balance += amount;
  }

  // public abstract contract for derived classes
  bool withDraw(num amount);

  bool transfer(Account target, num amount) {
    if (!this.withDraw(amount)) return false;

    target.deposit(amount);
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final Account otherAccount = other;
    return otherAccount._number == _number && otherAccount._balance == _balance;
  }

  @override
  String toString() {
    String s1 = 'Account No.: ${_number}';
    String s2 = '  Balance = ${_balance}';
    return '${s1}\n${s2}';
  }
}
