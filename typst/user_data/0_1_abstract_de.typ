//Deutsche Kurzfassung

#text(lang: "de")[
  #set par(justify: true)

// Enthält:
// - Motivation,
// - Problemstellung,
// - Ergebnisse
// - (Inhalt siehe englische Version)

Large Language Models (LLMs) werden zunehmend eingesetzt, um komplexe Informationsanfragen unter Einbeziehung externer Werkzeuge zu bearbeiten. Die vorliegende Arbeit untersucht, wie sich unterschiedliche Grade der Autonomie bei der Tool-Orchestrierung auf die Korrektheit und den Ressourcenbedarf bei der Analyse von Zeitreihendaten in Energiegemeinschaften auswirken.

Hierzu wurden eine deterministische, eine planbasierte und eine iterative Orchestrierungsmethode mit unterschiedlichen Large Language Models evaluiert. Die Bewertung erfolgte anhand der Korrektheit und Effizienz der Ausführung sowie der ergänzenden Kriterien Laufzeit, Tokenverbrauch und Fehlerrate.

Die Ergebnisse zeigen, dass die deterministische Methode mit einer Korrektheit von 0,72 und einer Effizienz von 0,65 die besten Ergebnisse erzielte. Mit zunehmendem Autonomiegrad nahmen Korrektheit und Effizienz ab, während Laufzeit, Tokenverbrauch und Fehlerrate zunahmen. Die iterative Methode erreichte mit einer Korrektheit von 0,44 und einer Effizienz von 0,38 die niedrigsten Werte und wies zugleich den höchsten Ressourcenbedarf auf. Darüber hinaus zeigten sowohl die Aufgabenkomplexität als auch die Wahl des verwendeten Modells einen deutlichen Einfluss auf die Ergebnisse.

Die Untersuchung zeigt damit einen Trade-off zwischen dem zusätzlichen Entscheidungsspielraum autonomerer Orchestrierungsansätze und den damit verbundenen Einbußen bei Korrektheit, Effizienz und Ressourcenbedarf. Ein höherer Autonomiegrad kann grundsätzlich eine flexiblere Steuerung des Ausführungsablaufs ermöglichen, ist in der untersuchten Konfiguration jedoch mit einer höheren Fehleranfälligkeit und einem höheren Ressourcenbedarf verbunden. Die Wahl des Orchestrierungsansatzes sollte daher vom konkreten Anwendungsszenario und dem tatsächlich erforderlichen Entscheidungsspielraum abhängig gemacht werden.

]
