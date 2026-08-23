== Orchestrierung

// Einleitung
Während bei der Nutzung eines einzelnen Werkzeugs die Auswahl und Ausführung eines einzelnen Aufrufs im Vordergrund steht, entstehen bei komplexeren Aufgaben Abhängigkeiten zwischen mehreren Werkzeugaufrufen. Beispielsweise kann das Ergebnis eines ersten Werkzeugs als Eingabe für ein nachfolgendes Werkzeug dienen. Die Koordination mehrerer solcher Aufrufe stellt damit eine weiterführende Herausforderung der Tool-Nutzung dar.

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

// QUELLEN:
// liuUtilityGuidedAgentOrchestration2026
// luOrchDAGComplexTool2025
// zheRobustEfficientTool2026
// jiayangTrainingLLMsMultiStep2026
// alazrakiMetaReasoningImprovesTool2025
// paranjapeARTAutomaticMultistep2023
// duanMultitoolIntegrationApplication2024
// romanOrchestralAIFramework2026
// yuAdaptOrchTaskAdaptiveMultiAgent2026
// suiTrainingFreeTimeSeries2025 eher Zeitreihen
// strehlowSAGEToolAugmentedLLM2026 eher Multi-Agent/Orchestrierung

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

=== Proactive Agent

Im Paper „Proactive Agent: Shifting LLM Agents from Reactive Responses to Active Assistance“ wird versucht einen Agenten zu entwickeln der nicht nur auf explizite Nutzeranfragen reagiert sondern proaktiv Hilfe anbietet. Er soll die Bedrüfnisse des Nutzers basierend auf User-Aktivitäten (z. B. Maus, Tastatur, Browser) implizit erkennen. Behandelt wurden unter anderem die Szenarien Programmieren und Schreiben. Ein LLM neigt dazu zu häufig Hilfe anzubieten was schnell nervig werden kann. Daher werden Vorschläge von Menschen gelabelt und zum Training verwendet. Das führt zu einer deutlichen Verbesserung aber der Agent bietet trotzdem noch unnötige Hilfe an. Außerdem ist das Timing schwer wann Hilfe angeboten wird. Zu früh ist nervig, zu spät ist nutzlos. Und es ist sehr schwierig automatisch zu erkenne was der Nutzer wirklich möchte. Außerdem braucht es viel Kontext den man oft nicht hat. Zusätzlich sind Datenschutz und Privatsphäre kritisch. Das Paper zeigt, dass es theoretisch geht, aber es noch nicht zuverlässig genug für eichen
praktischen Einsatz funktioniert. Wählt man ein sehr kontrolliertes Setting wie Coding oder Schreibtools kann es schon sinnvoll eingesetzt werden da der Kontext stark strukturiert vorliegt @luProactiveAgentShifting2024.