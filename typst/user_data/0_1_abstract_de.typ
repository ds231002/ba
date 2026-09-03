//Deutsche Kurzfassung

#text(lang: "de")[
  #set par(justify: true)

// Enthält:
// - Motivation,
// - Problemstellung,
// - Ergebnisse
// - (Inhalt siehe englische Version)

Large Language Models (LLMs) können über Tool-Aufrufe auf externe Datenquellen zugreifen und dadurch Aufgaben der Zeitreihenanalyse automatisiert bearbeiten. Dabei stellt sich die Frage, wie sich unterschiedliche Grade der Autonomie bei der Orchestrierung dieser Tool-Aufrufe auf die Qualität und den Ressourcenbedarf der Ausführung auswirken. Diese Arbeit untersucht daher den Einfluss von deterministischer, planbasierter und iterativer Tool-Orchestrierung bei der Analyse von Zeitreihendaten in Energiegemeinschaften.

Hierzu wurden drei Orchestrierungsmethoden anhand von 90 Aufgaben und drei Large Language Models evaluiert. Die Bewertung erfolgte hinsichtlich Korrektheit und Effizienz sowie ergänzend anhand von Laufzeit, Tokenverbrauch und Fehlerrate. Die Ergebnisse zeigen, dass die deterministische Methode im untersuchten Versuchsaufbau mit einer Korrektheit von 0,72 und einer Effizienz von 0,65 die besten Gesamtwerte erreicht. Die planbasierte Methode erzielt 0,59 beziehungsweise 0,49, während die iterative Methode mit 0,44 beziehungsweise 0,38 die niedrigsten Werte aufweist. Gleichzeitig steigen mit zunehmendem Autonomiegrad sowohl der Tokenverbrauch als auch die Fehlerrate. Der Tokenverbrauch erhöht sich von durchschnittlich 4.019 Tokens bei der deterministischen auf 8.273 Tokens bei der iterativen Methode.

Die Auswirkungen des Autonomiegrads hängen zudem vom Aufgabentyp und vom verwendeten Modell ab. Besonders bei Aufgaben mit mehreren voneinander abhängigen Verarbeitungsschritten treten deutliche Unterschiede zwischen den Orchestrierungsmethoden auf. Ein Vorteil autonomerer Methoden konnte in diesem Bereich nicht nachgewiesen werden. Auch zwischen den untersuchten Modellen zeigen sich Unterschiede; eine größere Modellgröße führt dabei nicht grundsätzlich zu besseren Ergebnissen.

Die Ergebnisse zeigen somit, dass ein höherer Autonomiegrad in der untersuchten Konfiguration mit geringerer Ausführungsqualität und höherem Ressourcenbedarf verbunden ist. Die Wahl der Orchestrierungsmethode sollte daher abhängig von Aufgabe, Modell und den Anforderungen an Zuverlässigkeit, Flexibilität und Ressourcenverbrauch erfolgen.

]