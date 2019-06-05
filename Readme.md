# Banken, Konten und eine Aufsichtsbehörde

Erstellen Sie zunächst eine Klasse ``Account``, die das Guthaben eines Kontos verwaltet. Zum Anlegen eines Kontos benötigt man (zur Vereinfachung der Aufgabenstellung) nur eine Kontonummer. Die Klasse soll die Methoden ``deposit`` zum Einzahlen und ``withDraw`` zum Abheben besitzen. Das Konto soll man nicht überziehen können, definieren Sie zu diesem Zweck den Rückgabewert der Methode ``withDraw`` vom Typ ``bool``. Auskünfte über das Bankkonto können mit Hilfe der *getter*-Methoden ``Number`` und ``Balance`` eingeholt werden. Die Eigenschaft ``Balance`` liefert den aktuellen Kontostand zurück. Um Geldbeträge von einem Konto zu einem anderen Konto transferieren zu können, gibt es die Methode ``transfer``.

### Girokonten, Sparkonten und Studentenkonten

Schreiben Sie drei weitere Klassen ``CurrentAccount`` (Girokonto), ``SavingsAccount`` (Sparkonto) und ``StudentsAccount`` (Studentenkonto), die Sie geeignet mit der Klasse ``Account`` in Beziehung setzen. Die drei Klassen sollen folgende Eigenschaften besitzen:

* Ein Girokonto darf um ein Dispolimit überzogen werden, das bei der Kontoeröffnung festzulegen ist. Das Dispolimit ist als Eigenschaft der Klasse ``CurrentAccount`` zu realisieren und kann zu einem späteren Zeitpunkt auch angepasst werden. Der Einfachheit halber legen wir zu Grunde, dass für das Überziehen des Girokontos keine Zinsen zu entrichten sind.

* Auf einem Sparkonto fallen für das eingezahlte Geld Zinsen an. Der Zinssatz des Sparkontos ist als Eigenschaft der Klasse ``SavingsAccount`` darzustellen. Nach der Kontoeröffnung kann der Zinssatz nicht mehr geändert werden. Für die Gutschrift der Zinsen auf dem Sparkonto bedarf es einer zusätzlichen Methode ``computeInterest``. Diese Methode besitzt als Parameter die Anzahl der Tage, für die die Zinsen gutzuschreiben sind. Die Zinsen sind nach der Formel

   <img src="assets/BankAndInterestRate.png" width="300">
   zu berechnen.

* Ein Stundentenkonto entspricht einem Konto ohne Überziehungsrahmen. 

### Bankinstitut

Erstellen Sie ein Bankinstitut (Klasse ``Bank``), das eine bestimmte Anzahl von Bankkonten verwaltet. Das Bankinstitut sollte Methoden besitzen, um ein Spar-, Giro- und ein normales Konto (Studentenkonto) eröffnen zu können. Zusätzlich gewährt das Institut einen Einblick in die Liquidität des Hauses und gibt die Höhe aller Einlagen mit der Eigenschaft ``TotalBalance`` preis.

### Bankenaufsichtsbehörde

In den Zeiten von *Bahamas-Leaks* werden alle Geldbewegungen von einer Bankenaufsichtsbehörde überwacht. Zu diesem Zweck benötigen Sie zunächst eine Klasse ``Transaction``, die die für eine Geldbewegung relevanten Information (Kontonummer des Absenders, Kontonummer des Empfängers und Geldbetrag) zusammenfasst:

```dart
class Transaction {
  int _sourceAccount;
  int _targetAccount;
  num _amount;
  ...
}
```

Die Bankenaufsichtsbehörde selbst realisieren Sie als Klasse ``ControllingInstitution``. Die Klasse muss in einer ersten Realisierung nicht sehr umfangreich sein, es genügt eine Methode mit folgender Schnittstellendefinition:

```dart
void monitor(Transaction transaction) { ... }
```

Diese Methode ist immer dann aufzurufen, wenn am Bankinstitut die ``Transfer``-Methode zur Ausführung gelangt. Bleibt noch zu klären,
wie zwei an sich nicht miteinander in Berührung stehende Objekte (``Bank``- und ``ControllingInstitution``-Objekt) Daten austauschen können,
bzw. ganz konkret formuliert: Wie kommt es zum Aufruf der ``monitor``-Methode?

In Dart bietet sich hierfür das *Stream*-Konzept an. Ergänzen Sie die Klasse ``Bank`` um zwei Instanzvariablen des Typs ``StreamController`` und ``Stream<Transaction>``. ``StreamController``-Objekte stellen die Infrastruktur für Streams in Dart dar. Mit der ``listen``-Methode an einem ``Stream<Transaction>``-Objekt lassen sich Methoden anmelden, die bei vorliegenden Daten (also einem ``Transaction``-Objekt in unserem Fall) aufgerufen werden. Der Stream selbst bekommt seine Daten mit Hilfe des ``StreamController``-Objekts, das für diesen Zweck eine ``add``-Methode bereitstellt. Weitere Informationen zum Dart-Streamkonzept finden Sie in der Dart-Onlinedokumention vor.

Bei erfolgreicher Zusammenarbeit zwischen einem Bankinstitut und der Bankenaufsichtsbehörde könnte ein Protokoll für alle ``transfer``-Methodenaufrufe so aussehen:

```dart
Noticed transaction:
  From:1018 -> To:1019:
  Amount=100
Noticed transaction:
  From:1019 -> To:1018:
  Amount=100
Noticed transaction:
  From:1018 -> To:1019:
  Amount=100
Noticed transaction:
  From:1019 -> To:1018:
  Amount=100
Noticed transaction:
  From:1018 -> To:1019:
  Amount=100
Noticed transaction:
  From:1019 -> To:1018:
  Amount=100
```

Der Testrahmen, der dieses Protokoll erzeugt, könnte so aussehen:

```dart
void test_compliance() {
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
}
```