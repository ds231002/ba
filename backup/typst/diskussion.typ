- wann welche Strategie sinnvoll ist
- Auswirkungen auf Energiegemeinschaften
- Limitationen

== Brainstorming

- Die Ergebnisse deuten darauf hin, dass die Erstellung eines statischen Plans für das LLM einfacher ist als die iterative Steuerung eines Tool-gestützten Prozesses.
- Im plan-basierten Ansatz muss das Modell primär geeignete Tools auswählen und deren Verwendung planen.
- Im iterativen Ansatz muss das Modell zusätzlich den aktuellen Zustand des Prozesses berücksichtigen.
- `available_results` enthält formal die Informationen über bereits ausgeführte Tools, deren Argumente und deren Ergebnisse.
- Die explizite Bereitstellung dieser Informationen garantiert jedoch nicht, dass das LLM sie zuverlässig für die nächste Entscheidung nutzt.
- Tool Selection und State Tracking stellen damit unterschiedliche Anforderungen an das Modell dar.
- Ein Modell kann ein geeignetes Tool auswählen, ohne zuverlässig zu erkennen, dass dieses Tool bereits ausgeführt wurde.
- Die wiederholten Tool Calls des Qwen3:30B zeigen, dass das grundsätzliche Verständnis des iterativen Systems nicht automatisch zu einer effizienten Steuerung führt.
- Neben der Tool Selection stellt insbesondere die Fortschrittskontrolle eine Herausforderung dar.
- Das LLM muss erkennen, ob ein weiterer Tool Call tatsächlich neue Informationen liefert.
- Die Entscheidung, wann `generate_answer` aufgerufen werden soll, stellt eine eigene Herausforderung der iterativen Orchestrierung dar.
- Die bisherigen Beobachtungen deuten auf einen Einfluss der Modellgröße auf die Fähigkeit zur Steuerung iterativer Tool-Calling-Prozesse hin.
- Das größere Modell zeigt ein robusteres Verständnis des iterativen Zustands, löst jedoch Probleme wie redundante Tool Calls nicht vollständig.
- Modellgröße allein scheint daher nicht ausreichend zu sein, um eine robuste iterative Orchestrierung sicherzustellen.
- Deterministische Mechanismen des Orchestrators könnten bestimmte Fehlerklassen zuverlässiger verhindern als das LLM selbst.
- Dazu gehören beispielsweise die Erkennung identischer Tool Calls, Iterationslimits und Timeouts.
- Daraus ergibt sich die Möglichkeit eines hybriden Ansatzes, bei dem das LLM semantische Entscheidungen trifft und der Python-Orchestrator deterministische Kontrollaufgaben übernimmt.
- Die Beobachtungen sollten jedoch erst nach einer systematischen Evaluation als allgemeingültige Aussagen über Modellgrößen interpretiert werden.

// aus relatedwork - iterative Methode funktionierte deutlich unzuverlässiger als Einmalaufrufe wie plan-based und deterministic
- Die Ergebnisse von OrchDAG verdeutlichen zudem, warum eine getrennte Betrachtung verschiedener Bewertungsebenen sinnvoll ist. In den Experimenten erzielen Modelle teilweise eine deutlich höhere Accuracy/step als Accuracy/user_query. Die Autoren interpretieren dies dahingehend, dass Modelle einzelne Schritte korrekt ausführen können, gleichzeitig aber Schwierigkeiten haben, eine konsistente Gesamtstruktur der Tool-Ausführung aufrechtzuerhalten @luOrchDAGComplexTool2025.