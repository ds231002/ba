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

Für die Nutzung externer Werkzeuge durch ein Large Language Model müssen die verfügbaren Werkzeuge in einer für das Modell verständlichen und eindeutig interpretierbaren Form bereitgestellt werden. Dazu gehören insbesondere eine Beschreibung der verfügbaren Funktionen sowie die Definition der von ihnen erwarteten Eingaben. Bei einem Tool-Aufruf muss das Sprachmodell sowohl ein geeignetes Werkzeug auswählen als auch die dafür erforderlichen Argumente bestimmen. Toolformer beschreibt diese beiden Aspekte beispielsweise als Auswahl einer API und Erzeugung der zugehörigen Eingabe @schickToolformerLanguageModels2023.

Bei strukturierten Tool-Aufrufen werden diese Informationen in einer formalisierten Darstellung bereitgestellt. Das Sprachmodell erzeugt daraufhin einen strukturierten Aufruf, der von der umgebenden Anwendung verarbeitet und ausgeführt werden kann. Das Ergebnis des Werkzeugaufrufs kann anschließend wieder dem Sprachmodell zur weiteren Verarbeitung zur Verfügung gestellt werden.

== Agenten / Multi-Agent-Systeme

- falls für deine Arbeit erforderlich




// planed references old:
// @paranjapeARTAutomaticMultistep2023
// @yangGPT4ToolsTeachingLarge2023
// @alazrakiMetaReasoningImprovesTool2025
// @duanMultitoolIntegrationApplication2024
// @chenFortifyShortestStave2024