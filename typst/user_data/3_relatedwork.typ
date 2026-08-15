#import "../globals.typ": *

#context if text.lang == "de" [
    = Stand der Forschung
    <sec:relatedwork>
] else [
    = Related Work
    <sec:relatedwork>
]

// 7-10 Seiten

== Tooldesign

Für die Nutzung externer Werkzeuge durch ein Large Language Model müssen die verfügbaren Funktionen in einer für das Modell verständlichen und eindeutig interpretierbaren Form bereitgestellt werden. Dabei ist insbesondere eine klare Beschreibung der verfügbaren Werkzeuge sowie der von ihnen erwarteten Eingaben erforderlich. Ansätze zur Tool-Nutzung durch Large Language Models zeigen, dass das Modell neben der Auswahl eines geeigneten Werkzeugs auch die für dessen Aufruf erforderlichen Argumente bestimmen muss. Toolformer beschreibt beispielsweise die Auswahl und Ausführung externer Werkzeuge als Bestandteil der Modellentscheidung und unterscheidet dabei zwischen der Auswahl einer API und der Erzeugung der zugehörigen Eingabe @schickToolformerLanguageModels2023.

Diese strukturierte Bereitstellung der Werkzeuge bildet zugleich eine Grundlage für die Koordination mehrerer Werkzeuge innerhalb einer Aufgabe. Während bei einer einfachen Tool-Nutzung lediglich ein einzelner Funktionsaufruf erforderlich sein kann, müssen bei komplexeren Aufgaben mehrere spezialisierte Werkzeuge ausgewählt und in geeigneter Weise miteinander kombiniert werden. Aktuelle Arbeiten zur Entwicklung von Tool-Use-Systemen betrachten daher insbesondere die Koordination mehrerer Werkzeuge sowie die Planung und Ausführung aufeinanderfolgender Tool-Aufrufe als zentrale Bestandteile solcher Systeme @xuEvolutionToolUse2026.

== Orchestrierung

// STRUCTURE 20260811:
// Was bedeutet Orchestrierung?
// Warum ist sie bei mehreren Tools notwendig?
// Tool Chains
// Reihenfolge von Tool-Aufrufen
// Abhängigkeiten und Zwischenresultate
// State / Artefakte
// Planung
// iterative Ausführung
// Re-Planning
// unterschiedliche Grade der Entscheidungsfreiheit
// existierende Orchestrierungsansätze

// STRUCTURE 20260812:
// Koordination mehrerer Tools
// Reihenfolge / Abhängigkeiten
// State / Artefakte
// Planung
// iterative Ausführung
// Re-Planning
// verschiedene Freiheitsgrade
// konkrete Orchestrierungsansätze

Tool-Use Ansätze @paranjapeARTAutomaticMultistep2023

=== Robuste und effiziente Tool-Orchestrierung

Die zentrale Beobachtung ist, dass Fehler selten durch einzelne Tool-Aufrufe entstehen, sondern durch deren falsche Organisation und Reihenfolge. Anstelle detaillierter Planung schlagen die Autoren eine vereinfachte Struktur vor: Tools werden in grobe Ausführungsschichten (Layer) eingeteilt, die ihre Abhängigkeiten implizit abbilden. Die Ausführung erfolgt schichtweise, sodass ein Modell in jedem Schritt nur eine kleine, relevante Teilmenge an Tools betrachtet. Zusätzlich wird ein Mechanismus zur lokalen Fehlerkorrektur eingeführt. Fehlerhafte Tool-Aufrufe werden automatisch erkannt und korrigiert, ohne die gesamte Ausführungsstrategie neu zu planen. Dadurch werden Fehler isoliert und ihre Ausbreitung verhindert. Die Experimente zeigen, dass diese Kombination aus grober Struktur und lokaler Korrektur die Robustheit und Effizienz deutlich erhöht. Selbst kleinere, nicht speziell trainierte Modelle erreichen dadurch eine Leistung, die mit größeren oder feinjustierten Systemen vergleichbar ist, bei gleichzeitig geringerem Rechenaufwand @zheRobustEfficientTool2026.

Die zentrale Erkenntis ist, dass eine geeignete Strukturierung der Tool-Ausführung entscheidender für die Leistung ist als die reine Modellstärke oder detaillierte Planung @zheRobustEfficientTool2026.

// deterministisch

// plan-basiert (relevanz der Quellen überprüfen)

=== Utility-Guided

Ein zentrales Problem bei der Tool-Orchestrierung ist der Trade-off zwischen Antwortqualität und Ausführungskosten: mehr Zwischenschritte (z. B. Retrieval oder Tool Calls) verbessern oft die Qualität, führen aber zu höherem Tokenverbrauch und längerer Laufzeit. Anstatt Agentenverhalten nur implizit über Prompts zu steuern, formuliert das Paper die Orchestrierung als explizites Entscheidungsproblem. In jedem Schritt wählt der Agent eine Aktion (z. B. Antworten, Retrieval, Tool-Nutzung, Verifikation oder Stoppen) basierend auf einer UtilityFunktion @liuUtilityGuidedAgentOrchestration2026.

Diese Utility kombiniert vier Faktoren:
- erwarteter Nutzen (Gain)• Kosten eines weiteren Schritts (Cost)
- Unsicherheit (Uncertainty)
- Redundanz (Redundancy)

Der Agent führt iterativ die Aktion mit der höchsten Utility aus und entscheidet explizit, wann er stoppen sollte @liuUtilityGuidedAgentOrchestration2026.

*Zentrale Erkenntnisse*
- Mehr Reasoning-Schritte verbessern die Qualität nur begrenzt; der zusätzliche Nutzen nimmt schnell ab.
- Freie Agenten (z. B. ReAct) erzielen hohe Qualität, verursachen aber oft unnötige Kosten.
- Explizite Orchestrierung ermöglicht eine bessere Kontrolle über Kosten und Verhalten.
- Einfache heuristische Signale reichen bereits aus, um Agentenverhalten sinnvoll zu steuern.
- Effizienz entsteht nicht nur durch bessere Modelle, sondern durch bessere Entscheidungslogik.

Das Paper zeigt damit, dass Agent-Orchestrierung ein eigenständiges Problem ist und entscheidend für praktische, kosteneffiziente LLM-Systeme @liuUtilityGuidedAgentOrchestration2026.

// Iterativ (ReAct)

ReAct (Reasoning + Acting) ist eine Methode bei der das LLM den Tooloutput wieder als Input bekommt und überprüft ob die Informationen ausreichend sind oder weitere Toolaufrufe erforderlich sind. Es werden so lange neue Toolaufrufe getriggert bis das LLM entscheidet, dass es nun genügend oder die passenden Informationen erhalten hat. Es ist ratsam hierfür ein Schleifenlimit zu setzen, um die Kosten und die Laufzeit unter Kontrolle zu halten. Das Paper „ReAct Modular Agent: Orchestrating Tool-Use and Retrieval for Financial Workflows“ versucht den klassische ReAct Agent zu verbessern indem Reasoning und Acting voneinander getrennt werden. Der klassische ReAct Agent wird als monolitisch beschrieben, weil sowohl Reasoning und Acting in einem Aufruf abgearbeitet werden. Es wird erklärt, dass das zu einer hohen Latenz und inkonsistenten Entscheidungsgrenzen führt. Beim vorgestellten Hierarchical ReAct werden Planung und Toolaufruf voneinander getrennt wie in Abbildung 4 zu sehen. Der Planner erhält die Nutzeranfrage und entscheidet ob und welche Tools gebraucht werden. Fällt die Entscheidung, dass Tools aufgerufen werden sollen erhält diese Information der Dispatcher. Dieser ist ausschließlich für die technische Übersetzung zuständig, dass die Tools richtig aufgerufen werden können. Die Tooloutputs werden dann wieder an den Planner zurückgegeben. Dieser entscheidet nun ob er weitere Tools aufrufen möchte oder die alle Informationen an den Synthesizer weitergibt der die finale Antwort generiert. Der Planner und der Synthesizer (HighReasoning Roles) nutzen GPT-4o, ein relativ starkes Modell. Für den Dispatcher (Low-Latency Role) wird GPT-4.1-Nano verwendet, ein leichtgewichtigeres und schnelleres Modell @hernandezReActModularAgent2025.

// training (relevant?)

=== Toolformer // schon in "Einleitung Tooldesign Methodik" angeschnitten. Details irrelevant, weil zu weit weg von meiner Umsetzung?

Im Paper „Toolformer: Language Models Can Teach Themselves to Use Tools“ wird 2023 das erste mal der Toolformer vorgestellt. Hier wird gezeigt wie ein LLM selbst externe Tools über APIs lernen kann. Grob gesagt wird ein kleineres Modell durch ein Größeres trainiert. Durch Webscraping wird ein Trainingsdatenset aus vielen Texten generiert. Nun generiert das kleinere LLM einen Token nach dem anderen und kann auch Toolaufrufe einfügen. Das größere Modell beurteilt dann ob ein Toolaufruf sinnvoll ist oder nicht. Wenn es sinnvoll ist wird es behalten, wenn nicht verworfen. So bleiben Trainingstexte mit sinnvollen Toolaufrufen anhand dessen dann das Fine Tuning des kleineren Modells erfolgt. Es zeigt sich, dass kleinere Modelle davon stark profitieren und bei der Toolauswahl deutlich besser werden. Aber desto größer das Modell, desto weniger Mehrwert bietet dieses Vorgehen @schickToolformerLanguageModels2023.

=== GPT4Tools // Training kleinerer Modelle relevant für mein Paper? Ich wende nur an. Aber trotzdem Stand der Forschung als Möglichkeit -> Methodik begründen warum nicht gemacht? (nicht Fokus, zu viel Aufwand, Modelle vlt schon teilweise vortrainiert auf Tooluse?)

Im Paper „GPT4Tools: Teaching Large Language Models (LLMs) to Use Tools via Selfinstruction“ gezeigt wie man mit einem starkes Modell Trainingsdaten erzeugt, mit denen ein kleineres Modell lernt Tools zu benutzen mit dem man auch neue (unseen) Tools einlernen kann. Diesen Vorgang nennen sie GPT4Tools welcher in drei Schritte unterteilt ist @yangGPT4ToolsTeachingLarge2023.

*Schritt 1:* Wie bereits erklärt werden hier Trainingsdaten von einem stärkeren Modell erzeugt. In diesem Fall wird GPT-3.5 verwendet. Die Struktur dieser Trainingsdaten sieht wie folgt aus: Thought: Do I need to use a tool? Yes, Action: \<tool name>, Action Input: \<arguments>, Observation: \<result> @yangGPT4ToolsTeachingLarge2023.

*Schritt 2:* Mit diesen Trainingsdaten werden kleinere Daten trainiert. Im Paper sind das OPT-13B, LLaMa-13B und Vicuna-13B. Diese lernen durch Toolauswahl, Toolargumente und Toolaufrufsequenzen @yangGPT4ToolsTeachingLarge2023.

*Schritt 3:* Anschließend wird das Ergebnis mit der Successful Rate (SR) evaluiert. DIe SR setzt sich aus Sucessful Rate of Thought (SRt), Successful Rate of Action (SRact) und Successful Rate of Arguments (SRargs) zusammen. Bei jeder dieser Metriken gibt es Wahr oder Falsch welche in 0 oder 1 ausgedrückt werden. Alle drei müssen 1 sein damit SR ebenfalls 1 ist. Dadurch stellt man fest, dass kleine Modelle durch dieses Training signifikant verbessert werden und sogar neue (unseen) Tools sehr gute SR Werte erzielen können. Da wir beim Forschungsprojekt voraussichtlich auf ein lokales LLM setzen werden ist dies durchaus eine interessante Methode die man in Betracht ziehen kann @yangGPT4ToolsTeachingLarge2023.

GPT4Tools ermöglicht es LLMs auf multi-modal tools zuzugreifen. Aber für den praktischen Einsatz sind noch weitere Verbesserungen notwendig @yangGPT4ToolsTeachingLarge2023.

=== Proactive Agent

Im Paper „Proactive Agent: Shifting LLM Agents from Reactive Responses to Active Assistance“ wird versucht einen Agenten zu entwickeln der nicht nur auf explizite Nutzeranfragen reagiert sondern proaktiv Hilfe anbietet. Er soll die Bedrüfnisse des Nutzers basierend auf User-Aktivitäten (z. B. Maus, Tastatur, Browser) implizit erkennen. Behandelt wurden unter anderem die Szenarien Programmieren und Schreiben. Ein LLM neigt dazu zu häufig Hilfe anzubieten was schnell nervig werden kann. Daher werden Vorschläge von Menschen gelabelt und zum Training verwendet. Das führt zu einer deutlichen Verbesserung aber der Agent bietet trotzdem noch unnötige Hilfe an. Außerdem ist das Timing schwer wann Hilfe angeboten wird. Zu früh ist nervig, zu spät ist nutzlos. Und es ist sehr schwierig automatisch zu erkenne was der Nutzer wirklich möchte. Außerdem braucht es viel Kontext den man oft nicht hat. Zusätzlich sind Datenschutz und Privatsphäre kritisch. Das Paper zeigt, dass es theoretisch geht, aber es noch nicht zuverlässig genug für eichen
praktischen Einsatz funktioniert. Wählt man ein sehr kontrolliertes Setting wie Coding oder Schreibtools kann es schon sinnvoll eingesetzt werden da der Kontext stark strukturiert vorliegt @luProactiveAgentShifting2024.

== Datenbankabfrage // final

// Text to SQL
Eine Möglichkeit, Datenbanken über natürliche Sprache zugänglich zu machen, ist Text-to-SQL. Dabei wird eine natürlichsprachliche Anfrage in eine ausführbare SQL-Abfrage übersetzt @singhComprehensiveReviewLLMbased2026.

Die Generierung einer geeigneten SQL-Abfrage erfordert neben der Interpretation der natürlichsprachlichen Anfrage auch ein Verständnis des zugrunde liegenden Datenbankschemas. Moderne Text-to-SQL-Systeme beziehen daher Schemainformationen ein und verwenden unter anderem Verfahren zum Schema Linking, um relevante Tabellen und weitere Datenbankelemente für die Abfragegenerierung zu bestimmen @singhComprehensiveReviewLLMbased2026.

Mit zunehmender Komplexität der Datenbank entstehen dabei zusätzliche Herausforderungen. Komplexe Schemata, Beziehungen zwischen Tabellen, mehrdeutige Anfragen sowie die korrekte Generierung komplexer SQL-Konstruktionen können die Zuverlässigkeit der erzeugten Abfragen beeinträchtigen. Entsprechend sind Schemaverständnis, robuste SQL-Generierung und die Behandlung komplexer Anfragen weiterhin zentrale Herausforderungen der Text-to-SQL-Forschung @hongNextGenerationDatabaseInterfaces2025.

// Function Calling
Eine alternative Möglichkeit besteht darin, Datenbankoperationen über vordefinierte Funktionen bereitzustellen. Dabei wird die für eine Operation benötigte Abfragelogik innerhalb einer Funktion gekapselt, während das Sprachmodell lediglich aus den verfügbaren Funktionen auswählt und deren definierte Parameter bestimmt. De Costa et al. verwenden einen solchen Ansatz, bei dem zweckgebundene Funktionen vorab definierte und validierte SQL-Abfragen kapseln. Dadurch wird die Generierung der eigentlichen SQL-Logik aus dem direkten Einflussbereich des Sprachmodells genommen und die zulässige Interaktion mit der Datenbank auf die bereitgestellten Operationen beschränkt @costaEnhancingAccuracyMaintainability2025.

Der Ansatz bietet insbesondere dort Vorteile, wo die Kontrollierbarkeit und Nachvollziehbarkeit der Datenabfragen relevant sind. De Costa et al. berichten in ihrem konkreten Anwendungskontext zudem eine höhere durch Experten bewertete Korrektheit sowie Vorteile hinsichtlich der Wartbarkeit gegenüber einem direkten NL-to-SQL-Ansatz. Gleichzeitig entsteht durch die Entwicklung und Pflege der Funktionsbibliothek ein zusätzlicher Aufwand @costaEnhancingAccuracyMaintainability2025.

== Zeitreihendaten // final

Energiedaten liegen häufig in Form von Zeitreihen vor. Eine direkte Übergabe längerer Zeitreihen an ein LLM kann problematisch sein. Bei der numerischen Repräsentation entstehen einerseits hohe Tokenkosten, andererseits können relevante zeitliche, dimensionale oder frequenzbezogene Merkmale nur schwer aus der Folge numerischer Werte extrahiert werden. Liu et al. zeigen beispielsweise, dass ein einzelnes Zeitreihenbeispiel im untersuchten RCW-Datensatz bei GPT-4o bis zu 60.000 Input-Tokens benötigen kann. Die Autoren identifizieren die direkte numerische Modellierung daher als eine wesentliche Ursache für die beobachteten Schwierigkeiten von LLMs beim Reasoning über Zeitreihen @liuPictureWorthThousand.

Eine Möglichkeit besteht darin, Zeitreihen zunächst durch spezialisierte Verfahren zu analysieren und dem LLM lediglich relevante Merkmale oder Ergebnisse bereitzustellen. Dies kann beispielsweise die Berechnung statistischer Kennwerte umfassen. Für komplexere Fragestellungen sind jedoch spezifische Verfahren zur Merkmalsextraktion oder Mustererkennung erforderlich, wodurch die Lösung stärker auf die jeweils vorgesehenen Fragestellungen zugeschnitten werden muss @liuPictureWorthThousand.

Einen alternativen Ansatz untersuchen Liu et al. mit VL-Time. Anstatt die Zeitreihen direkt als numerische Daten an das LLM zu übergeben, werden diese visualisiert und anschließend von einem multimodalen LLM verarbeitet. Die Methode umfasst zunächst eine Planungsphase, in der unter anderem eine geeignete Visualisierung im Zeit- oder Frequenzbereich sowie relevante Merkmale bestimmt werden. In der anschließenden Lösungsphase wird die visualisierte Zeitreihe zusammen mit sprachlichen Hinweisen verarbeitet @liuPictureWorthThousand.

Die Visualisierung dient dabei nicht nur der Darstellung, sondern gleichzeitig als Kompromiss zwischen Informationsgehalt und Kontextgröße. Im untersuchten RCW-Beispiel reduziert sich die Repräsentation eines Zeitreihenbeispiels von bis zu 60.000 Tokens bei numerischer Modellierung auf 85 Tokens bei visueller Modellierung. Zusätzlich untersuchen Liu et al. Few-Shot In-Context Learning, bei dem Beispiele zur jeweiligen Aufgabe in den Kontext aufgenommen werden. Im Vergleich zur numerischen Modellierung erzielt VL-Time dabei eine durchschnittliche relative Leistungssteigerung von 140 % und reduziert die durchschnittlichen Tokenkosten um 99 % @liuPictureWorthThousand.

// Energiedaten bestehen oft aus Zeitreihen. Diese direkt im Kontext zu übergeben würde relativ viele Token verbrauchen und den begrenzten Kontext schnell füllen wodurch auch der Fokus auf das wesentliche verloren geht. Außerdem ist ein LLM auf Sprachverständnis optimiert und nicht unbedingt auf Mustererkennung von langen Zahlenreihen. Im Optimalfall hat man Analysemodelle auf die das LLM zugreifen kann die relevante Informationen aus Zeitreihen herausfiltern oder beschreiben ohne, dass das LLM selbst diese analysieren muss. Wenn man das richtig umsetzt ist das effizienter sowie konsistenter. Ein ganz einfaches Beispiel wäre das Herausfiltern von statistischen Werten wie Maximum, Minimum, Durchschnitt usw. Bei Mustererkennung wird das ganze schon etwas komplexer. Hier muss man sich überlegen welche Fragestellungen man beantworten möchte und entsprechende Modelle dafür entwickeln. Das kann aber aufwendig und unflexibel sein.

// Das Paper „A Picture is Worth A Thousand Numbers: Enabling LLMs Reason about Time Series via Visualization“ beschäftigt sich unter anderem damit wie man Zeitreihen besser mit LLMs verarbeiten kann. Grob zusammengefasst werden die Zeitreihen nicht direkt als Array bzw. Json übergeben sondern es wird erst ein Plot erzeugt welcher anschließend übergeben wird. Nutzt man optional noch ICL (In Context Learning) kann man Beispielplots von verschiedenen Mustern und dessen Beschreibung als Vorlage für den zu analysierenden Plot zum Kontext hinzufügen. Vor allem bei spezifischen Domänen auf die das LLM nicht oder nur wenig trainiert ist kann das sehr Hilfreich sein. Laut Testergebnissen soll durch diese Methode eine Performancesteigerung von 140% und eine Tokenersparnis von 99% erreicht worden sein. Außerdem soll die Mustererkennung von Bildern deutlich besser sein @liuPictureWorthThousand.

== Evaluation

// STRUCTURE 20260811:
// Was wird bei Tool-Use-Systemen gemessen?
// Task Success
// Tool Selection
// Parameter Correctness
// Multi-Step Success
// Effizienz
// Umgang mit Fehlern
// State/Dependency Correctness
// bestehende Benchmarks und Evaluationsansätze

// STRUCTURE 20260812:
// Task Success
// Tool Selection
// Parameter Correctness
// Multi-Step Success
// Effizienz
// Fehler
// State/Dependency Correctness
// Benchmarks

// LITERATUR 20260812:
// huangMetaToolBenchmarkLarge2024 – MetaTool Benchmark
// liuWTUEVALWhetherorNotTool2025 – WTU-EVAL
// chenToolUseAlignment2024 – Tool Use Alignment
// xuEvolutionToolUse2026 – aktueller Überblick über Multi-Tool-Orchestrierung

Ausgewertet werden die Ergebnisse mit zwei Metriken die sich jeweils aus drei binären Kriterien zusammensetzen. Die Metriken sind Synthesis Quality (SQ) und Planning Efficiency (PE). Außerdem wird auch die Execution Latency (EL) verglichen @hernandezReActModularAgent2025.

@chenToolUseAlignment2024
@alazrakiMetaReasoningImprovesTool2025
@huangMetaToolBenchmarkLarge2024
@liuWTUEVALWhetherorNotTool2025

== Zwischenfazit
