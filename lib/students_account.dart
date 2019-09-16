import 'account.dart';

class StudentsAccount extends Account {

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
    return super == other as Account;
  }

  @override
  String toString() {
    String s0 = super.toString();
    String s1 = 'StudentsAccount';
    return '${s0}\n  ${s1}';
  }
}
