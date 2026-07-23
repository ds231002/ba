#import "../globals.typ": *

#context if text.lang == "de" [
    = Methodik (4-6 Seiten)
    <sec:methodology>
] else [
    = Methodology
    <sec:methodology>
]

== Forschungsdesign

- vergleichende Studie
- kontrollierte Experimente
- gleiche Testbedingungen
- synthetische Daten
- Fokus auf Reproduzierbarkeit

Sämtliche Voruntersuchungen sowie die anschließende Evaluation wurden mit den Modellen GPT-5.4 und GPT-5.4-mini durchgeführt. Sofern nicht anders angegeben, beziehen sich alle im Folgenden beschriebenen Beobachtungen und Designentscheidungen auf diese Modelle.

== Literaturrecherche

Anfangs wurde eine strukturierte Literaturrecherche durchgeführt. Hierfür wurden die Datenbanken Google Scholar und IEEE verwendet. Als Suchbegriffe wurden verschiedene Konstelationen von "large language model", "Large language models", "tool", "tools" und "use" verwendet. Es wurde jeweils nach Ergebnissen nach 2022 gefiltert. In Google Scholar wurde am 05.03.2026 mit fogledem Suchbegriff gesucht: "allintitle: (tool OR tools) use ("large language model" OR "large language models")" und ergab 64 Treffer. In IEEE wurde am 10.03.2026 mit folgendem Suchbegriff gesucht: "("Document Title":large language model) AND ("Document Title":tool) AND ("All Metadata":use)" und ergab 37 Treffer. Nach einem groben Überblick über Titel und Zusammenfassungen und anschließender detaillierten Prüfung der Inhalte wurden 17 Puplikationen ausgewählt, die sich direkt mit Tool Use, Tool Selection oder Orchestrierung von Large Language Models beschäftigen. Diese dienten als Grundlage für die Recherche. == Tooldesign - tools gpt api nicht genommen um Vergleichbarkeit mit anderen Modellen zu gewährleisten (Architektur wäre unklar, nicht nur gpt testen sondern Strategie)
*Zielsetzung*
*Werkzeuge*
*Parameter*

=== Zeitauflösung

Zeitangaben in Benutzeranfragen müssen vor einem Toolaufruf eindeutig in konkrete Zeitintervalle überführt werden. Da Anfragen sowohl relative als auch komplex formulierte Zeitangaben enthalten können und sich diese auf unterschiedliche zeitliche Granularitäten beispielsweise Tage oder Stunden beziehen, stellt die zuverlässige Parametrisierung der Werkzeuge eine grundlegende Voraussetzung für eine reproduzierbare Evaluation dar.

Im System werden Zeitintervalle durch einen Start- und Endzeitpunkt im Format [start, end) beschrieben, wobei der Startzeitpunkt inkludiert und der Endzeitpunkt exkludiert ist. Ein einzelner Kalendertag wird daher durch den Beginn dieses Tages sowie den Beginn des Folgetages beschrieben.

Für die Zeitauflösung wurden zwei Ansätze betrachtet: die Verwendung eines dedizierten Werkzeugs zur Interpretation natürlicher Zeitangaben sowie die direkte Parametrisierung durch das LLM. Zur Bewertung beider Ansätze wurde eine Voruntersuchung mit aktuellen Sprachmodellen durchgeführt. Hierbei wurden repräsentative Anfragen mit relativen und komplexen Zeitangaben formuliert und die erzeugten Toolparameter analysiert.

Die Untersuchung zeigte, dass aktuelle Modelle mit geeigneten Instruktionen Zeitangaben zuverlässig in korrekte Zeitintervalle überführen können. Auf die Implementierung eines separaten Zeitauflösungswerkzeugs wurde daher verzichtet, wodurch die Komplexität der Werkzeuglandschaft reduziert werden konnte.
 
=== Bereitstellung und Interpretation von Zeitreihendaten

Zeitreihendaten stellen besondere Anforderungen an die Interaktion zwischen LLM und Werkzeugen. Während Energiedaten häufig aus mehreren hundert bis tausend Messwerten bestehen, sind Large Language Models primär für die Verarbeitung natürlicher Sprache optimiert. Die direkte Übergabe vollständiger Zeitreihen als JSON oder Array erhöht den Tokenverbrauch erheblich und erschwert gleichzeitig die Identifikation relevanter Muster innerhalb langer Zahlenfolgen.

Grundsätzlich bestehen zwei Möglichkeiten, Zeitreihendaten für ein LLM bereitzustellen. Der erste Ansatz besteht darin, die Rohdaten direkt als strukturierte Werte zu übergeben und die Interpretation vollständig dem Sprachmodell zu überlassen. Alternativ können Zeitreihen vor der Übergabe aufbereitet werden, beispielsweise durch externe Analysewerkzeuge oder durch eine visuelle Darstellung in Form von Diagrammen. In der Literatur konnte bereits gezeigt werden, dass insbesondere Visualisierungen die Verarbeitung von Zeitreihen durch LLMs verbessern und gleichzeitig den Tokenverbrauch deutlich reduzieren können. 

Zur Bewertung dieser Ansätze wurde eine Voruntersuchung im Kontext synthetischer Energiedaten durchgeführt. Hierbei wurden Zeitreihen unterschiedlicher Länge sowohl als strukturierte JSON-Daten als auch als Liniendiagramme an das Modell übergeben und hinsichtlich Antwortqualität, Tokenverbrauch und Bearbeitungszeit verglichen. Zusätzlich wurde untersucht, inwieweit mehrere Zeitreihen gleichzeitig verarbeitet werden können.

Die Ergebnisse zeigten, dass beide Darstellungsformen eine korrekte Interpretation einfacher Verbrauchsmuster ermöglichen. Mit zunehmender Länge der Zeitreihen erwiesen sich Visualisierungen jedoch als deutlich effizienter hinsichtlich Tokenverbrauch und Verarbeitungszeit. Gleichzeitig zeigte sich, dass die eigentliche Mustererkennung nicht zwangsläufig durch das LLM erfolgen muss. Wiederkehrende Analysen, wie beispielsweise die Erkennung von Lastspitzen oder die Berechnung statistischer Kennwerte, können konsistenter und ressourcenschonender durch spezialisierte Analysewerkzeuge durchgeführt werden.

Auf Basis dieser Erkenntnisse wurde das Tooldesign so gewählt, dass das LLM Zeitreihen nicht grundsätzlich selbst interpretieren muss. Stattdessen stellen Werkzeuge je nach Anwendungsfall entweder aufbereitete Visualisierungen oder bereits analysierte Informationen bereit. Das LLM übernimmt damit primär die Orchestrierung sowie die sprachliche Interpretation der Ergebnisse, während rechenintensive oder wiederkehrende Zeitreihenanalysen an spezialisierte Werkzeuge ausgelagert werden.

== Testdaten

=== Szenarien

=== Datengenerierung

- ausgehend von einer Energiegemeinschaft
- Testdaten: 01.01.2026 - 31.03.2026 (inklusive)
- Referencetime: 02.04.2026

// *users.csv*
// - user_id
// - note (beschreibung für mich und nicht fürs llm)

*meters.csv*
- meter_id
- meter_name (meist nur bei vielen Zählpunkten vorhanden)
- user_id
- direction
- location
- note

*timeseries.csv* (15min)
- meter_id
- timestamp
- value
- unit

*forecast.csv* (1h)
- timestamp
- generation
- consumption

*spotmarket.csv* (1h)
- timestamp
- value (kann auch negativ sein)

*Characteristics*
- normal: actual bis gestern 0 Uhr danach forecast
- missing values: forecast über längeren Zeitraum (llm soll auf prognostizierte Werte aufmerksam machen)
- missing values: auch kein forecast
- missing values: vereinzelte actuals (llm soll auf fehlende Werte aufmerksam machen)

=== Referenzzeit

Es wurde die Verwendung dynamisch generierter Testdaten untersucht. Da relative Zeitangaben abhängig vom tatsächlichen Ausführungszeitpunkt unterschiedliche Ergebnisse liefern würden, wurde stattdessen ein fester Testdatensatz mit einer vollständig definierten Referenzzeit verwendet. Diese umfasst neben dem Datum auch die Uhrzeit sowie die zugehörige Zeitzone und wird vom LLM als aktueller Zeitpunkt interpretiert. Dadurch können neben tagesbasierten auch stundenbasierte Zeitangaben, beispielsweise „vor drei Stunden“ oder „seit heute Morgen“, eindeutig aufgelöst werden. Gleichzeitig wird sichergestellt, dass identische Anfragen unabhängig vom tatsächlichen Zeitpunkt der Versuchsdurchführung stets zu denselben Zeitintervallen und damit zu identischen Toolparametern führen.

Diese Entscheidungen stellen sicher, dass Unterschiede zwischen den Orchestrierungsmethoden nicht durch die Verarbeitung natürlicher Zeitangaben beeinflusst werden und die Evaluation reproduzierbar durchgeführt werden kann.

== Orchestrierungsstrategien
== Bewertungskrieterien

- Tool Selection Accuracy
- unnötige/redundante Toolaufrufe
- Schrittanzahl
- Antwortqualität
- Laufzeit
- Tokenverbrauch

== Versuchsablauf

- Eine Testanfrage wird ausgewählt.
- Eine Orchestrierungsmethode wird gestartet.
- Das LLM ruft Tools auf.
- Die Tool-Rückgaben werden verarbeitet.
- Die finale Antwort wird erzeugt.
- Die Bewertungskriterien werden berechnet.
- Der Vorgang wird für alle Methoden wiederholt.


// Typically, the methodology section addresses the "what" and "how" questions.
// It delineates the overarching approach you've taken, whether it involves experimental research, a comprehensive literature survey, a quantitative study, or another methodology altogether.

// Furthermore, it specifies the necessary data type and volume, elucidating the methods employed for data extraction and collection.
// Additionally, it outlines the evaluative processes, which might encompass experiment design, questionnaire development, and similar components.

// In many cases, the Methodology links hypotheses to specific experiments outlined here.
// Note that the implementation details are not part of the methodolology; we simply explain the rationale and high-level approach.
