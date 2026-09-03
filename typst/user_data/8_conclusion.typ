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

Ziel dieser Arbeit war es, zu untersuchen, wie sich der Grad der Autonomie bei der Tool-Orchestrierung von Large Language Models auf die Genauigkeit und den Ressourcenbedarf bei der Analyse von Zeitreihendaten in Energiegemeinschaften auswirkt. Hierzu wurden eine deterministische, eine planbasierte und eine iterative Orchestrierungsmethode anhand von 90 Aufgaben und drei unterschiedlichen Aufgabentypen evaluiert. Insgesamt wurden 810 Ausführungen mit drei verschiedenen Large Language Models durchgeführt und hinsichtlich Korrektheit, Effizienz, Laufzeit, Tokenverbrauch und Fehlerrate bewertet.

Die Ergebnisse zeigen einen deutlichen Zusammenhang zwischen dem Autonomiegrad und der Ausführungsqualität. Die deterministische Methode erzielte mit einer Korrektheit von 0,72 und einer Effizienz von 0,65 die besten Gesamtwerte. Die planbasierte Methode erreichte 0,59 beziehungsweise 0,49, während die iterative Methode mit 0,44 und 0,38 deutlich darunter lag. Gleichzeitig nahm der Ressourcenbedarf mit zunehmendem Autonomiegrad zu. Die durchschnittliche Laufzeit stieg von 7,67 s bei der deterministischen über 8,84 s bei der planbasierten auf 13,16 s bei der iterativen Methode. Der durchschnittliche Tokenverbrauch erhöhte sich von 4019 auf 5331 beziehungsweise 8273 Tokens. Auch die Fehlerrate nahm von 0,15 über 0,29 auf 0,31 zu.

Damit zeigt die Untersuchung, dass ein größerer Entscheidungsspielraum bei der Tool-Orchestrierung in der untersuchten Konfiguration mit messbaren Kosten verbunden ist. Die höhere Autonomie ermöglicht grundsätzlich, dass das LLM stärker über den weiteren Ablauf der Verarbeitung entscheidet. Gleichzeitig muss es dadurch zusätzliche Aufgaben wie die Auswahl weiterer Verarbeitungsschritte, die Verarbeitung des bisherigen Zustands und die Entscheidung über die Terminierung zuverlässig bewältigen. Insbesondere bei der iterativen Methode zeigten sich hierbei wiederholt Probleme, beispielsweise durch redundante Toolaufrufe, fehlerhafte Ergebnisreferenzen oder nicht korrekt aufgelöste Iterationen.

Die Forschungsfrage lässt sich somit dahingehend beantworten, dass ein zunehmender Autonomiegrad in der untersuchten Konfiguration mit einer geringeren Korrektheit und Effizienz sowie einem höheren Ressourcenbedarf und einer höheren Fehlerrate verbunden war. Die Ergebnisse verdeutlichen damit den Trade-off zwischen zusätzlichem Entscheidungsspielraum und der Zuverlässigkeit beziehungsweise dem Ressourcenbedarf der Orchestrierung. Die zusätzliche Flexibilität wurde dabei nicht als eigene Metrik erfasst. Entsprechend lässt sich nicht quantitativ bestimmen, ab welchem Grad an benötigter Ablaufvariabilität die beobachteten Einbußen gerechtfertigt sind. Es lässt sich jedoch feststellen, dass der größere Entscheidungsspielraum mit konkreten Kosten verbunden ist, die bei der Wahl eines Orchestrierungsansatzes berücksichtigt werden müssen.

Die Ergebnisse zur Aufgabenkomplexität zeigen darüber hinaus, dass komplexere Aufgaben höhere Anforderungen an die Orchestrierung stellen. Während direkte Datenabfragen eine Korrektheit von 0,75 erreichten, lagen Einzelquellenverarbeitung und Mehrquellenverarbeitung bei 0,53 beziehungsweise 0,46. Gleichzeitig stieg die Fehlerrate von 0,11 auf 0,24 beziehungsweise 0,40.

Neben dem Autonomiegrad zeigte auch die Wahl des Modells einen deutlichen Einfluss auf die Ergebnisse. gpt-5.4-mini erzielte insgesamt die höchsten Korrektheits- und Effizienzwerte und blieb als einziges der untersuchten Modelle ohne erfassten Fehler. Die Ergebnisse erlauben jedoch keine allgemeine Aussage, dass größere Modelle grundsätzlich besser für die Tool-Orchestrierung geeignet sind. Zudem zeigte sich, dass die Modelle bereitgestellte Kontextinformationen unterschiedlich zuverlässig verarbeiteten. Insbesondere beim Umgang mit der vorgegebenen Referenzzeit kam es beim API-basierten Modell teilweise dazu, dass anstelle der Referenzzeit der tatsächliche aktuelle Zeitpunkt verwendet wurde. Die daraus resultierenden falschen Zeiträume führten zu fehlerhaften Toolargumenten und beeinflussten damit auch die Bewertung des Modellvergleichs.

Die aufgestellte Hypothese wird damit teilweise bestätigt. Die erwartete Zunahme des Ressourcenbedarfs und der Fehleranfälligkeit bei höherem Autonomiegrad zeigt sich in den Ergebnissen deutlich. Ein Vorteil autonomerer Verfahren bei komplexeren Aufgaben konnte dagegen im Rahmen des gewählten Versuchsaufbaus nicht nachgewiesen werden. Daraus folgt jedoch nicht, dass höhere Autonomie grundsätzlich keinen Nutzen besitzt. Vielmehr hängt ihre Zweckmäßigkeit davon ab, ob ein größerer Entscheidungsspielraum für die jeweilige Aufgabe tatsächlich erforderlich ist.

Für den praktischen Einsatz in Energiegemeinschaften bedeutet dies, dass ein deterministischer Ansatz insbesondere bei klar definierten und wiederkehrenden Verarbeitungsschritten vorteilhaft sein kann. Wenn der konkrete Ablauf dagegen nicht vollständig im Voraus festgelegt werden kann, kann ein höherer Autonomiegrad grundsätzlich sinnvoll sein. Die dabei entstehenden Einbußen bei Zuverlässigkeit und Ressourcenbedarf sollten jedoch bewusst gegen die Anforderungen des jeweiligen Anwendungsszenarios abgewogen werden.

Zusammenfassend zeigt die Arbeit, dass die Wahl des Orchestrierungsansatzes eine relevante Einflussgröße für die Qualität und den Ressourcenbedarf LLM-basierter Tool-Nutzung darstellt. Mehr Autonomie bedeutet nicht lediglich mehr Entscheidungsmöglichkeiten, sondern auch zusätzliche Anforderungen an das Modell. Die Ergebnisse sprechen daher für eine aufgabenabhängige Wahl des Autonomiegrads, bei der nicht die maximale Autonomie, sondern ein angemessenes Verhältnis zwischen Entscheidungsspielraum, Zuverlässigkeit und Ressourcenbedarf angestrebt wird.