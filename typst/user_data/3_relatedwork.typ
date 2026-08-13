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

// STRUCUTRE 20260811:
// Was ist Tool Use / Function Calling?
// Wie werden Tools beschrieben und bereitgestellt?
// Toolauswahl
// Parameter-/Argumentgenerierung
// strukturierte Tooldefinitionen
// Toolergebnisse
// gegebenenfalls besondere Anforderungen deiner Zeitreihendaten
// relevante Arbeiten wie Toolformer
// Während ein einzelner Tool-Aufruf vergleichsweise einfach ist, entstehen bei Aufgaben, die mehrere Werkzeuge erfordern, zusätzliche Anforderungen ... -> Übergang zu Orchestrierung

// STRUCTURE 20260812:
// Tool Use / Function Calling
// Toolbeschreibung
// Toolauswahl
// Argumente
// Toolergebnisse
// ggf. Zeitreihendaten

// Einleitung Tooldesign Methodik
Für die Nutzung externer Werkzeuge durch ein Large Language Model müssen die verfügbaren Funktionen in einer für das Modell verständlichen und eindeutig interpretierbaren Form bereitgestellt werden. Dabei ist insbesondere eine klare Beschreibung der verfügbaren Werkzeuge sowie der von ihnen erwarteten Eingaben erforderlich. Ansätze zur Tool-Nutzung durch Large Language Models zeigen, dass das Modell neben der Auswahl eines geeigneten Werkzeugs auch die für dessen Aufruf erforderlichen Argumente bestimmen muss. Toolformer beschreibt beispielsweise die Auswahl und Ausführung externer Werkzeuge als Bestandteil der Modellentscheidung und unterscheidet dabei zwischen der Auswahl einer API und der Erzeugung der zugehörigen Eingabe @schickToolformerLanguageModels2023.

Diese strukturierte Bereitstellung der Werkzeuge bildet zugleich eine Grundlage für die Koordination mehrerer Werkzeuge innerhalb einer Aufgabe. Während bei einer einfachen Tool-Nutzung lediglich ein einzelner Funktionsaufruf erforderlich sein kann, müssen bei komplexeren Aufgaben mehrere spezialisierte Werkzeuge ausgewählt und in geeigneter Weise miteinander kombiniert werden. Aktuelle Arbeiten zur Entwicklung von Tool-Use-Systemen betrachten daher insbesondere die Koordination mehrerer Werkzeuge sowie die Planung und Ausführung aufeinanderfolgender Tool-Aufrufe als zentrale Bestandteile solcher Systeme @xuEvolutionToolUse2026.

wie ein LLM mehrere spezialisierte Tools zur Bearbeitung einer Aufgabe koordiniert @xuEvolutionToolUse2026

=== Datenbankabfrage // Quellen finden, wichtige Grundlage für Orchestrierung - Methodik: Warum Funktionen gewählt?

*Text to SQL:* Wie der Name schon sagt wird hier ein Inputtext in eine SQL-Query übersetzt mit der dann auf eine Datenbank zugegriffen wird. Tabellennamen sind teilweise nicht selbsterklärend und müssen definiert werden.

// API: mögliche Authentifizierung und Berechtigungsbeschränkungen, klar strukturierte Abfrage

*Funktionen:* Man kann ebenso fixe SQL Abfragen in Funktionen verpacken. Dann kann man Funktions- und Parameternamen selbsterklärend definieren und so weniger Erklärungsbedarf notwendig ist. Meine These ist, dass dieses vorgehen mit guter Struktur weniger Token verbraucht, effizienter und schneller sowie kontrollierter läuft. Aber das könnte man noch vergleichen.

=== Zeitreihendaten

Energiedaten bestehen oft aus Zeitreihen. Diese direkt im Kontext zu übergeben würde relativ viele Token verbrauchen und den begrenzten Kontext schnell füllen wodurch auch der Fokus auf das wesentliche verloren geht. Außerdem ist ein LLM auf Sprachverständnis optimiert und nicht unbedingt auf Mustererkennung von langen Zahlenreihen. Im Optimalfall hat man Analysemodelle auf die das LLM zugreifen kann die relevante Informationen aus Zeitreihen herausfiltern oder beschreiben ohne, dass das LLM selbst diese analysieren muss. Wenn man das richtig umsetzt ist das effizienter sowie konsistenter. Ein ganz einfaches Beispiel wäre das Herausfiltern von statistischen Werten wie Maximum, Minimum, Durchschnitt usw. Bei Mustererkennung wird das ganze schon etwas komplexer. Hier muss man sich überlegen welche Fragestellungen man beantworten möchte und entsprechende Modelle dafür entwickeln. Das kann aber aufwendig und unflexibel sein.

Das Paper „A Picture is Worth A Thousand Numbers: Enabling LLMs Reason about Time Series via Visualization“ beschäftigt sich unter anderem damit wie man Zeitreihen besser mit LLMs verarbeiten kann. Grob zusammengefasst werden die Zeitreihen nicht direkt als Array bzw. Json übergeben sondern es wird erst ein Plot erzeugt welcher anschließend übergeben wird. Nutzt man optional noch ICL (In Context Learning) kann man Beispielplots von verschiedenen Mustern und dessen Beschreibung als Vorlage für den zu analysierenden Plot zum Kontext hinzufügen. Vor allem bei spezifischen Domänen auf die das LLM nicht oder nur wenig trainiert ist kann das sehr Hilfreich sein. Laut Testergebnissen soll durch diese Methode eine Performancesteigerung von 140% und eine Tokenersparnis von 99% erreicht worden sein. Außerdem soll die Mustererkennung von Bildern deutlich besser sein @liuPictureWorthThousand.

=== MCP (Model Context Protocol) // gängige Umsetzung -> in Methodik begründen warum einfacher umgesetzt

Das Model Context Protocol (MCP) ist ein Standard zur strukturierten Integration von Tools und Datenquellen in LLM-basierte Systeme. Es definiert, wie externe Funktionen beschrieben, entdeckt und aufgerufen werden können. Im Gegensatz zu Orchestrierungsstrategien wie deterministischen Pipelines, plan-basierten
Ansätzen oder iterativen Verfahren (z. B. ReAct), beschreibt MCP nicht die Entscheidungslogik, sondern die Schnittstelle zwischen Modell und Tools.

*Vorteile*
• Einheitliche Tool-Schnittstelle (ähnlich wie eine API-Norm)
• Wiederverwendbarkeit von Tool-Integrationen
• Reduzierter Implementierungsaufwand
• Bessere Interoperabilität zwischen verschiedenen Modellen und Systemen

*Einschränkungen*
• MCP löst keine Probleme der Entscheidungslogik oder Planung
• Qualität hängt weiterhin stark von Prompting und Agent-Design ab
• Zusätzliche Abstraktion kann Overhead erzeugen

*Sinnvoll*
• bei komplexen Systemen mit vielen Tools
• bei modularen oder skalierbaren Architekturen
• wenn mehrere Modelle oder Teams beteiligt sind

*weniger sinnvoll*
• bei sehr kleinen, festen Pipelines
• wenn nur wenige, statische Tool-Aufrufe benötigt werden
• bei extrem latency-kritischen Anwendungen

*Fazit* // -> Zwischenfazit?
In frühen Prototypenphasen ist der Einsatz von MCP oft nicht erforderlich, da der Fokus hier auf schneller Iteration, Validierung von Konzepten und minimalem Implementierungsaufwand liegt. Direkte Tool-Integrationen ohne zusätzliche Abstraktionsschicht sind in diesem Kontext meist einfacher umzusetzen, leichter zu debuggen und verursachen weniger Overhead.

Mit zunehmender Systemkomplexität ändern sich jedoch die Anforderungen: Die Anzahl an Tools, Agenten und Schnittstellen wächst, wodurch individuelle Integrationen schnell unübersichtlich und schwer wartbar werden. An diesem Punkt bietet MCP einen entscheidenden Vorteil, da es eine standardisierte und konsistente Struktur für Toolzugriffe schafft.

In produktiven Systemen trägt MCP somit wesentlich zur Skalierbarkeit, Wartbarkeit und Erweiterbarkeit bei. Insbesondere in modularen Architekturen mit mehreren spezialisierten Agenten oder bei der Zusammenarbeit mehrerer Teams ermöglicht es eine klare Trennung von Verantwortlichkeiten und reduziert langfristig die Komplexität des Gesamtsystems.

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
