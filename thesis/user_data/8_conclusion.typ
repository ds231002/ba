#import "../globals.typ": *

#context if text.lang == "de" [
    = Fazit
    <sec:conclusion>
] else [
    = Conclusion
    <sec:conclusion>
]

// 2 Seiten

// - Lokale LLMs eignen sich grundsätzlich für Tool-gestützte Datenabfragen.
// - Ein plan-basierter Ansatz ist für kleinere Modelle offenbar leichter umzusetzen als eine iterative Orchestrierung.
// - Der iterative Ansatz stellt höhere Anforderungen an das LLM, da neben der Tool-Auswahl auch Zustandsverarbeitung, Fortschrittskontrolle und Terminierung erforderlich sind.
// - Die explizite Bereitstellung bereits verfügbarer Ergebnisse reicht nicht zwangsläufig aus, damit kleinere LLMs diese zuverlässig in nachfolgenden Entscheidungen verwenden.
// - Größere Modelle scheinen den iterativen Zustand besser erfassen zu können.
// - Größere Modelle lösen jedoch nicht automatisch Probleme mit redundanten Tool Calls und zuverlässiger Terminierung.
// - Eine Kombination aus LLM-basierter Entscheidungsfindung und deterministischer Kontrolle durch den Orchestrator erscheint daher als vielversprechender Ansatz.
// - Laufzeit, Timeout und Iterationsanzahl müssen bei der Bewertung lokaler LLMs berücksichtigt werden.
// - Eine faire Evaluation benötigt mehrere Kriterien, insbesondere Korrektheit, Effizienz und Robustheit.

Ziel dieser Arbeit war es, zu untersuchen, wie sich der Grad der Autonomie bei der Tool-Orchestrierung von Large Language Models auf die Korrektheit und den Ressourcenbedarf bei der Analyse von Zeitreihendaten in Energiegemeinschaften auswirkt. Hierzu wurden eine deterministische, eine planbasierte und eine iterative Orchestrierungsmethode anhand von 90 Aufgaben und drei unterschiedlichen Aufgabentypen evaluiert. Insgesamt wurden 810 Ausführungen mit drei verschiedenen Large Language Models durchgeführt und hinsichtlich Korrektheit, Effizienz, Laufzeit, Tokenverbrauch und Fehlerrate bewertet.

Die Ergebnisse zeigen in der untersuchten Konfiguration einen Zusammenhang zwischen dem Autonomiegrad und der Ausführungsqualität. Die deterministische Methode erzielte mit einer Korrektheit von 0,72 und einer Effizienz von 0,65 die höchsten Gesamtwerte. Die planbasierte Methode erreichte 0,59 beziehungsweise 0,49, während die iterative Methode mit 0,44 beziehungsweise 0,38 die niedrigsten Werte aufwies. Gleichzeitig stieg der Ressourcenbedarf mit zunehmendem Autonomiegrad. Der durchschnittliche Tokenverbrauch erhöhte sich von 4.019 Tokens bei der deterministischen über 5.331 bei der planbasierten auf 8.273 Tokens bei der iterativen Methode. Auch die Fehlerrate stieg von 0,15 über 0,29 auf 0,31.

Die Betrachtung der Korrektheits- und Effizienzkomponenten zeigt, dass die Unterschiede zwischen den Methoden bereits bei der Toolauswahl auftreten. Die Werte für die Argumentübergabe liegen bei allen drei Methoden nur geringfügig unter den entsprechenden Werten der Toolauswahl. Dies deutet darauf hin, dass die Argumentübergabe im untersuchten Setup keinen wesentlich größeren zusätzlichen Fehlerbeitrag darstellt, wenn ein geeignetes Tool ausgewählt wurde.

Darüber hinaus zeigt sich, dass die Auswirkungen des Autonomiegrads vom Aufgabentyp abhängen. Bei direkten Datenabfragen liegen die Methoden hinsichtlich Korrektheit und Effizienz vergleichsweise nah beieinander. Bei der Mehrquellenverarbeitung verstärken sich die Unterschiede dagegen deutlich. Hier erreicht die deterministische Methode eine Korrektheit von 0,72, während die planbasierte und die iterative Methode 0,46 beziehungsweise 0,21 erreichen. Ein Vorteil autonomerer Verfahren bei Aufgaben mit mehreren voneinander abhängigen Verarbeitungsschritten konnte im gewählten Versuchsaufbau somit nicht nachgewiesen werden.

Auch die Wahl des Modells beeinflusst die Ergebnisse. gpt-5.4-mini erzielte insgesamt die höchsten Korrektheits- und Effizienzwerte und wies keine erfassten Fehler auf. Gleichzeitig zeigte der Vergleich der beiden Qwen-Modelle, dass eine größere Modellgröße nicht automatisch mit besseren Ergebnissen verbunden ist. qwen3:8b erreichte höhere Korrektheits- und Effizienzwerte sowie eine niedrigere Fehlerrate als qwen3:30b. Die kombinierte Betrachtung von Modell und Methode zeigt zudem, dass die Rangfolge der Methoden nicht vollständig unabhängig vom gewählten Modell ist. Bei qwen3:8b lagen die deterministische und die planbasierte Methode hinsichtlich der Korrektheit nahezu gleichauf, während bei qwen3:30b ein deutlich größerer Unterschied zwischen diesen Methoden auftrat.

Die Forschungsfrage lässt sich damit dahingehend beantworten, dass ein höherer Autonomiegrad in der untersuchten Konfiguration mit einer geringeren Korrektheit und Effizienz sowie einem höheren Ressourcenbedarf und einer höheren Fehlerrate verbunden war. Gleichzeitig hängt die Stärke dieses Zusammenhangs vom Aufgabentyp und vom verwendeten Modell ab. Die Ergebnisse sprechen daher nicht für eine grundsätzlich optimale Orchestrierungsstrategie, sondern für eine aufgaben- und kontextabhängige Wahl des Autonomiegrads. Die aufgestellte Hypothese wird damit teilweise bestätigt. Die erwartete Zunahme des Ressourcenbedarfs und der Fehleranfälligkeit bei höherem Autonomiegrad zeigt sich deutlich in den Ergebnissen.

Für den praktischen Einsatz in Energiegemeinschaften bedeutet dies, dass deterministische Orchestrierung insbesondere bei klar definierten und wiederkehrenden Verarbeitungsschritten vorteilhaft sein kann. Wenn der konkrete Ablauf dagegen nicht vollständig im Voraus festgelegt werden kann, kann ein höherer Autonomiegrad grundsätzlich sinnvoll sein. Die Ergebnisse zeigen jedoch, dass der zusätzliche Entscheidungsspielraum mit höheren Anforderungen an die korrekte Ablaufsteuerung sowie mit zusätzlichen Ressourcen- und Fehlerkosten verbunden sein kann.

Zusammenfassend zeigt die Arbeit, dass die Wahl des Orchestrierungsansatzes eine relevante Einflussgröße für die Qualität und den Ressourcenbedarf LLM-basierter Tool-Nutzung darstellt. Mehr Autonomie bedeutet nicht lediglich mehr Entscheidungsmöglichkeiten, sondern auch zusätzliche Anforderungen an das verwendete Modell und die Orchestrierung. Die Ergebnisse sprechen daher für einen aufgaben- und modellabhängigen Einsatz von Autonomie, bei dem nicht die maximale Autonomie, sondern ein angemessenes Verhältnis zwischen Entscheidungsspielraum, Zuverlässigkeit und Ressourcenbedarf angestrebt wird.