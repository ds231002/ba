#import "../globals.typ": *

#context if text.lang == "de" [
    = Fazit
    <sec:conclusion>
] else [
    = Conclusion
    <sec:conclusion>
]

- 2 Seiten

== Brainstorming

- Lokale LLMs eignen sich grundsätzlich für Tool-gestützte Datenabfragen.
- Ein plan-basierter Ansatz ist für kleinere Modelle offenbar leichter umzusetzen als eine iterative Orchestrierung.
- Der iterative Ansatz stellt höhere Anforderungen an das LLM, da neben der Tool-Auswahl auch Zustandsverarbeitung, Fortschrittskontrolle und Terminierung erforderlich sind.
- Die explizite Bereitstellung bereits verfügbarer Ergebnisse reicht nicht zwangsläufig aus, damit kleinere LLMs diese zuverlässig in nachfolgenden Entscheidungen verwenden.
- Größere Modelle scheinen den iterativen Zustand besser erfassen zu können.
- Größere Modelle lösen jedoch nicht automatisch Probleme mit redundanten Tool Calls und zuverlässiger Terminierung.
- Eine Kombination aus LLM-basierter Entscheidungsfindung und deterministischer Kontrolle durch den Orchestrator erscheint daher als vielversprechender Ansatz.
- Laufzeit, Timeout und Iterationsanzahl müssen bei der Bewertung lokaler LLMs berücksichtigt werden.
- Eine faire Evaluation benötigt mehrere Kriterien, insbesondere Korrektheit, Effizienz und Robustheit.

// Many readers of a lengthy text begin by perusing the introduction and conclusion to gauge their interest in delving further.

// Here, we offer a concise recapitulation of the entire content, emphasizing that no new material is introduced.

// When applicable, provide a brief glimpse into potential future endeavors, continuing from where your work concludes.
// In cases where the discussion of future possibilities is extensive or of particular significance, consider integrating it within the preceding Results or Discussion chapter.
