# Banken, Konten und eine Aufsichtsbehörde

Erstellen Sie zunächst eine Klasse ``Account``, die das Guthaben eines Kontos verwaltet. Zum Anlegen eines Kontos benötigt man (zur Vereinfachung der Aufgabenstellung) nur eine Kontonummer. Die Klasse soll die Methoden ``deposit`` zum Einzahlen und ``withDraw`` zum Abheben besitzen. Das Konto soll man nicht überziehen können, definieren Sie zu diesem Zweck den Rückgabewert der Methode ``withDraw`` vom Typ ``bool``. Auskünfte über das Bankkonto können mit Hilfe der *getter*-Methoden ``Number`` und ``Balance`` eingeholt werden. Die Eigenschaft ``Balance`` liefert den aktuellen Kontostand zurück.

### Girokonten, Sparkonten und Studentenkonten

Schreiben Sie drei weitere Klassen ``CurrentAccount`` (Girokonto), ``SavingsAccount`` (Sparkonto) und ``StudentsAccount`` (Studentenkonto), die Sie geeignet mit der Klasse ``Account`` in Beziehung setzen. Die drei Klassen sollen folgende Eigenschaften besitzen:

* Ein Girokonto darf um ein Dispolimit überzogen werden, das bei der Kontoeröffnung festzulegen ist. Das Dispolimit ist als Eigenschaft der Klasse ``CurrentAccount`` zu realisieren und kann zu einem späteren Zeitpunkt auch angepasst werden. Der Einfachheit halber legen wir zu Grunde, dass für das Überziehen des Girokontos keine Zinsen zu entrichten sind.

* Auf einem Sparkonto fallen für das eingezahlte Geld Zinsen an. Der Zinssatz des Sparkontos ist als Eigenschaft der Klasse ``SavingsAccount`` darzustellen. Nach der Kontoeröffnung kann der Zinssatz nicht mehr geändert werden. Für die Gutschrift der Zinsen auf dem Sparkonto bedarf es einer zusätzlichen Methode ``computeInterest``. Diese Methode besitzt als Parameter die Anzahl der Tage, für die die Zinsen gutzuschreiben sind. Die Zinsen sind nach der Formel

   <img src="assets/BankAndInterestRate.png" width="300">

   zu berechnen.

* 

### Bankinstitut

Erstellen Sie ein Bankinstitut (Klasse ``Bank``), das eine bestimmte Anzahl von Bankkonten verwaltet. Das Bankinstitut sollte Methoden besitzen, um ein Spar-, Giro- und ein normales Konto (Studentenkonto) eröffnen zu können. Zusätzlich gewährt das Institut einen Einblick in die Liquidität des Hauses und gibt die Höhe aller Einlagen mit der Eigenschaft ``TotalBalance`` preis.

### Bankenaufsichtsbehörde

#TBD



