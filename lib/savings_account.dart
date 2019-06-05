import 'account.dart';

class SavingsAccount extends Account {
  num _interestRate;

  SavingsAccount({num interestRate = 1.5})
      : _interestRate = interestRate,
        super() {}

  // getter(s)
  int get InterestRate => _interestRate;

  // public interface
  void computeInterest(int numDays) {
    num interest = (numDays * _interestRate * Balance) / 365.0 / 100.0;
    Balance += interest;
  }

  @override
  bool withDraw(num amount) {
    if (Balance < amount) return false;

    Balance -= amount;
    return true;
  }

    @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (!(super == other as Account)) return false;
    final SavingsAccount otherAccount = other;
    return otherAccount._interestRate == _interestRate;
  }

  @override
  String toString() {
    String s0 = super.toString();
    String s1 = 'SavingsAccount: InterestRate = ${_interestRate}';
    return '${s0}\n  ${s1}';
  }
}
