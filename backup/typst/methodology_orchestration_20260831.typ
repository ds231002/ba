== Orchestrierungsstartegien

#figure(
  image("../figures/orchestrierungsmethoden.drawio.png", width: 90%),
  caption: [Orchestrierungsstrategien],
) <orchestrierungsmethoden>

=== Gemeinsame Grundlage

// Systemprompt
Möglichst ähnliche Systemprompts um vergleichbarkeit zu wahren. Nur Struktur wurde entsprechend anders erklärt. Allgemeine Informationen bleiben gleich. Toolbeschreibung ist bei Methode 2 und 3 gleich. Nur Methode 1 hat aufgrund der Pipelines eine andere Tools und damit eine andere Toolbeschreibung. Dessen Struktur ist aber identisch.

Kleine Modelle brauchen oft deutlich klarere und ausführlichere Anweisungen.

// result.json - gleiche Struktur
Jeder Toolaufruf erhält eine eindeutige ID. Bei Methode 2 entspricht diese der Position des Aufrufs im vorab generierten Plan. Bei Methode 3 kodiert die ID zusätzlich die Iteration, in der der Toolaufruf erfolgt. Nach Ausführung dient dieselbe ID zur Referenzierung des erzeugten Ergebnisses.

Alle drei Methoden verwenden dieselbe grundlegende Tool-Infrastruktur. Das LLM erhält:

- die Benutzeranfrage,
- einen System-Prompt,
- die verfügbaren Tools mit ihren Definitionen,
- den Benutzerkontext,
- zeitliche Rahmenbedingungen,
- Datenverfügbarkeiten,
- fachliche Zusammenhänge bzw. Berechnungsregeln.

Die Kommunikation mit dem lokalen Modell erfolgt über eine OpenAI-kompatible Schnittstelle zu Ollama. Die Modellwahl ist dabei unabhängig von der jeweiligen Orchestrierungsmethode.

Für jeden LLM-Aufruf werden folgende Kennzahlen erfasst:

- Laufzeit,(timeout von 120 Sekunden)
- Input-Tokens,
- Output-Tokens,
- Gesamtzahl der Tokens,
- Finish Reason.

Bei iterativen Verfahren werden die Werte zusätzlich für jede Iteration separat gespeichert und anschließend zu total_usage aggregiert.

=== Methode 1: Deterministisch

Die erste Methode stellt den einfachsten Orchestrierungsansatz dar.

Das LLM erhält die Benutzeranfrage und die verfügbaren Tools und erzeugt unmittelbar die benötigten Toolaufrufe. Eine explizite Planung oder Aufteilung in mehrere LLM-Iterationen findet nicht statt.

Das Ergebnis wird in einer einheitlichen Struktur gespeichert

=== Methode 2: Planbasiert

- Das LLM erstellt zunächst einen vollständigen Plan.
- Die im Plan enthaltenen Funktionen werden anschließend durch das System abgearbeitet.
- Der Zustand ist zunächst statisch und erfordert keine iterative Verarbeitung durch das LLM.
- Ein zentraler Bestandteil ist die Referenzierung vorheriger Ergebnisse. Die Orchestrierungsschicht löst die Referenz auf und übergibt das entsprechende Ergebnis an das nachfolgende Tool.

=== Methode 3: Iterativ

Hier erstellt das LLM keinen vollständigen Plan im Voraus. Stattdessen entscheidet es iterativ, welche Tools als Nächstes benötigt werden.

- iterativ
- mehrere unabhängige Toolaufrufe pro Interpretation
- Limit von 6 Iterationen