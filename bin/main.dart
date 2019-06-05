import '../lib/bank.dart';
import '../lib/controlling_institution.dart';
import '../lib/current_account.dart';
import '../lib/savings_account.dart';
import '../lib/students_account.dart';

void main() {
  test_01_current_account();
  test_02_students_account();
  test_03_savings_account();
  test_04_transfer();
  test_05_equals();
  test_06_bank();
  test_07_bank();
  test_08_compliance();
}

void test_01_current_account() {
  CurrentAccount a1 = new CurrentAccount(limit: 100);
  a1.deposit(50);
  print(a1);
  a1.deposit(50);
  print(a1);
  a1.withDraw(20);
  print(a1);

  CurrentAccount a2 = new CurrentAccount(limit: 50);
  a2.withDraw(100);
  print(a2);
  a2.deposit(50);
  print(a2);
  a2.deposit(50);
  print(a2);

  CurrentAccount a3 = new CurrentAccount();
  a3.withDraw(100);
  print(a3);
  a3.deposit(50);
  print(a3);
}

void test_02_students_account() {
  StudentsAccount a1 = StudentsAccount();
  a1.withDraw(10);
  print(a1);
  a1.deposit(50);
  a1.withDraw(100);
  print(a1);

  StudentsAccount a2 = StudentsAccount();
  a2.withDraw(10);
  print(a2);
  a2.deposit(50);
  a2.deposit(50);
  a2.deposit(50);
  a2.withDraw(145);
  print(a2);
}

void test_03_savings_account() {
  SavingsAccount a1 = SavingsAccount(interestRate: 1.5);
  a1.deposit(100);

  for (int i = 0; i < 10; i++) {
    print(a1);
    a1.computeInterest(365);
  }
}

void test_04_transfer() {
  CurrentAccount a1 = new CurrentAccount();
  CurrentAccount a2 = new CurrentAccount();
  a1.deposit(50.0);
  print(a1);
  print(a2);
  a1.transfer(a2, 50.0);
  print(a1);
  print(a2);
}

void test_05_equals() {
  CurrentAccount a1 = new CurrentAccount();
  CurrentAccount a2 = new CurrentAccount();
  a1.deposit(50.0);
  a2.deposit(50.0);
  print(a1 == a2);

  StudentsAccount a3 = new StudentsAccount();
  StudentsAccount a4 = new StudentsAccount();
  a3.deposit(50.0);
  a3.deposit(50.0);
  print(a3 == a4);
}

void test_06_bank() {
  Bank sparkasse = Bank('Sparkasse');

  int number1 = sparkasse.createCurrentAccount();
  sparkasse.deposit(number1, 100);
  sparkasse.deposit(number1, 100);
  sparkasse.deposit(number1, 100);
  sparkasse.withDraw(number1, 200);

  int number2 = sparkasse.createSavingsAccount();
  sparkasse.deposit(number2, 500);
  sparkasse.withDraw(number2, 250);
  sparkasse.deposit(number2, 600);

  int number3 = sparkasse.createCurrentAccount();
  sparkasse.deposit(number3, 300);
  sparkasse.withDraw(number3, 150);
  sparkasse.deposit(number3, 400);

  print(sparkasse);
  print('Total Balance of ${sparkasse.Name}: ${sparkasse.TotalBalance}');
  sparkasse.transfer(number2, number3, 300);
  print(sparkasse);
  print('Total Balance of ${sparkasse.Name}: ${sparkasse.TotalBalance}');
}

void test_07_bank() {
  Bank sparkasse = Bank('Sparkasse');

  int number1 = sparkasse.createCurrentAccount();
  sparkasse.depositEx(number1, 100);
  sparkasse.depositEx(number1, 100);
  sparkasse.depositEx(number1, 100);
  sparkasse.withDrawEx(number1, 200);

  int number2 = sparkasse.createSavingsAccount();
  sparkasse.depositEx(number2, 500);
  sparkasse.withDrawEx(number2, 250);
  sparkasse.depositEx(number2, 600);

  int number3 = sparkasse.createCurrentAccount();
  sparkasse.depositEx(number3, 300);
  sparkasse.withDrawEx(number3, 150);
  sparkasse.depositEx(number3, 400);

  print(sparkasse);
  print('Total Balance of ${sparkasse.Name}: ${sparkasse.TotalBalance}');
  sparkasse.transferEx(number2, number3, 300);
  print(sparkasse);
  print('Total Balance of ${sparkasse.Name}: ${sparkasse.TotalBalance}');
}

void test_08_compliance() async {
  Bank sparkasse = Bank('Sparkasse');

  ControllingInstitution authority = ControllingInstitution();
  sparkasse.subscribe(authority.monitor);

  int number1 = sparkasse.createCurrentAccount();
  sparkasse.depositEx(number1, 1000);

  int number2 = sparkasse.createCurrentAccount();
  sparkasse.depositEx(number2, 1000);

  sparkasse.transferEx(number1, number2, 100);
  sparkasse.transferEx(number2, number1, 100);
  sparkasse.transferEx(number1, number2, 100);
  sparkasse.transferEx(number2, number1, 100);
  sparkasse.transferEx(number1, number2, 100);
  sparkasse.transferEx(number2, number1, 100);

  sparkasse.unsubscribe();

  print('Done.');
}
