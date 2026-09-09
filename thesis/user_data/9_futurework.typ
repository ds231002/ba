#import "../globals.typ": *

#context if text.lang == "de" [
    == Weiterführende Arbeiten
    <sec:future_work>
] else [
    == Future Work
    <sec:future_work>
]

Aufbauend auf den Ergebnissen bieten sich mehrere Ansätze für weiterführende Untersuchungen an. Dazu zählen die Evaluation weiterer Modelle und Modellgrößen sowie eine systematische Variation der Systemprompts. Darüber hinaus sollte untersucht werden, wie unterschiedliche Zustandsrepräsentationen, Terminierungsstrategien, Iterationsgrenzen und Timeout-Werte die Korrektheit und den Ressourcenbedarf beeinflussen.

Besonders interessant ist ein direkter Vergleich zwischen vollständig LLM-gesteuerter und hybrider Orchestrierung. Dabei könnte untersucht werden, ob sich der zusätzliche Entscheidungsspielraum autonomer Verfahren mit deterministischen Kontrollmechanismen kombinieren lässt. Insbesondere die Erkennung redundanter Toolaufrufe, die Begrenzung der Iterationsanzahl und die Behandlung von Timeouts bieten hierfür konkrete Ansatzpunkte.

Die vorliegende differenzierte Betrachtung von Aufgabentyp und Orchestrierungsmethode bietet zudem Ansatzpunkte für eine weitergehende Untersuchung der Ursachen der beobachteten Leistungsunterschiede. Dabei könnte insbesondere untersucht werden, welche konkreten Eigenschaften von Aufgaben mit mehreren voneinander abhängigen Verarbeitungsschritten für die geringere Korrektheit und Effizienz autonomerer Verfahren verantwortlich sind. Hierzu könnten Aufgaben gezielt hinsichtlich der Anzahl, Reihenfolge und Abhängigkeit der erforderlichen Toolaufrufe parametrisiert und in unterschiedlichen Ausprägungen untersucht werden. Auf diese Weise ließe sich genauer bestimmen, unter welchen Bedingungen ein größerer Entscheidungsspielraum tatsächlich einen Vorteil gegenüber stärker vorstrukturierten Orchestrierungsansätzen bietet.

Ein weiterer Ansatzpunkt für weiterführende Untersuchungen ergibt sich aus den beobachteten Timeouts, die insbesondere bei den lokal ausgeführten Modellen auftraten. Im Rahmen der vorliegenden Untersuchung konnte nicht abschließend bestimmt werden, wodurch diese Timeouts verursacht wurden. Bei einzelnen Ausführungen entstand der Eindruck, dass das Modell innerhalb der verfügbaren Zeit nicht zu einer abschließenden Entscheidung gelangte und die Verarbeitung dadurch nicht beendet wurde. Es lässt sich anhand der vorliegenden Messungen jedoch nicht feststellen, ob hierfür beispielsweise die Komplexität der Aufgabe, die Anzahl der erforderlichen Verarbeitungsschritte, das verwendete Modell oder die lokale Ausführungsumgebung verantwortlich war.

Eine weiterführende Untersuchung könnte daher die Ursachen dieser Timeouts gezielt analysieren. Dabei könnten unter anderem unterschiedliche Modelle, Modellgrößen und Ausführungsumgebungen miteinander verglichen sowie die Anzahl und Abhängigkeit der erforderlichen Toolaufrufe systematisch variiert werden. Zusätzlich könnte untersucht werden, ob bestimmte Orchestrierungsstrategien oder Begrenzungen der maximalen Iterations- beziehungsweise Verarbeitungsdauer das Auftreten von Timeouts reduzieren. Alternativ könnte der Versuchsaufbau gezielt auf Modelle beschränkt werden, die unter den jeweiligen Bedingungen zuverlässig innerhalb des vorgegebenen Zeitlimits eine Ausgabe erzeugen. Dadurch ließe sich die Fehlerquelle Timeout entweder kontrollierter untersuchen oder für bestimmte Vergleichsexperimente weitgehend ausschließen.