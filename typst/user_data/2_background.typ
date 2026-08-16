#import "../globals.typ": *

#context if text.lang == "de" [
    = Grundlagen
    <sec:background>
] else [
    = Prerequisites
    <sec:background>
]

// 4-5 Seiten

// LLMs
// Autonomie @fengLevelsAutonomyAI2025
// Tokens
// Autoregressive Generierung
// Kontextfenster
// Orchestrierung
// API?

== Large Language Models

// - Was ist ein LLM?
// - Transformer als zugrunde liegende Architektur
// - Tokenisierung
// - autoregressive Generierung
// - Kontextfenster

// Moderne Large Language Models basieren überwiegend auf der Transformer-Architektur, die durch den Self-Attention-Mechanismus die Verarbeitung von Beziehungen zwischen Tokens innerhalb des Kontextes ermöglicht.

*Inferenz* // Inferenzzeit ebenfalls beschreiben? - Laufzeit vs Inferenzzeit

Inferenz bedeutet im Zusammenhang mit KI, dass ein bereits trainiertes Modell der künstlichen Intelligenz neue, unbekannte Daten verarbeitet. Es nutzt das während der Lernphase angeeignete Wissen, um eigenständig Vorhersagen, Entscheidungen oder Antworten zu erzeugen @WasIstKIInferenz.

== Tool Calling

Large Language Models können durch die Anbindung externer Werkzeuge auf Informationen und Funktionen zugreifen, die nicht allein durch das im Modell enthaltene Wissen bereitgestellt werden können. Werkzeuge können dabei beispielsweise den Zugriff auf externe Datenquellen, Softwarefunktionen oder andere digitale Systeme ermöglichen. Damit ein Sprachmodell ein Werkzeug verwenden kann, wird dieses über eine strukturierte Beschreibung bereitgestellt. Eine solche Beschreibung umfasst beispielsweise einen eindeutigen Namen, eine Beschreibung der Funktion, Einschränkungen sowie die erwartete Struktur der Eingabeparameter und des Rückgabeformats. Auf Grundlage dieser Beschreibung kann das Modell ein geeignetes Werkzeug auswählen und ein entsprechendes Argumentobjekt für dessen Aufruf erzeugen @xuEvolutionToolUse2026.

Der erzeugte Tool-Aufruf wird anschließend von einer ausführenden Umgebung verarbeitet. Die Ausführung eines Werkzeugs erzeugt dabei ein Ergebnis beziehungsweise eine Rückmeldung, beispielsweise in Form von Text, strukturierten Daten oder einem Fehlercode. Dieses Ergebnis kann dem Sprachmodell anschließend wieder als Beobachtung zur Verfügung gestellt werden und damit als Grundlage für die weitere Verarbeitung dienen @xuEvolutionToolUse2026.

== Agenten / Multi-Agent-Systeme

- falls für deine Arbeit erforderlich




// planed references old:
// @paranjapeARTAutomaticMultistep2023
// @yangGPT4ToolsTeachingLarge2023
// @alazrakiMetaReasoningImprovesTool2025
// @duanMultitoolIntegrationApplication2024
// @chenFortifyShortestStave2024