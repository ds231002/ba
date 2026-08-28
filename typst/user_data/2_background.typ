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


== 2.1 Large Language Models

- LLMs erzeugen ihre Ausgaben tokenweise und sind daher nicht mit deterministischen Programmlogiken gleichzusetzen.
- Ein LLM kann strukturierte Ausgaben erzeugen, beispielsweise JSON-basierte Tool Calls, benötigt dafür aber eine entsprechende Promptstruktur.
- Die Fähigkeit, ein Tool korrekt auszuwählen, bedeutet nicht automatisch, dass das Modell auch einen mehrstufigen Prozess zuverlässig steuern kann.
- Größere Modelle scheinen in den Experimenten besser mit komplexeren, mehrstufigen Entscheidungsprozessen umgehen zu können.
- Besonders relevant ist die Fähigkeit des Modells, Informationen aus vorherigen Verarbeitungsschritten in nachfolgenden Entscheidungen zu berücksichtigen.
- Bei lokalen Modellen zeigen sich deutliche Unterschiede zwischen den Modellgrößen.
- Qwen3:8B kann einfache Aufgaben bzw. einzelne Planungsschritte grundsätzlich bewältigen.
- Qwen3:30B zeigt beim iterativen Vorgehen ein deutlich robusteres Verständnis des grundsätzlichen Ablaufs.
- Modellgröße kann nicht nur die Qualität der sprachlichen Antwort beeinflussen, sondern auch die Fähigkeit zur Steuerung eines Tool-gestützten Workflows.


== 2.2 Tool Calling

- Die Tools werden mit ihren Funktionen und Argumenten beschrieben.
- Die Tool-Beschreibungen sind für das Modell grundsätzlich ausreichend, um zumindest im einfachen Planungsfall passende Tools auszuwählen.
- Bei der plan-basierten Methode konnte das Modell aus Aufgabe und Tooldefinitionen einen plausiblen Plan erzeugen.
- Damit scheint die reine Tool Selection bei einfachen Aufgaben nicht das zentrale Problem zu sein.
- Die Schwierigkeiten treten stärker auf, sobald bereits ausgeführte Tools und deren Ergebnisse in den Entscheidungsprozess einbezogen werden.
- Das erfolgreiche Erzeugen eines einzelnen Tool Calls bedeutet nicht automatisch, dass ein Modell einen mehrstufigen Tool-Calling-Prozess zuverlässig steuern kann.


== 2.3 Agenten / Multi-Agent-Systeme

- Beim plan-basierten Ansatz erstellt das LLM zunächst einen vollständigen Plan, der anschließend durch das System abgearbeitet werden kann.
- Beim iterativen Ansatz entscheidet das LLM schrittweise und erhält nach jeder Tool-Ausführung neue Informationen.
- Der iterative Ansatz stellt damit höhere Anforderungen an das LLM.
- Das Modell muss den bisherigen Zustand erfassen.
- Das Modell muss vorhandene Ergebnisse berücksichtigen.
- Das Modell muss fehlende Informationen erkennen.
- Das Modell muss weitere Tools auswählen.
- Das Modell muss bereits erledigte Schritte erkennen und nicht unnötig wiederholen.
- Das Modell muss erkennen, wann die Aufgabe abgeschlossen ist.

// planed references old:
// @paranjapeARTAutomaticMultistep2023
// @yangGPT4ToolsTeachingLarge2023
// @alazrakiMetaReasoningImprovesTool2025
// @duanMultitoolIntegrationApplication2024
// @chenFortifyShortestStave2024