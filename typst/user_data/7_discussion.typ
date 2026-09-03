#import "../globals.typ": *

#context if text.lang == "de" [
    = Diskussion
    <sec:discussion>
] else [
    = Discussion
    <sec:discussion>
]

// 3-4 Seiten

Die Ergebnisse zeigen deutliche Unterschiede zwischen den untersuchten Orchestrierungsmethoden. Mit zunehmendem Autonomiegrad nahm die Korrektheit und Effizienz in der untersuchten Konfiguration ab, während Ressourcenbedarf und Fehlerrate zunahmen. Die deterministische Methode erreichte mit einer Korrektheit von 0,72 und einer Effizienz von 0,65 die höchsten Werte. Die planbasierte Methode lag mit 0,59 beziehungsweise 0,49 im Mittelfeld, während die iterative Methode mit 0,44 beziehungsweise 0,38 die niedrigsten Werte erreichte. Gleichzeitig stiegen die durchschnittliche Laufzeit von 7,67 s über 8,84 s auf 13,16 s und der Tokenverbrauch von 4019 über 5331 auf 8273 Tokens. Auch die Fehlerrate nahm von 0,15 bei der deterministischen Methode auf 0,29 bei der planbasierten und 0,31 bei der iterativen Methode zu.

Die Ergebnisse lassen sich als Trade-off zwischen dem Entscheidungsspielraum der Orchestrierung und deren Ausführungsqualität interpretieren. Die höhere Autonomie der planbasierten und insbesondere der iterativen Methode ermöglicht grundsätzlich, dass das LLM stärker über den weiteren Ablauf der Tool-Nutzung entscheidet. Bei der iterativen Methode muss es beispielsweise selbst bestimmen, welche Aktion als Nächstes ausgeführt wird, welche bereits verfügbaren Ergebnisse berücksichtigt werden und wann die Verarbeitung abgeschlossen werden kann. Mit diesem zusätzlichen Entscheidungsspielraum entstehen zugleich weitere Anforderungen an die korrekte Zustandsverarbeitung und Ablaufsteuerung. In der untersuchten Konfiguration waren diese zusätzlichen Freiheitsgrade mit deutlichen Einbußen bei Korrektheit und Effizienz sowie einem höheren Ressourcenbedarf verbunden.

Damit zeigt sich, dass ein höherer Autonomiegrad nicht ohne zusätzliche Kosten erreicht wird. Die Forschungsfrage lässt sich dahingehend beantworten, dass die Übertragung zusätzlicher Entscheidungen an das LLM in der untersuchten Konfiguration mit einer geringeren Ausführungsqualität und einem höheren Ressourcenbedarf einherging. Die Frage, ob diese Einbußen für einen konkreten Anwendungsfall akzeptabel sind, hängt davon ab, in welchem Umfang ein variabler und nicht vollständig vorab definierbarer Ausführungsablauf tatsächlich benötigt wird.

// == Einfluss der Aufgabenkomplexität

// Auch der Aufgabentyp beeinflusste die erzielte Ausführungsqualität deutlich. Bei direkten Datenabfragen wurde eine Korrektheit von 0,75 und eine Effizienz von 0,72 erreicht. Bei der Einzelquellenverarbeitung sanken diese Werte auf 0,53 beziehungsweise 0,44 und bei der Mehrquellenverarbeitung auf 0,46 beziehungsweise 0,36. Gleichzeitig stieg die Fehlerrate von 0,11 über 0,24 auf 0,40. Aufgaben mit mehreren Verarbeitungsschritten oder Abhängigkeiten zwischen verschiedenen Datenquellen stellen somit höhere Anforderungen an die korrekte Tool-Orchestrierung.

// Die aggregierten Ergebnisse erlauben allerdings keine Aussage darüber, ob ein höherer Autonomiegrad gerade bei komplexeren Aufgaben einen Vorteil bietet. Da die Werte über alle drei Methoden zusammengefasst wurden, müsste hierfür die Kombination aus Aufgabentyp und Orchestrierungsmethode gesondert betrachtet werden. Die vorliegenden Ergebnisse zeigen daher vor allem, dass mit steigender Aufgabenkomplexität die Anforderungen an die Orchestrierung zunehmen.

// Auffällig ist zudem, dass Laufzeit und Tokenverbrauch nicht monoton mit der Aufgabenkomplexität zunahmen. Die Einzelquellenverarbeitung wies mit 11,15 s die höchste durchschnittliche Laufzeit auf, während die Mehrquellenverarbeitung mit 9,82 s darunter lag. Beim Tokenverbrauch erreichten direkte Datenabfragen mit 6102 Tokens sogar den höchsten Wert. Ressourcenverbrauch und Aufgabenkomplexität sind daher nicht unmittelbar gleichzusetzen.

== Anforderungen autonomer Orchestrierung

Die Ergebnisse der iterativen Methode verdeutlichen, welche zusätzlichen Anforderungen mit einem größeren Entscheidungsspielraum verbunden sind. In den Durchläufen traten unter anderem wiederholte Toolaufrufe mit bereits verwendeten Argumenten, nicht korrekt aufgelöste Iterationen, fehlerhafte Ergebnisreferenzen und Probleme bei der vorgesehenen Reihenfolge von Aktionen auf. Die Bereitstellung bereits vorhandener Ergebnisse über `available_results` verhinderte redundante Toolaufrufe dabei nicht zuverlässig.

Diese Beobachtungen zeigen, dass iterative Orchestrierung neben der eigentlichen Tool-Nutzung eine konsistente Verarbeitung des bisherigen Ausführungszustands erfordert. Das LLM muss nicht nur das passende Werkzeug bestimmen, sondern auch erkennen, welche Schritte bereits abgeschlossen sind, welche Ergebnisse verfügbar sind und wann keine weitere Aktion erforderlich ist. Der zusätzliche Entscheidungsspielraum erhöht damit gleichzeitig die Zahl der möglichen Fehlentscheidungen.

Dies erklärt zumindest teilweise, weshalb die iterative Methode trotz ihres größeren Entscheidungsspielraums in den untersuchten Aufgaben schlechtere Korrektheits- und Effizienzergebnisse erzielte. Daraus folgt jedoch nicht, dass iterative Orchestrierung grundsätzlich ungeeignet ist. Vielmehr hängt ihr möglicher Nutzen davon ab, ob die zusätzliche Ablaufvariabilität in einer Aufgabe tatsächlich benötigt wird. Wenn die Verarbeitungsschritte bereits eindeutig festgelegt werden können, entstehen durch zusätzliche Autonomie in erster Linie weitere Entscheidungsmöglichkeiten, die fehlerhaft genutzt werden können.

== Einfluss der Modelle

Neben den Orchestrierungsmethoden zeigten auch die verwendeten Modelle deutliche Unterschiede. gpt-5.4-mini erreichte mit 0,73 die höchste Korrektheit und mit 0,57 eine höhere Effizienz als qwen3:30b mit 0,46 beziehungsweise 0,44. qwen3:8b erreichte eine Korrektheit von 0,56 und eine Effizienz von 0,51. Bei der Fehlerrate zeigten sich ebenfalls deutliche Unterschiede: gpt-5.4-mini wies keine Fehler auf, qwen3:30b eine Fehlerrate von 0,50 und qwen3:8b von 0,25.

Aus diesen Ergebnissen lässt sich jedoch keine allgemeine Aussage ableiten, dass größere Modelle grundsätzlich besser für Tool-Orchestrierung geeignet sind. Insbesondere qwen3:8b erzielte eine höhere Korrektheit als qwen3:30b. Die Unterschiede können daher nicht allein über die Modellgröße erklärt werden.

Auch die Kombination von Modell und Methode beeinflusste die Ergebnisse. Bei allen drei Modellen erreichte die iterative Methode die niedrigste Korrektheit und Effizienz. Die Unterschiede zwischen deterministischer und planbasierter Methode waren dagegen modellabhängig. Bei gpt-5.4-mini lag die deterministische Methode mit einer Korrektheit von 0,83 vor der planbasierten Methode mit 0,79. Bei qwen3:30b war der Unterschied mit 0,67 gegenüber 0,30 deutlich größer, während bei qwen3:8b beide Methoden mit 0,66 beziehungsweise 0,67 nahezu gleichauf lagen. Dies zeigt, dass die Auswirkungen des Autonomiegrads auch vom verwendeten Modell abhängen.

Ein weiterer Einflussfaktor zeigte sich beim Umgang mit der vorgegebenen Referenzzeit. Das lokale Modell berücksichtigte diese zuverlässig, während das API-basierte Modell in mehreren Fällen stattdessen vom tatsächlichen aktuellen Zeitpunkt ausging. Dadurch entstanden teilweise fehlerhafte Zeiträume in den Toolargumenten und infolgedessen falsche Toolaufrufe. Der Modellvergleich kann daher nicht ausschließlich als Unterschied in der allgemeinen Tool-Orchestrierungsfähigkeit interpretiert werden. Der unterschiedliche Umgang mit bereitgestellten Kontextinformationen hat die Ergebnisse ebenfalls beeinflusst. Da für alle Modelle dieselben Systeminformationen und Aufgaben verwendet wurden, wurde dieser Einfluss nicht durch modellspezifische Anpassungen ausgeglichen.

== Ressourcenbedarf und Fehleranfälligkeit

Der höhere Ressourcenbedarf autonomerer Methoden zeigt sich insbesondere beim Tokenverbrauch. Die iterative Methode benötigte mit durchschnittlich 8273 Tokens mehr als doppelt so viele Tokens wie die deterministische Methode mit 4019 Tokens. Dies lässt sich durch die wiederholten LLM-Aufrufe und die Verarbeitung des bisherigen Ausführungskontexts erklären. Die planbasierte Methode nahm mit 5331 Tokens eine Zwischenposition ein.

Der Tokenverbrauch ist dabei nicht als eigenständiges Qualitätsmaß zu verstehen. Ein niedriger Verbrauch kann beispielsweise auch durch einen vorzeitig beendeten oder fehlerhaften Ablauf entstehen. Die Ressourcennutzung sollte deshalb gemeinsam mit Korrektheit, Effizienz und Fehlerrate betrachtet werden. Gleiches gilt für die Laufzeit, die in dieser Arbeit ausschließlich die LLM-Aufrufe umfasst und bei fehlerhaften beziehungsweise nicht messbaren Ausführungen nicht in den Mittelwert einging.

Die Fehlerrate bestätigt den Zusammenhang zwischen Autonomiegrad und Robustheit. Sie lag bei der deterministischen Methode bei 0,15, bei der planbasierten Methode bei 0,29 und bei der iterativen Methode bei 0,31. Der überwiegende Teil der Fehler bestand aus Timeouts. Zusätzlich trat über alle 810 Ausführungen nur ein struktureller Fehler auf. Die Ergebnisse zeigen damit eine höhere Fehleranfälligkeit der autonomeren Methoden, erlauben jedoch keine eindeutige Aussage darüber, dass die höhere Anzahl an Iterationen unmittelbar die Ursache der Timeouts war.

== Bedeutung für Energiegemeinschaften und Limitationen

Für den Einsatz von LLM-basierten Orchestrierungssystemen in Energiegemeinschaften sprechen die Ergebnisse insbesondere dann für einen deterministischeren Ansatz, wenn die erforderlichen Verarbeitungsschritte bereits eindeutig spezifiziert werden können. Bei variableren Aufgaben kann ein größerer Entscheidungsspielraum dagegen grundsätzlich relevant sein, da nicht sämtliche möglichen Abläufe vorab festgelegt werden müssen. Die Ergebnisse zeigen jedoch, dass dieser zusätzliche Entscheidungsspielraum mit höheren Anforderungen an das LLM und mit messbaren Kosten bei Korrektheit, Effizienz und Ressourcenbedarf verbunden sein kann.

Die Aussagekraft der Ergebnisse ist dabei durch mehrere Einschränkungen begrenzt. Untersucht wurden 90 Aufgaben, drei Aufgabentypen, drei Modelle und drei Orchestrierungsmethoden. Die Ergebnisse sind daher insbesondere als Evaluation der konkreten Kombination aus Aufgaben, Modellen, Prompts, Tools und Implementierungen zu verstehen. Zudem wurden unterschiedliche technische Ausführungsbedingungen für die Modelle verwendet, weshalb insbesondere absolute Laufzeiten zwischen den Modellen nur eingeschränkt vergleichbar sind. Aussagekräftiger ist der Vergleich der Methoden innerhalb eines Modells und unter den lokalen Modellen.

Eine weitere Einschränkung besteht darin, dass die zusätzliche Flexibilität durch den höheren Autonomiegrad nicht direkt gemessen wurde. Die Untersuchung quantifiziert die damit verbundenen Einbußen und Ressourcenanforderungen, nicht jedoch den konkreten Nutzen des größeren Entscheidungsspielraums.

Insgesamt zeigen die Ergebnisse somit keinen grundsätzlichen Widerspruch zwischen höherer Autonomie und sinnvoller Tool-Orchestrierung. Sie verdeutlichen vielmehr die damit verbundene Abwägung: Ein größerer Entscheidungsspielraum kann die Ablaufsteuerung flexibler gestalten, erhöht in der untersuchten Konfiguration jedoch zugleich die Anforderungen an die korrekte Entscheidungsfindung und verursacht höhere Ressourcen- und Fehlerkosten. Für die Wahl eines geeigneten Orchestrierungsansatzes ist daher nicht allein der erreichbare Autonomiegrad entscheidend, sondern dessen Verhältnis zu den konkreten Anforderungen der jeweiligen Aufgabe.