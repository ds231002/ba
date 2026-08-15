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

*Energiegemeinschaft* // copy from introduction

Energiegemeinschaften sind Zusammenschlüsse von Teilnehmenden die Privatpersonen, Gemeinden oder Unternehmen sein können. Diese verwalten gemeinsam die Produktion, Speicherung und Nutzung von Energie, um diese effizient zu nutzen @gmbhWasSindEnergiegemeinschaften, @energiegemeinschaftenRechtsgrundlagenFurEnergiegemeinschaften.
// In diesem Kontext können Anfragen darin bestehen Analysen von Energiedaten oder Prognosen zu erstellen oder bei Entscheidungsfragen zu unterstützen.

*Inferenz* // Inferenzzeit ebenfalls beschreiben? - Laufzeit vs Inferenzzeit

Inferenz bedeutet im Zusammenhang mit KI, dass ein bereits trainiertes Modell der künstlichen Intelligenz neue, unbekannte Daten verarbeitet. Es nutzt das während der Lernphase angeeignete Wissen, um eigenständig Vorhersagen, Entscheidungen oder Antworten zu erzeugen @WasIstKIInferenz.

*Tool Calling / Function Calling*

Das Modell erhält eine Menge definierter Tools.
Jedes Tool besitzt einen Namen und definierte Parameter.
Das Modell erzeugt strukturiert, welches Tool mit welchen Parametern aufgerufen werden soll.
Die eigentliche Funktion wird anschließend von der Anwendung ausgeführt.


// planed references old:
// @paranjapeARTAutomaticMultistep2023
// @yangGPT4ToolsTeachingLarge2023
// @alazrakiMetaReasoningImprovesTool2025
// @duanMultitoolIntegrationApplication2024
// @chenFortifyShortestStave2024


// This chapter serves as an essential foundation for comprehending the subsequent content of this work.

// Within these pages, we offer a concise yet comprehensive review of the knowledge essential to grasp the concepts presented in the following chapters.
// Every piece of information presented herein represents a distillation of existing knowledge from specific domains.
// For instance, we provide a detailed explanation of critical components, such as certain cryptographic algorithms pivotal to understanding our overarching approach in addressing the problem at hand.
// We do not, however, explain the basics that our hypothetical readers (junior #gls("it") students) are assumed to know:
// In our example, we will not reiterate at length what cryptography actually is.

// Our focus in this chapter is laser-sharp, strictly adhering to topics that are either prerequisites or directly relevant to the forthcoming chapters.
// We refrain from duplicating content verbatim from other sources.

// It's important to acknowledge that expertise in all the subjects touched upon by your work is a rarity.
// Thus, this background section serves as a guide for readers to pinpoint their knowledge gaps.
// Should they wish to delve deeper into any particular area, we provide references that enable them to expand their understanding before delving further into our work.
// For those readers already familiar with the required background knowledge, this chapter serves as a reassuring affirmation of their readiness to engage with the subsequent content.
