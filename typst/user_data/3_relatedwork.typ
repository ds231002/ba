#import "../globals.typ": *

#context if text.lang == "de" [
    = Stand der Forschung (7-10 Seiten)
    <sec:relatedwork>
] else [
    = Related Work
    <sec:relatedwork>
]

== Tooldesign

Was ist Tool Use / Function Calling?
Wie werden Tools beschrieben und bereitgestellt?
Toolauswahl
Parameter-/Argumentgenerierung
strukturierte Tooldefinitionen
Toolergebnisse
gegebenenfalls besondere Anforderungen deiner Zeitreihendaten
relevante Arbeiten wie Toolformer
Während ein einzelner Tool-Aufruf vergleichsweise einfach ist, entstehen bei Aufgaben, die mehrere Werkzeuge erfordern, zusätzliche Anforderungen ... -> Übergang zu Orchestrierung

Tool-Use Ansätze
@paranjapeARTAutomaticMultistep2023
@yangGPT4ToolsTeachingLarge2023
@alazrakiMetaReasoningImprovesTool2025

Tool Auswahl
@huangMetaToolBenchmarkLarge2024
@liuWTUEVALWhetherorNotTool2025

=== Zeitreihendaten

Zeitreihendaten stellen besondere Anforderungen an die Interaktion zwischen LLM und Werkzeugen. Während Energiedaten häufig aus mehreren hundert bis tausend Messwerten bestehen, sind Large Language Models primär für die Verarbeitung natürlicher Sprache optimiert. Die direkte Übergabe vollständiger Zeitreihen als JSON oder Array erhöht den Tokenverbrauch erheblich und erschwert gleichzeitig die Identifikation relevanter Muster innerhalb langer Zahlenfolgen.

Grundsätzlich bestehen zwei Möglichkeiten, Zeitreihendaten für ein LLM bereitzustellen. Der erste Ansatz besteht darin, die Rohdaten direkt als strukturierte Werte zu übergeben und die Interpretation vollständig dem Sprachmodell zu überlassen. Alternativ können Zeitreihen vor der Übergabe aufbereitet werden, beispielsweise durch externe Analysewerkzeuge oder durch eine visuelle Darstellung in Form von Diagrammen. In der Literatur konnte bereits gezeigt werden, dass insbesondere Visualisierungen die Verarbeitung von Zeitreihen durch LLMs verbessern und gleichzeitig den Tokenverbrauch deutlich reduzieren können @liuPictureWorthThousand.

Zur Bewertung dieser Ansätze wurde eine Voruntersuchung im Kontext synthetischer Energiedaten durchgeführt. Hierbei wurden Zeitreihen unterschiedlicher Länge sowohl als strukturierte JSON-Daten als auch als Liniendiagramme an das Modell übergeben und hinsichtlich Antwortqualität, Tokenverbrauch und Bearbeitungszeit verglichen. Zusätzlich wurde untersucht, inwieweit mehrere Zeitreihen gleichzeitig verarbeitet werden können.

Die Ergebnisse zeigten, dass beide Darstellungsformen eine korrekte Interpretation einfacher Verbrauchsmuster ermöglichen. Mit zunehmender Länge der Zeitreihen erwiesen sich Visualisierungen jedoch als deutlich effizienter hinsichtlich Tokenverbrauch und Verarbeitungszeit. Gleichzeitig zeigte sich, dass die eigentliche Mustererkennung nicht zwangsläufig durch das LLM erfolgen muss. Wiederkehrende Analysen, wie beispielsweise die Erkennung von Lastspitzen oder die Berechnung statistischer Kennwerte, können konsistenter und ressourcenschonender durch spezialisierte Analysewerkzeuge durchgeführt werden.

== Orchestrierung

Was bedeutet Orchestrierung?
Warum ist sie bei mehreren Tools notwendig?
Tool Chains
Reihenfolge von Tool-Aufrufen
Abhängigkeiten und Zwischenresultate
State / Artefakte
Planung
iterative Ausführung
Re-Planning
unterschiedliche Grade der Entscheidungsfreiheit
existierende Orchestrierungsansätze

== Evaluation

Was wird bei Tool-Use-Systemen gemessen?
Task Success
Tool Selection
Parameter Correctness
Multi-Step Success
Effizienz
Umgang mit Fehlern
State/Dependency Correctness
bestehende Benchmarks und Evaluationsansätze

== Zwischenfazit
...



// #ref(<sec:relatedwork>) contains the publications related to your work.

// This section demonstrates the extensive effort dedicated to researching whether prior attempts have addressed similar problems or scenarios.
// Here, we document the state of the art as it was known at the time of writing, thereby highlighting the distinctiveness of our work in the subsequent chapters.

// Our exploration covers various aspects:

// - *Distinguishing Factors*:
//     We elucidate how our work diverges from the existing body of published works.
//     What sets our scenario apart?
//     Are our goals or assumptions different?
//     Does our practical testing or prototype implementation offer a unique perspective?
//     Could advancements in computational power, compared to what was affordable a decade ago, enable the resolution of specific problems?
    
// - *Placement in Your Document*:
//     The placement of the Related Work chapter depends on the nature and complexity of your work.
//     It can be positioned near the beginning, possibly integrated with the background section, providing readers with essential context to understand your specific scenario.
//     Alternatively, it can be placed at the end, following your work and results but preceding the conclusion.
//     In this latter arrangement, readers gain a comprehensive understanding of your work before delving into the discussion of differences with existing works.
    
// - *Grouping and Categorization*:
//     When your literature search yields numerous related works, consider grouping them into subcategories.
//     It's important to remember that most of these references are likely to be entirely new to your readers, making categorization even more valuable.

// #ref(<tab:passes_paperreading>) depicts how to read computer science papers as part of a multi-stage process.

// #figure(
//     table(
//         columns: 2,
//         align: (right+horizon, left),
//         [*Pass*], [*Content to Read*],
//         table.cell(rowspan:4)[1], [Title, abstract, introduction],
//            [Section and subsection headers],
//            [Conclusion],
//            [References],
//         [2], [Content, omitting details (proofs, etc.)],
//         [3], [Detailed content (re-implementing the paper)],
//     ),
//     caption: [Reading Passes and their Corresponding Content for Research Papers.]
// )<tab:passes_paperreading>

// As a citation example, the famous halting problem~#cite(<turing_halting_prob>) introduced by #cite(form:"author", <turing_halting_prob>) is cited here.
// The corresponding BibTeX entry can be found in #ref(<lst:bibtex>).

// #figure(
//     ```bibtex
//     @article{turing_halting_prob,
//         author = {Turing, Alan Mathison},
//         title = {On Computable Numbers, with an Application to the Entscheidungsproblem},
//         year = {1937},
//         doi = {10.1112/plms/s2-42.1.230},
//         journal = {Proceedings of the London Mathematical Society},
//         volume = {s2-42},
//         number = {1},
//         publisher = {Oxford University Press},
//         issn = {1460-244X},
//         pages = {230--265},
//     }
//     ```,
//     caption: [BibTeX Entry for Turing's Halting Problem.]
// )<lst:bibtex>


