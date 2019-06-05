import 'account.dart';

class CurrentAccount extends Account {
  // member data
  num _limit;

  CurrentAccount({num limit = 0})
      : _limit = limit,
        super() {}

  @override
  bool withDraw(num amount) {
    if (Balance + _limit < amount) return false;

    Balance -= amount;
    return true;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    if (!(super == other as Account)) return false;
    final CurrentAccount otherAccount = other;
    return otherAccount._limit == _limit;
  }

  @override
  String toString() {
    String s0 = super.toString();
    String s1 = 'CurrentAccount: Limit = ${_limit}';
    return '${s0}\n  ${s1}';
  }
}
