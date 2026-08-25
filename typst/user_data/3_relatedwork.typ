#import "../globals.typ": *

#context if text.lang == "de" [
    = Stand der Forschung
    <sec:relatedwork>
] else [
    = Related Work
    <sec:relatedwork>
]

// 7-10 Seiten

== Datenzugriff

=== Text to SQL
Eine Möglichkeit, Datenbanken über natürliche Sprache zugänglich zu machen, ist Text-to-SQL. Dabei wird eine natürlichsprachliche Anfrage in eine ausführbare SQL-Abfrage übersetzt @singhComprehensiveReviewLLMbased2026.

Die Generierung einer geeigneten SQL-Abfrage erfordert neben der Interpretation der natürlichsprachlichen Anfrage auch ein Verständnis des zugrunde liegenden Datenbankschemas. Moderne Text-to-SQL-Systeme beziehen daher Schemainformationen ein und verwenden unter anderem Verfahren zum Schema Linking, um relevante Tabellen und weitere Datenbankelemente für die Abfragegenerierung zu bestimmen @singhComprehensiveReviewLLMbased2026.

Mit zunehmender Komplexität der Datenbank entstehen dabei zusätzliche Herausforderungen. Komplexe Schemata, Beziehungen zwischen Tabellen, mehrdeutige Anfragen sowie die korrekte Generierung komplexer SQL-Konstruktionen können die Zuverlässigkeit der erzeugten Abfragen beeinträchtigen. Entsprechend sind Schemaverständnis, robuste SQL-Generierung und die Behandlung komplexer Anfragen weiterhin zentrale Herausforderungen der Text-to-SQL-Forschung @hongNextGenerationDatabaseInterfaces2025.

=== Function Calling
Eine alternative Möglichkeit besteht darin, Datenbankoperationen über vordefinierte Funktionen bereitzustellen. Dabei wird die für eine Operation benötigte Abfragelogik innerhalb einer Funktion gekapselt, während das Sprachmodell lediglich aus den verfügbaren Funktionen auswählt und deren definierte Parameter bestimmt. De Costa et al. verwenden einen solchen Ansatz, bei dem zweckgebundene Funktionen vorab definierte und validierte SQL-Abfragen kapseln. Dadurch wird die Generierung der eigentlichen SQL-Logik aus dem direkten Einflussbereich des Sprachmodells genommen und die zulässige Interaktion mit der Datenbank auf die bereitgestellten Operationen beschränkt @costaEnhancingAccuracyMaintainability2025.

Der Ansatz bietet insbesondere dort Vorteile, wo die Kontrollierbarkeit und Nachvollziehbarkeit der Datenabfragen relevant sind. De Costa et al. berichten in ihrem konkreten Anwendungskontext zudem eine höhere durch Experten bewertete Korrektheit sowie Vorteile hinsichtlich der Wartbarkeit gegenüber einem direkten NL-to-SQL-Ansatz. Gleichzeitig entsteht durch die Entwicklung und Pflege der Funktionsbibliothek ein zusätzlicher Aufwand @costaEnhancingAccuracyMaintainability2025.

== Zeitreihendaten

Energiedaten liegen häufig in Form von Zeitreihen vor. Eine direkte Übergabe längerer Zeitreihen an ein LLM kann problematisch sein. Bei der numerischen Repräsentation entstehen einerseits hohe Tokenkosten, andererseits können relevante zeitliche, dimensionale oder frequenzbezogene Merkmale nur schwer aus der Folge numerischer Werte extrahiert werden. Liu et al. zeigen beispielsweise, dass ein einzelnes Zeitreihenbeispiel im untersuchten RCW-Datensatz bei GPT-4o bis zu 60.000 Input-Tokens benötigen kann. Die Autoren identifizieren die direkte numerische Modellierung daher als eine wesentliche Ursache für die beobachteten Schwierigkeiten von LLMs beim Reasoning über Zeitreihen @liuPictureWorthThousand.

Eine Möglichkeit besteht darin, Zeitreihen zunächst durch spezialisierte Verfahren zu analysieren und dem LLM lediglich relevante Merkmale oder Ergebnisse bereitzustellen. Dies kann beispielsweise die Berechnung statistischer Kennwerte umfassen. Für komplexere Fragestellungen sind jedoch spezifische Verfahren zur Merkmalsextraktion oder Mustererkennung erforderlich, wodurch die Lösung stärker auf die jeweils vorgesehenen Fragestellungen zugeschnitten werden muss @liuPictureWorthThousand.

Einen alternativen Ansatz untersuchen Liu et al. mit VL-Time. Anstatt die Zeitreihen direkt als numerische Daten an das LLM zu übergeben, werden diese visualisiert und anschließend von einem multimodalen LLM verarbeitet. Die Methode umfasst zunächst eine Planungsphase, in der unter anderem eine geeignete Visualisierung im Zeit- oder Frequenzbereich sowie relevante Merkmale bestimmt werden. In der anschließenden Lösungsphase wird die visualisierte Zeitreihe zusammen mit sprachlichen Hinweisen verarbeitet @liuPictureWorthThousand.

Die Visualisierung dient dabei nicht nur der Darstellung, sondern gleichzeitig als Kompromiss zwischen Informationsgehalt und Kontextgröße. Im untersuchten RCW-Beispiel reduziert sich die Repräsentation eines Zeitreihenbeispiels von bis zu 60.000 Tokens bei numerischer Modellierung auf 85 Tokens bei visueller Modellierung. Zusätzlich untersuchen Liu et al. Few-Shot In-Context Learning, bei dem Beispiele zur jeweiligen Aufgabe in den Kontext aufgenommen werden. Im Vergleich zur numerischen Modellierung erzielt VL-Time dabei eine durchschnittliche relative Leistungssteigerung von 140 % und reduziert die durchschnittlichen Tokenkosten um 99 % @liuPictureWorthThousand.

== Toolnutzung

Large Language Models können durch die Anbindung externer Werkzeuge auf Informationen und Funktionen zugreifen, die nicht allein durch das im Modell gespeicherte Wissen bereitgestellt werden können. Frühe Arbeiten untersuchten dabei zunächst die grundlegende Fähigkeit, geeignete Werkzeuge auszuwählen und korrekte API-Aufrufe zu erzeugen. Xu et al. ordnen unter anderem Toolformer und ReAct dieser frühen Entwicklung zu, in der insbesondere die Auswahl eines Werkzeugs und die korrekte Formatierung eines API-Aufrufs im Vordergrund stehen @xuEvolutionToolUse2026.

=== Tool Calling und Toolauswahl

// Toolformer
Ein früher Ansatz zur systematischen Nutzung externer Werkzeuge durch Sprachmodelle ist Toolformer. Dabei wird untersucht, wie ein Sprachmodell selbstständig lernen kann, externe Werkzeuge über APIs einzusetzen. Das Modell soll dabei nicht nur geeignete Werkzeuge auswählen, sondern auch entscheiden, wann ein API-Aufruf sinnvoll ist und welche Argumente dafür erzeugt werden müssen. Dazu werden zunächst potenzielle API-Aufrufe in Texte eingefügt, ausgeführt und anschließend anhand ihres Beitrags zur Vorhersage zukünftiger Tokens gefiltert. Die verbleibenden Beispiele werden für die Feinabstimmung des Modells verwendet. Toolformer zeigt damit, dass Toolnutzung nicht zwingend durch eine explizite Vorgabe des verwendeten Werkzeugs erfolgen muss. Das Modell kann vielmehr lernen, selbst zu entscheiden, ob und wann externe Informationen benötigt werden. In den Experimenten führte dies unter anderem bei wissensintensiven Aufgaben zu deutlichen Verbesserungen gegenüber vergleichbaren Modellen ohne Toolnutzung @schickToolformerLanguageModels2023.

// MetaTool
Die Frage der Toolauswahl wird auch unabhängig von der konkreten Ausführung eines Tool Calls untersucht. Huang et al. führen mit MetaTool einen Benchmark ein, der bewertet, ob ein Sprachmodell erkennt, wann ein externes Werkzeug benötigt wird und welches Werkzeug für eine Anfrage geeignet ist. Dabei werden sowohl einzelne Werkzeuge als auch Szenarien mit mehreren Werkzeugen betrachtet. Die Ergebnisse zeigen, dass selbst leistungsfähige Sprachmodelle weiterhin Schwierigkeiten bei der zuverlässigen Toolauswahl aufweisen @huangMetaToolBenchmarkLarge2024.

Damit verschiebt sich der Fokus von der reinen Fähigkeit, einen einzelnen API-Aufruf korrekt zu erzeugen, zunehmend auf die Frage, welches Werkzeug für eine konkrete Aufgabe geeignet ist. Das Xu-Survey beschreibt diese Entwicklung als Übergang von einer einfachen Toolauswahl hin zu komplexeren Entscheidungen über mehrere voneinander abhängige Werkzeuge @xuEvolutionToolUse2026.

=== Tool Learning und Training

// GPT4Tools - Grundlagen
Neben Ansätzen, die Toolnutzung während der Ausführung ermöglichen, wurde untersucht, Toolnutzung gezielt in den Parametern eines Sprachmodells zu verankern. Ein Beispiel hierfür ist GPT4Tools. Der Ansatz verfolgt das Ziel, kleinere Open-Source-Modelle mithilfe von Trainingsdaten eines leistungsfähigeren Sprachmodells zur Nutzung von Werkzeugen zu befähigen. Hierzu erzeugt GPT-3.5 anhand von Toolbeschreibungen und visuellen Kontexten zunächst ein instruktionales Trainingsdatenset. Die daraus erzeugten Beispiele werden anschließend verwendet, um Modelle wie OPT-13B, LLaMA-13B und Vicuna-13B mittels LoRA anzupassen @yangGPT4ToolsTeachingLarge2023.

// GPT4Tools - Evaluation
Die erzeugten Trainingsbeispiele enthalten unter anderem die Entscheidung, ob ein Werkzeug benötigt wird, den Namen des aufzurufenden Werkzeugs und die entsprechenden Argumente. GPT4Tools evaluiert diese Fähigkeiten getrennt über die Successful Rate of Thought (SRt), die Successful Rate of Action (SRact) und die Successful Rate of Arguments (SRargs). Die zusammengefasste Successful Rate berücksichtigt dabei nur Aufrufe, bei denen alle drei Komponenten korrekt sind. Die Ergebnisse zeigen deutliche Verbesserungen durch das Fine-Tuning. Beispielsweise steigt die Successful Rate von OPT-13B von 0 % auf 93,2 % und die von Vicuna-13B von 12,4 % auf 94,1 %. Auch bei Werkzeugen, die nicht im Training enthalten waren, erreichen die angepassten Modelle deutlich bessere Ergebnisse. Vicuna-13B erzielt auf diesen unbekannten Werkzeugen beispielsweise eine Successful Rate von 90,6 % @yangGPT4ToolsTeachingLarge2023.

// GPT4Tools - Schlussfolgerung
GPT4Tools zeigt damit, dass Toolnutzung nicht ausschließlich durch Laufzeit-Prompting oder eine externe Steuerung realisiert werden muss, sondern auch als erlernte Fähigkeit eines Sprachmodells betrachtet werden kann. Gleichzeitig unterscheidet sich dieser Ansatz von Toolformer dadurch, dass GPT4Tools gezielt kleinere Open-Source-Modelle mittels selbstgenerierter Instruktionsdaten anpasst und insbesondere auch multimodale Werkzeuge berücksichtigt @yangGPT4ToolsTeachingLarge2023. Das Xu-Survey ordnet GPT4Tools entsprechend als frühen Ansatz des Supervised Fine-Tunings für Toolnutzung ein. Während frühe Fine-Tuning-Verfahren insbesondere die syntaktische Korrektheit von Toolaufrufen sowie die Zuordnung von Anfragen zu APIs verbessern, verschiebt sich der Fokus neuerer Verfahren zunehmend auf große Toolmengen und die Planung von Abhängigkeiten zwischen Werkzeugen @xuEvolutionToolUse2026.

=== Mehrstufige Toolnutzung

// Grenzen bei mehrstufiger Toolnutzung
Mit der Nutzung mehrerer Werkzeuge entsteht eine zusätzliche Herausforderung: Ein Werkzeugaufruf kann von den Ergebnissen eines vorherigen Aufrufs abhängen. Damit reicht es nicht mehr aus, einzelne Tool Calls unabhängig voneinander korrekt zu erzeugen. Stattdessen müssen Informationen aus vorherigen Aufrufen aufgenommen und für nachfolgende Aktionen verwendet werden.

Diese Grenze zeigt sich bereits bei Toolformer. Das Verfahren beschränkt sich bei der Erzeugung und Nutzung von API-Aufrufen auf einzelne Aufrufe pro Beispiel. Dadurch kann es keine verketteten Toolaufrufe erlernen, bei denen beispielsweise die Ausgabe eines Werkzeugs als Eingabe für ein weiteres Werkzeug dient. Auch eine interaktive Nutzung eines Werkzeugs, bei der beispielsweise eine Suchanfrage auf Grundlage zuvor erhaltener Ergebnisse angepasst wird, wird vom ursprünglichen Ansatz nicht unterstützt @schickToolformerLanguageModels2023.

ART greift diese Herausforderung auf und erweitert die Toolnutzung um eine explizite mehrstufige Struktur. Das Framework zerlegt Aufgaben in mehrere aufeinanderfolgende Schritte und kann die Generierung an einem Tool Call unterbrechen, dessen Ausgabe in den weiteren Ablauf integrieren und anschließend die Generierung fortsetzen. Dadurch können beispielsweise zunächst Informationen über eine Suche beschafft und anschließend mit einem Codewerkzeug verarbeitet werden @paranjapeARTAutomaticMultistep2023.

Damit wird eine Grenze zwischen der Nutzung einzelner Werkzeuge und der Koordination mehrerer Werkzeuge sichtbar. Während bei einzelnen Aufrufen vor allem Toolauswahl und korrekte Parametrisierung relevant sind, entstehen bei mehreren voneinander abhängigen Aufrufen zusätzliche Anforderungen wie die Modellierung von Abhängigkeiten, die Bestimmung der Ausführungsreihenfolge, Parallelisierung, Fehlerbehandlung und erneute Planung @xuEvolutionToolUse2026.

// Überleitung zur Orchestrierung
Damit liegt der Schwerpunkt der beschriebenen Ansätze zunächst auf der Fähigkeit des Sprachmodells, Werkzeuge zu verwenden: Es muss erkennen, wann ein Werkzeug benötigt wird, ein geeignetes Werkzeug auswählen und einen korrekten Aufruf mit passenden Argumenten erzeugen können. Bei mehreren aufeinander aufbauenden Werkzeugaufrufen reicht diese Fähigkeit jedoch nicht mehr aus. Es muss zusätzlich entschieden werden, welche Aktionen in welcher Reihenfolge ausgeführt werden, wie mit den Ergebnissen vorheriger Aktionen umgegangen wird und wann die Ausführung beendet oder angepasst werden sollte. Diese übergeordnete Steuerung wird im Folgenden als Tool-Orchestrierung betrachtet @xuEvolutionToolUse2026.

== Orchestrierung

Bei der Nutzung mehrerer Werkzeuge reicht es nicht aus, für jeden einzelnen Schritt ein geeignetes Werkzeug auszuwählen. Die einzelnen Werkzeugaufrufe können voneinander abhängig sein, sodass sowohl ihre Auswahl als auch ihre Ausführungsreihenfolge berücksichtigt werden müssen. Lu et al. modellieren die Ausführung komplexer Tool-Nutzung daher als gerichteten azyklischen Graphen (DAG), in dem Werkzeugaufrufe als Knoten und Abhängigkeiten zwischen ihnen als Kanten dargestellt werden. Eine solche Abhängigkeit entsteht beispielsweise, wenn ein Ausgabefeld eines Werkzeugs als Eingabe für ein nachfolgendes Werkzeug dient @luOrchDAGComplexTool2025.

Die Koordination mehrerer Werkzeugaufrufe kann damit als Orchestrierungsproblem betrachtet werden. Zhe et al. beschreiben Tool-Orchestrierung entsprechend nicht ausschließlich als schrittweise Auswahl einzelner Werkzeuge, sondern als ein Problem der strukturierten Ausführungssteuerung. Dabei müssen insbesondere Abhängigkeiten zwischen Werkzeugen berücksichtigt und die Ausführung so organisiert werden, dass Fehler einzelner Aufrufe nicht zwangsläufig die gesamte Ausführung beeinträchtigen @zheRobustEfficientTool2026.

=== Mehrstufige Tool-Ausführung

Eine Form der Orchestrierung besteht darin, eine Aufgabe in mehrere aufeinanderfolgende Schritte zu zerlegen und an geeigneten Stellen Werkzeuge einzusetzen. Paranjape et al. beschreiben mit Automatic Reasoning and Tool-use (ART) ein Framework, in dem solche mehrstufigen Abläufe als Programme dargestellt werden. Ein Programm besteht aus einer Eingabe, mehreren Sub-Aufgaben und einer abschließenden Antwort. Die Sub-Aufgaben können dabei Werkzeugaufrufe enthalten. Wird bei der Generierung ein Werkzeugaufruf erreicht, wird die Generierung unterbrochen, das Werkzeug ausgeführt und anschließend mit dessen Ergebnis fortgesetzt @paranjapeARTAutomaticMultistep2023.

Dadurch können die Ergebnisse vorheriger Schritte unmittelbar in nachfolgenden Schritten verwendet werden. In einem von ART dargestellten Beispiel wird zunächst eine Suchanfrage ausgeführt, deren Ergebnis anschließend als Grundlage für die Generierung von Code dient. Der generierte Code wird wiederum durch ein weiteres Werkzeug ausgeführt. Die einzelnen Schritte bilden damit eine zusammenhängende Ausführungskette, in der die Ergebnisse vorheriger Werkzeuge den weiteren Ablauf beeinflussen @paranjapeARTAutomaticMultistep2023.

Eine explizitere Darstellung solcher Abhängigkeiten verwenden Lu et al. im Rahmen von OrchDAG. Ein Werkzeugausführungsplan wird als DAG G=(V,E) dargestellt. Die Knoten repräsentieren dabei Werkzeugaufrufe, während die Kanten Abhängigkeiten zwischen den Aufrufen darstellen. Der Plan enthält für jeden Schritt unter anderem das verwendete Werkzeug, dessen Parameter und die Abhängigkeiten zu vorherigen Schritten. Dadurch kann beispielsweise festgelegt werden, dass ein bestimmtes Eingabefeld aus einem Ergebnis eines vorherigen Werkzeugaufrufs übernommen werden muss @luOrchDAGComplexTool2025.

Die Bedeutung solcher Abhängigkeiten zeigt sich insbesondere bei komplexeren Aufgaben. Lu et al. weisen darauf hin, dass in industriellen Anwendungen eine große Anzahl von Domänenwerkzeugen zur Verfügung stehen kann und die Komplexität unter anderem daraus entsteht, dass Werkzeugausgaben viele Felder enthalten und ein Ausgabefeld eines Werkzeugs als Eingabe eines anderen Werkzeugs dienen kann. Zusätzlich können sich Abhängigkeiten über mehrere Interaktionsrunden erstrecken @luOrchDAGComplexTool2025.

=== Planung und Ausführung

Für die Organisation solcher mehrstufigen Abläufe lassen sich unterschiedliche Vorgehensweisen unterscheiden. Zhe et al. ordnen bestehende Ansätze unter anderem zwei Paradigmen zu. Bei reaktiven Verfahren werden Entscheidungen schrittweise während der Ausführung getroffen. Demgegenüber erzeugen Plan-and-Execute-Verfahren zunächst einen globalen Plan, der anschließend ausgeführt wird. Nach Darstellung von Zhe et al. bieten reaktive Verfahren Flexibilität, verfügen jedoch nicht notwendigerweise über eine globale Sicht auf Abhängigkeiten. Vollständig vorab erzeugte Pläne können dagegen empfindlich gegenüber Abweichungen während der tatsächlichen Ausführung sein @zheRobustEfficientTool2026.

Das in @hernandezReActModularAgent2025 beschriebene System stellt ein Beispiel für eine stärker strukturierte, iterative Ausführung dar. Die Architektur trennt dabei drei Aufgabenbereiche: Ein Planner analysiert die Anfrage und erstellt eine Liste auszuführender Aktionen, ein Dispatcher übersetzt diese Aktionen in konkrete strukturierte Werkzeugaufrufe und ein Synthesizer erzeugt abschließend die Antwort. Die Werkzeugergebnisse werden anschließend wieder an den Planner zurückgegeben, der deren Relevanz und Vollständigkeit bewertet und gegebenenfalls weitere Aktionen plant @hernandezReActModularAgent2025.

Damit entsteht eine iterative Schleife aus Planung, Ausführung und anschließender Bewertung der Ergebnisse. Der Planner kann nach einem Werkzeugaufruf entscheiden, ob weitere Aktionen erforderlich sind, ob die vorhandenen Informationen für die Beantwortung ausreichen oder ob ein erneuter bzw. angepasster Aufruf notwendig ist. Das System unterstützt außerdem parallele Werkzeugaufrufe, wenn die geplanten Aktionen unabhängig voneinander ausgeführt werden können @hernandezReActModularAgent2025.

Auch Liu et al. modellieren Orchestrierung als einen iterativen Entscheidungsprozess. Zu jedem Zeitpunkt wird aus mehreren möglichen Aktionen eine Aktion ausgewählt. Zu den möglichen Aktionen gehören unter anderem das direkte Beantworten der Anfrage, Retrieval, Werkzeugnutzung, Verifikation und das Beenden der Ausführung. Die Auswahl erfolgt anhand einer Utility-Funktion, die den erwarteten Nutzen einer Aktion, ihre Kosten, die Unsicherheit und ihre Redundanz berücksichtigt @liuUtilityGuidedAgentOrchestration2026.

Dabei wird insbesondere auch die Entscheidung zum Beenden als Teil der Orchestrierung behandelt. Der Ausführungsprozess wird fortgesetzt, bis eine Stop-Aktion ausgewählt wird, ein vorher festgelegtes Schrittbudget erreicht ist oder eine weitere Abbruchbedingung greift. Liu et al. betrachten das Stoppen somit nicht lediglich als technische Randbedingung, sondern als eine eigene Entscheidung innerhalb des Orchestrierungsprozesses @liuUtilityGuidedAgentOrchestration2026.

=== Strukturierung der Werkzeugausführung

Neben der Frage, wann einzelne Werkzeuge aufgerufen werden, kann auch die Struktur der Ausführung vorgegeben oder eingeschränkt werden. Zhe et al. schlagen mit RETO eine Architektur vor, die eine grobe Ausführungsstruktur in Form von Layern verwendet. Werkzeuge werden dabei anhand ihrer vermuteten Abhängigkeiten verschiedenen Ausführungsschichten zugeordnet. Die Werkzeuge werden anschließend schichtweise ausgeführt, sodass das Modell innerhalb eines Schrittes nur auf eine relevante Teilmenge der verfügbaren Werkzeuge zugreifen muss @zheRobustEfficientTool2026.

Die Layer-Struktur stellt dabei keinen vollständig spezifizierten Ausführungsplan dar. Vielmehr soll sie eine grobe globale Struktur bereitstellen, während die konkrete Auswahl und Ausführung innerhalb einer Schicht weiterhin adaptiv erfolgt. RETO trennt damit die globale Organisation der Werkzeugabhängigkeiten von der lokalen Ausführung @zheRobustEfficientTool2026.

Eine andere Form der expliziten Strukturierung findet sich bei ART. Dort wird der Ablauf als strukturiertes Programm mit definierten Sub-Aufgaben und Werkzeugaufrufen dargestellt. Die Autoren argumentieren, dass diese strukturierte Darstellung mehrstufiges Reasoning unterstützt und gegenüber einer freien Generierung von Chain-of-Thought eine zusätzliche Struktur für die Ausführung bereitstellt @paranjapeARTAutomaticMultistep2023.

OrchDAG geht noch einen Schritt weiter und stellt die Werkzeugausführung explizit als Graph dar. Die Topologie des Graphen beschreibt dabei die Abhängigkeiten zwischen den Werkzeugaufrufen. Die Autoren kontrollieren die Komplexität ihrer generierten Aufgaben unter anderem über Eigenschaften der erzeugten DAGs. Dadurch kann die Komplexität mehrstufiger Tool-Nutzung systematisch variiert werden @luOrchDAGComplexTool2025.

=== Fehler und Anpassung während der Ausführung

Eine besondere Herausforderung entsteht, wenn die tatsächliche Werkzeugausführung von der ursprünglichen Planung abweicht. Lu et al. berücksichtigen in ihrem mehrstufigen Szenario beispielsweise Werkzeugfehler wie Timeouts. In einem solchen Fall kann die weitere Ausführung auf einem Teilgraphen des ursprünglichen Plans basieren. Darüber hinaus berücksichtigen sie Interaktionsrunden, in denen eine neue Anfrage sowohl neue Werkzeuge benötigt als auch von Ergebnissen vorheriger Ausführungen abhängt @luOrchDAGComplexTool2025.

Zhe et al. adressieren diese Problematik mit einer lokalen Fehlerkorrektur. RETO überwacht die Werkzeugausführung und versucht fehlerhafte oder inkonsistente Aufrufe innerhalb der bestehenden Layer-Struktur zu korrigieren, anstatt den gesamten Ausführungsplan neu zu erstellen. Dadurch sollen Fehler auf den betroffenen Werkzeugaufruf begrenzt und deren Ausbreitung auf nachfolgende Schritte reduziert werden @zheRobustEfficientTool2026.

Das von Hernández et al. beschriebene System verfolgt dagegen einen stärker planungsorientierten Ansatz. Der Planner überprüft die Ergebnisse ausgeführter Werkzeuge und kann bei unvollständigen Informationen weitere Aktionen erzeugen oder einen Aufruf erneut beziehungsweise angepasst durchführen. Die Architektur enthält somit ebenfalls eine Form der Anpassung während der Ausführung, wobei die weitere Planung durch die nach jedem Ausführungsschritt gewonnenen Beobachtungen beeinflusst wird @hernandezReActModularAgent2025.

Damit unterscheiden sich die Ansätze insbesondere darin, auf welcher Ebene die Struktur der Ausführung festgelegt wird und wie stark sie während der Ausführung verändert werden kann. Während RETO eine grobe globale Struktur vorgibt und lokale Korrekturen innerhalb dieser Struktur vornimmt, beschreibt @hernandezReActModularAgent2025 einen iterativen Planner, der nach der Ausführung von Werkzeugen weitere Aktionen auf Grundlage der erhaltenen Ergebnisse planen kann. ART wiederum stellt die mehrstufige Ausführung als strukturiertes Programm dar, dessen einzelne Schritte während der Generierung und Werkzeugausführung miteinander verbunden sind @zheRobustEfficientTool2026 @hernandezReActModularAgent2025 @paranjapeARTAutomaticMultistep2023.

=== Orchestrierung als Abwägung zwischen Qualität und Ausführungsaufwand

Neben der funktionalen Korrektheit stellt auch der Aufwand der Werkzeugausführung einen Aspekt der Orchestrierung dar. Liu et al. formulieren diesen Zusammenhang explizit als Abwägung zwischen dem erwarteten Nutzen weiterer Aktionen und deren Kosten. Die Utility-Funktion berücksichtigt neben dem erwarteten zusätzlichen Nutzen daher auch einen Kostenfaktor. Zusätzlich werden Unsicherheit und Redundanz berücksichtigt, um weitere Schritte zu fördern, wenn zusätzliche Informationen voraussichtlich hilfreich sind, und unnötige Wiederholungen zu vermeiden @liuUtilityGuidedAgentOrchestration2026.

Die Autoren betonen dabei, dass ihre Utility-Funktion keine nachgewiesenermaßen optimale Policy darstellt, sondern als strukturiertes und analysierbares Kontrollverfahren dient. Auch zeigen ihre Experimente nicht, dass der Ansatz grundsätzlich stärkere freie Agenten wie ReAct übertrifft. Der Beitrag wird daher insbesondere als Möglichkeit verstanden, das Verhalten eines Tool-Agents expliziter zu kontrollieren und dessen Kosten- und Entscheidungsverhalten zu analysieren @liuUtilityGuidedAgentOrchestration2026.

Auch die anderen betrachteten Ansätze zeigen, dass die Organisation der Tool-Aufrufe mit Effizienzfragen verbunden ist. Hernández et al. berücksichtigen beispielsweise parallele Ausführung für unabhängige Aktionen und formulieren in ihrem Planner explizite Regeln zur Minimierung unnötiger Werkzeugaufrufe und zur frühzeitigen Beendigung, wenn die vorhandenen Informationen als ausreichend angesehen werden @hernandezReActModularAgent2025.

=== Zusammenfassung

Die betrachteten Arbeiten zeigen, dass Tool-Orchestrierung verschiedene miteinander verbundene Aufgaben umfasst. Dazu gehören insbesondere die Auswahl und Anordnung von Werkzeugaufrufen, die Berücksichtigung von Abhängigkeiten zwischen ihnen sowie die Verarbeitung von Zwischenresultaten. Bei komplexeren Aufgaben kann die Ausführung als strukturierte Kette oder als Graph von Werkzeugaufrufen modelliert werden @paranjapeARTAutomaticMultistep2023 @luOrchDAGComplexTool2025.

Für die Organisation solcher Abläufe lassen sich unterschiedliche Grade der Strukturierung und Anpassbarkeit erkennen. Reaktive Ansätze treffen Entscheidungen schrittweise während der Ausführung, während planbasierte Ansätze zunächst eine übergeordnete Ausführungsstruktur erzeugen. Zwischen diesen Extremen liegen Ansätze wie RETO, die eine grobe globale Struktur mit einer lokal adaptiven Ausführung verbinden, sowie hierarchische Architekturen, bei denen Planung, technische Ausführung und Synthese getrennt werden @zheRobustEfficientTool2026 @hernandezReActModularAgent2025.

Darüber hinaus ist die Orchestrierung nicht ausschließlich auf die Erzeugung einer möglichst vollständigen Tool-Kette ausgerichtet. Liu et al. zeigen, dass auch die Entscheidung über zusätzliche Schritte, deren erwarteten Nutzen, Redundanz und den Zeitpunkt des Abbruchs Teil der Orchestrierung sein können @liuUtilityGuidedAgentOrchestration2026.

Für die vorliegende Arbeit sind damit insbesondere drei Aspekte relevant: die Strukturierung mehrerer Werkzeugaufrufe, die Abhängigkeit und Verarbeitung von Zwischenresultaten sowie der Grad, in dem die Ausführungsentscheidungen durch die Orchestrierungsstrategie vorgegeben oder während der Ausführung durch das LLM getroffen werden. Diese Aspekte bilden die Grundlage für die im Methodikteil untersuchten Orchestrierungsstrategien.

== Evaluation

Die Evaluation von Large Language Models (LLMs) im Zusammenhang mit Tool Use betrachtet unterschiedliche Fähigkeiten, die über die reine Korrektheit einer einzelnen Funktionsausführung hinausgehen. Insbesondere ist zu unterscheiden, ob ein Modell zunächst erkennt, ob ein externes Werkzeug benötigt wird, anschließend das geeignete Werkzeug auswählt und schließlich eine korrekte Folge von Werkzeugaufrufen erzeugt. Die betrachteten Arbeiten setzen dabei unterschiedliche Schwerpunkte und bilden damit verschiedene Ebenen der Tool-Orchestrierung ab.

=== Entscheidung für die Verwendung von Werkzeugen

Eine grundlegende Voraussetzung für eine sinnvolle Tool-Nutzung ist zunächst die Entscheidung, ob überhaupt ein externes Werkzeug eingesetzt werden sollte. Huang et al. (2024) untersuchen diese Fähigkeit im Rahmen des METATOOL-Benchmarks. Sie unterscheiden dabei zwischen der awareness of tool usage und der eigentlichen Auswahl von Werkzeugen. Die Autoren begründen diese Unterscheidung damit, dass ein LLM als Agent nicht nur vorhandene Werkzeuge verwenden, sondern zunächst seine eigenen Fähigkeiten einschätzen und entscheiden muss, ob externe Unterstützung erforderlich ist @huangMetaToolBenchmarkLarge2024.

Für die Evaluation der tool usage awareness verwenden Huang et al. (2024) Accuracy, Precision, Recall und F1-Score. Damit wird insbesondere eine binäre Entscheidung darüber bewertet, ob ein Werkzeug benötigt wird. Für die anschließende Werkzeugauswahl führen die Autoren mit der Correct Selection Rate (CSR) eine eigene Metrik ein. Diese gibt den Anteil der Anfragen an, bei denen die vom Modell ausgewählten Werkzeuge mit den vorgegebenen korrekten Werkzeugen übereinstimmen @huangMetaToolBenchmarkLarge2024.

METATOOL berücksichtigt dabei auch Situationen, in denen ein passendes Werkzeug zwar grundsätzlich existiert, jedoch nicht in der zur Verfügung gestellten Werkzeugmenge enthalten ist. In dieser sogenannten tool selection with possible reliability issues-Aufgabe ist das korrekte Verhalten daher nicht die Auswahl eines ähnlichen Werkzeugs, sondern die Vermeidung einer solchen Auswahl. Die Autoren untersuchen damit insbesondere Halluzinationen bei der Werkzeugauswahl @huangMetaToolBenchmarkLarge2024.

Einen vergleichbaren Schwerpunkt verfolgt WTU-EVAL von Liu et al. (2025). Die Autoren weisen darauf hin, dass viele Untersuchungen Tool Use unter der Annahme evaluieren, dass ein Werkzeug benötigt wird. WTU-EVAL betrachtet dagegen explizit die Frage, ob ein LLM zwischen Situationen unterscheiden kann, in denen ein Werkzeug erforderlich ist, und solchen, in denen die Aufgabe ohne Werkzeug gelöst werden kann. Dafür werden Datensätze, bei denen Werkzeuge benötigt werden, von allgemeinen Datensätzen unterschieden, bei denen die Aufgaben grundsätzlich ohne externe Werkzeuge lösbar sind @liuWTUEVALWhetherorNotTool2025.

Die Evaluation von WTU-EVAL vergleicht dabei unter anderem Situationen ohne verfügbaren Werkzeugpool mit Situationen, in denen das Modell selbst entscheiden muss, ob es ein Werkzeug verwendet. Die Autoren zeigen, dass eine zusätzliche Werkzeugverfügbarkeit nicht automatisch zu besseren Ergebnissen führt. Insbesondere bei Aufgaben, die eigentlich ohne Werkzeug lösbar sind, kann eine unnötige Werkzeugverwendung die Leistung verschlechtern @liuWTUEVALWhetherorNotTool2025.

Damit zeigen METATOOL und WTU-EVAL eine für die Evaluation von Tool-Orchestrierung relevante Eigenschaft. Ein Toolaufruf ist nicht allein deshalb positiv zu bewerten, weil er formal korrekt ausgeführt wurde. Auch die Entscheidung, kein Werkzeug aufzurufen, kann die korrekte Handlung darstellen.

=== Auswahl und Anzahl der Werkzeugaufrufe

Neben der Entscheidung für oder gegen Tool Use ist die Auswahl der richtigen Werkzeuge eine weitere zentrale Evaluationsdimension. METATOOL betrachtet hierfür vier unterschiedliche Aufgaben: die Auswahl unter ähnlichen Werkzeugen, die Auswahl in unterschiedlichen Anwendungsszenarien, die Auswahl unter Bedingungen mit möglichen Zuverlässigkeitsproblemen sowie die Auswahl mehrerer Werkzeuge. Die vier Aufgaben sollen unterschiedliche Aspekte der Werkzeugauswahl abbilden, darunter semantisches Verständnis, Anpassungsfähigkeit, Zuverlässigkeit und Schlussfolgerungsfähigkeit @huangMetaToolBenchmarkLarge2024.

Insbesondere die Aufgabe der Multi-Tool Selection ist für die Orchestrierung relevant. Dabei müssen nicht nur einzelne Werkzeuge identifiziert, sondern mehrere für eine Anfrage relevante Werkzeuge ausgewählt werden. Huang et al. (2024) unterscheiden bei der Auswertung unter anderem zwischen Fällen, in denen beide benötigten Werkzeuge korrekt ausgewählt wurden, nur eines korrekt ausgewählt wurde oder zwei Werkzeuge ausgewählt wurden, von denen nur eines korrekt ist. Dadurch wird sichtbar, dass eine reine Ja/Nein-Bewertung der Werkzeugverwendung bei mehreren benötigten Werkzeugen nur einen Teil der tatsächlichen Leistung erfasst @huangMetaToolBenchmarkLarge2024.

Eine noch stärker auf Function Calling ausgerichtete Unterteilung verwendet BFCL von Patil et al. (2025). Die Single-Turn-Aufgaben werden danach klassifiziert, wie viele Werkzeuge verfügbar sind und wie viele Funktionsaufrufe erwartet werden. Dabei werden Simple, Multiple, Parallel, Parallel Multiple, Relevance und Irrelevance unterschieden. Während bei Simple ein einzelnes verfügbares Werkzeug einmal aufgerufen wird, enthalten Multiple-Aufgaben mehrere verfügbare Werkzeuge, von denen eines ausgewählt werden muss. Parallel und Parallel Multiple erweitern dies um mehrere gleichzeitig erforderliche Aufrufe. Relevance bezeichnet Situationen, in denen mindestens ein Funktionsaufruf erforderlich ist, während bei Irrelevance trotz vorhandener Werkzeuge kein Aufruf erwartet wird @patilBerkeleyFunctionCalling2025.

Diese Kategorisierung ist insbesondere für die Untersuchung von Orchestrierungsstrategien relevant, da sie die Komplexität einer Aufgabe nicht ausschließlich über die Korrektheit eines einzelnen Tool Calls beschreibt. Vielmehr wird zwischen Werkzeugauswahl, mehreren erforderlichen Aufrufen und dem Verzicht auf einen Aufruf unterschieden.

=== Bewertung einzelner Aufrufe und vollständiger Tool-Sequenzen

Eine wichtige Unterscheidung für die Evaluation komplexerer Tool-Nutzung findet sich bei Lu et al. (2025) im Rahmen von OrchDAG. Dort werden Werkzeugausführungen als gerichtete azyklische Graphen (DAGs) modelliert. Ein Knoten entspricht dabei einem Werkzeugaufruf, während Kanten Abhängigkeiten zwischen Werkzeugen darstellen. Ein Ausgabeparameter eines vorherigen Werkzeugaufrufs kann beispielsweise als Eingabe für einen nachfolgenden Aufruf dienen. Dadurch lässt sich nicht nur bewerten, welche Werkzeuge verwendet werden, sondern auch, wie diese miteinander verbunden sind @luOrchDAGComplexTool2025.

Für die Evaluation unterscheiden Lu et al. (2025) explizit zwischen Accuracy/step und Accuracy/user_query. Accuracy/step bewertet jeden einzelnen Handlungsschritt unabhängig. Ein einzelner Schritt kann somit korrekt sein, obwohl die gesamte Werkzeugausführungsstruktur der Anfrage nicht korrekt ist. Accuracy/user_query bewertet dagegen die vollständige Werkzeugausführungsstruktur und ist nur dann korrekt, wenn der gesamte Tool Execution Graph korrekt ist @luOrchDAGComplexTool2025.

Diese Unterscheidung zeigt eine wesentliche Herausforderung bei der Bewertung von Tool-Orchestrierung. Eine einzelne korrekte Werkzeugentscheidung und eine vollständig korrekte Lösung einer mehrstufigen Aufgabe sind nicht dasselbe. Ein Modell kann beispielsweise mehrere einzelne Werkzeuge korrekt auswählen, aber eine notwendige Abhängigkeit zwischen ihnen falsch modellieren. Eine reine Bewertung auf Ebene der einzelnen Aufrufe würde einen solchen Fehler nur unvollständig abbilden.

Auch BFCL unterscheidet zwischen unterschiedlichen Ebenen der Evaluation. Für Single-Turn-Aufgaben verwendet BFCL unter anderem eine AST-basierte Bewertung, bei der Funktionsname und Parameter des erzeugten Aufrufs mit den erwarteten Werten abgeglichen werden. Für komplexere Szenarien kommen weitere Evaluationsverfahren zum Einsatz. Bei Multi-Turn-Aufgaben wird beispielsweise sowohl der resultierende Systemzustand als auch die Antwort des Modells überprüft. Ein Eintrag gilt dabei nur dann als korrekt, wenn beide Prüfungen über alle Turns erfolgreich sind @patilBerkeleyFunctionCalling2025.

Für parallele Funktionsaufrufe verwendet BFCL außerdem eine All-or-Nothing-Bewertung: Die Reihenfolge paralleler Aufrufe ist zwar irrelevant, jedoch muss jeder erwartete Aufruf gefunden werden. Fehlt auch nur ein erforderlicher Aufruf, gilt die gesamte Prediction als nicht korrekt @patilBerkeleyFunctionCalling2025.

=== Bewertung von Abhängigkeiten von Tools und komplexen Ausführungsplänen

OrchDAG erweitert die Betrachtung von Tool Use insbesondere um Abhängigkeiten zwischen mehreren Aufrufen und um Multi-Turn-Szenarien. Die Autoren berücksichtigen unter anderem Situationen, in denen eine neue Anfrage auf vorherigen Werkzeugergebnissen aufbaut, eine vollständig neue Werkzeugausführungsstruktur benötigt oder ein vorheriger Aufruf aufgrund eines Fehlers erneut ausgeführt werden muss. Die Qualität der erzeugten Tool-Pläne wird dabei anhand ihrer DAG-Struktur überprüft @luOrchDAGComplexTool2025.

Die Ergebnisse von OrchDAG verdeutlichen zudem, warum eine getrennte Betrachtung verschiedener Bewertungsebenen sinnvoll ist. In den Experimenten erzielen Modelle teilweise eine deutlich höhere Accuracy/step als Accuracy/user_query. Die Autoren interpretieren dies dahingehend, dass Modelle einzelne Schritte korrekt ausführen können, gleichzeitig aber Schwierigkeiten haben, eine konsistente Gesamtstruktur der Tool-Ausführung aufrechtzuerhalten @luOrchDAGComplexTool2025.

Damit ergänzt OrchDAG die stärker auf einzelne Tool Calls ausgerichteten Ansätze von METATOOL, WTU-EVAL und BFCL um die strukturelle Korrektheit einer Tool-Sequenz. Für eine Orchestrierungsstrategie ist diese Ebene besonders relevant, da die Qualität nicht nur davon abhängt, ob einzelne Werkzeuge richtig gewählt werden, sondern auch davon, ob die Gesamtheit der Aufrufe zur Bearbeitung der Aufgabe geeignet ist.

=== Zusammenfassung der bisherigen Evaluationsansätze

Die betrachteten Arbeiten machen deutlich, dass die Qualität von Tool Use auf mehreren Ebenen bewertet werden kann. METATOOL und WTU-EVAL legen einen Schwerpunkt auf die Entscheidung, ob ein Werkzeug benötigt wird, sowie auf die korrekte Auswahl verfügbarer Werkzeuge. BFCL differenziert stärker nach der Anzahl verfügbarer Werkzeuge und erforderlicher Aufrufe und berücksichtigt dabei auch parallele Aufrufe sowie Situationen, in denen kein Werkzeug verwendet werden soll. OrchDAG betrachtet darüber hinaus die Abhängigkeiten und die Korrektheit vollständiger Tool-Ausführungsstrukturen @huangMetaToolBenchmarkLarge2024, @patilBerkeleyFunctionCalling2025, @luOrchDAGComplexTool2025.

Aus diesen Arbeiten lassen sich somit mehrere für die Evaluation von Tool-Orchestrierung relevante Dimensionen ableiten:

- *Tool-Bedarf:* Wird erkannt, ob für eine Aufgabe ein Werkzeug benötigt wird?
- *Tool-Auswahl:* Werden die für die Aufgabe geeigneten Werkzeuge ausgewählt?
- *Aufrufkorrektheit:* Sind Funktionsname und übergebene Parameter korrekt?
- *Vollständigkeit:* Werden alle für die Lösung erforderlichen Werkzeugaufrufe durchgeführt?
- *Redundanz bzw. unnötige Aufrufe:* Werden Werkzeuge aufgerufen, obwohl sie für die Aufgabe nicht benötigt werden?
- *Ausführungsstruktur:* Sind Abhängigkeiten und die Reihenfolge der Werkzeugaufrufe geeignet?
- *Gesamtkorrektheit:* Ist die vollständige Werkzeugausführungssequenz ausreichend, um die gestellte Aufgabe korrekt zu bearbeiten?

Die vorhandenen Arbeiten gewichten diese Dimensionen unterschiedlich. Insbesondere BFCL und OrchDAG zeigen, dass zwischen der Korrektheit einzelner Handlungsschritte und der Korrektheit einer vollständigen Tool-Ausführungsstruktur unterschieden werden kann. OrchDAG macht diese Differenz mit Accuracy/step und Accuracy/user_query explizit, während BFCL bei bestimmten Kategorien eine vollständige Übereinstimmung der erwarteten Aufrufe verlangt @luOrchDAGComplexTool2025, @patilBerkeleyFunctionCalling2025.

Für die vorliegende Arbeit ergibt sich daraus, dass eine Evaluation von Orchestrierungsstrategien nicht auf eine einzelne Erfolgsmetrik reduziert werden sollte. Während eine Gesamtbewertung der erfolgreichen Aufgabenbearbeitung die praktische Leistungsfähigkeit einer Strategie beschreibt, ermöglicht eine zusätzliche Betrachtung einzelner Tool-Aufrufe die Identifikation der konkreten Ursachen von Fehlentscheidungen. Die genannten Arbeiten liefern damit die Grundlage für eine mehrstufige Evaluation, bei der sowohl die Korrektheit einzelner Toolaufrufe als auch die Qualität der daraus entstehenden gesamten Tool-Ausführung berücksichtigt wird.

== Zwischenfazit

Die Betrachtung des aktuellen Forschungsstands zeigt, dass LLMs durch den Einsatz externer Werkzeuge über die Verarbeitung von Informationen innerhalb des Modells hinaus erweitert werden können. Für den Zugriff auf strukturierte Daten stehen dabei unterschiedliche Ansätze zur Verfügung, darunter die Generierung von Datenbankabfragen sowie der Aufruf bereitgestellter Funktionen. Bei Function Calling werden Werkzeuge und deren erwartete Parameter strukturiert beschrieben, sodass ein Modell geeignete Funktionen auswählen und mit den erforderlichen Argumenten aufrufen kann. Gleichzeitig stellt die Verarbeitung von Zeitreihendaten besondere Anforderungen an die Darstellung und Verarbeitung der Daten, da neben den enthaltenen Werten auch deren zeitliche Struktur berücksichtigt werden muss.

Mit zunehmender Aufgabenkomplexität reicht die Betrachtung einzelner Werkzeugaufrufe jedoch nicht mehr aus. Werden mehrere Werkzeuge benötigt, können Abhängigkeiten zwischen deren Aufrufen entstehen, sodass Ergebnisse vorheriger Schritte für nachfolgende Aufrufe benötigt werden. Die betrachteten Arbeiten zeigen hierfür unterschiedliche Ansätze zur Planung, Strukturierung und iterativen Ausführung von Werkzeugaufrufen. Diese reichen von strukturierten Programmen und expliziten Ausführungsplänen über graphbasierte Darstellungen von Abhängigkeiten bis hin zu adaptiven Verfahren, bei denen die nächsten Aktionen schrittweise während der Ausführung bestimmt werden. Auch die Berücksichtigung von Ausführungsaufwand, Redundanz und Fehlern kann Bestandteil der Orchestrierung sein.

Für die Bewertung solcher Systeme reicht eine alleinige Betrachtung des finalen Antwortergebnisses ebenfalls nicht aus. Die betrachteten Evaluationsansätze unterscheiden unter anderem zwischen der Entscheidung, ob ein Werkzeug benötigt wird, der Auswahl geeigneter Werkzeuge, der Korrektheit ihrer Parameter sowie der Korrektheit einzelner und vollständiger Werkzeugausführungen. Damit wird deutlich, dass Tool-Nutzung sowohl auf Ebene einzelner Aufrufe als auch auf Ebene einer vollständigen Ausführungssequenz betrachtet werden kann.

Insgesamt ergibt sich aus dem Forschungsstand somit ein Lösungsraum, der verschiedene Möglichkeiten für Datenzugriff, Datenverarbeitung, Tool-Nutzung und deren Orchestrierung umfasst. Die bisherigen Arbeiten betrachten dabei unterschiedliche Formen der Strukturierung und Entscheidungsfreiheit bei der Werkzeugausführung. Welche dieser Möglichkeiten sich für die Verarbeitung von Energiedaten und insbesondere für die Bearbeitung von Aufgaben mit Zeitreihendaten eignen und wie unterschiedliche Orchestrierungsstrategien hinsichtlich ihrer Tool-Nutzung und Effizienz abschneiden, wird im Rahmen der vorliegenden Arbeit untersucht. Die konkrete Auswahl und Ausgestaltung der dafür verwendeten Verfahren sowie deren experimentelle Evaluation werden im folgenden Methodikteil beschrieben.