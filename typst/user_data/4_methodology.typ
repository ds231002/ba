#import "../globals.typ": *

#context if text.lang == "de" [
    = Methodik
    <sec:methodology>
] else [
    = Methodology
    <sec:methodology>
]

- 4-6 Seiten

== Literaturrecherche

Anfangs wurde eine strukturierte Literaturrecherche durchgeführt. Hierfür wurden die Datenbanken Google Scholar und IEEE verwendet. Als Suchbegriffe wurden verschiedene Konstelationen von "large language model", "Large language models", "tool", "tools" und "use" verwendet. Es wurde jeweils nach Ergebnissen nach 2022 gefiltert.

In Google Scholar wurde am 05.03.2026 mit fogledem Suchbegriff gesucht: "allintitle: (tool OR tools) use ("large language model" OR "large language models")" und ergab 64 Treffer.

In IEEE wurde am 10.03.2026 mit folgendem Suchbegriff gesucht: "("Document Title":large language model) AND ("Document Title":tool) AND ("All Metadata":use)" und ergab 37 Treffer.

Nach einem groben Überblick über Titel und Zusammenfassungen und anschließender detaillierten Prüfung der Inhalte wurden 17 Puplikationen ausgewählt, die sich direkt mit Tool Use, Tool Selection oder Orchestrierung von Large Language Models beschäftigen.

= Notiz

== Zeitauflösung (Methodik, Herangehensweise, Ergebnisse)

Anfragen können zeitliche Angaben wie "gestern", "letzte Woche" oder "vorletztes Monat" enthalten. Auch komplexere Angaben wie "Wie ist mein Verbrauch der ersten 3 Tage der Woche vor dem 10. Januar?" sind möglich. Diese müssen richtig interpretiert und entsprechend in Parameter aufgelöst werden, um einen korrekten Toolaufruf zu ermöglichen. 
Daher ist zu beachten, wie die Parameter übergeben werden müssen. Ein Datum wird automatisch auf 0 Uhr des selben Tages gesetzt. Das bedeutet das Ende der Zeitreihe ist exkludiert, also nicht enthalten. Wenn man nun die Zeitreihe eines Tages abfragen möchte ist es notwendig den darauffolgenden Tag als Ende anzugeben oder die Funktion anzupassen, dass sie beim Ende automatisch einen Tag dazurechnet.

Daher war die Idee dem LLM auch Tools für die Zeitauflösung zur Verfügung zu stellen, um die Parameterauswahl besser zu steuern und weniger fehleranfällig zu machen. Zuvor wurde erst getestet wie gut aktuelle Modelle Zeitangaben selbstständig auflösen können. Getestet wurden gpt-5.4 und gpt-5.4-mini. Ohne Erklärung waren die Toolaufrufe nicht immer korrekt. Speziell ob das Ende der Zeitreihe exklusiv oder inklusiv war konnte das LLM nicht wissen. Mit entsprechenden Instruktionen war die Zeitauflösung aber sehr zuverlässig. Auch kompliziertere Beispiele wie zuvor genannt wurden problemlos aufgelöst. Bei zweideutigen Angaben wird teilweise nachgefragt oder eine der beiden Varianten angenommen und ausgeführt. Das lässt sich aber gut mit Promptentgineering steuern. Da die Zeitauflösung nur mit den LLMs sowohl bei einfachen als auch komplexen Zeitabfragen sehr zuverlässig funktionierte habe ich mich dagegen entschieden extra Tools zu entwickeln zumal ich damit ohnehin nicht jede erdenkliche Kombination abgedeckt hätte.

Anfangs hatte ich die Testdaten bei jeder Nutzung neu erstellt. Die Daten waren immer die gleichen, aber immer von heute ausgehend zum Beispiel die letzten 3 Monate. So sollte das LLM immer mit den gleichen Daten ausgehend vom heutigen Tag arbeiten. Das Problem war nur, dass "letzte Woche" immer etwas anderes bedeutete je nachdem welcher Wochentag gerade war und die Ergebnisse von Tests an verschiedenen Wochentagen nicht sauber vergleichbar und reproduzierbar waren. Die sauberere Lösung war es einen fixen Testdatensatz für einen bestimmten Zeitraum zu generieren der sich nicht mehr verändert und die Referenzzeit für das LLM vorzugeben und zu fixieren. Das bedeutet ich gebe dem LLM in den Systeminformationen ein fixes Datum innerhalb dieses Zeitraums an von dem es ausgehen sollte, dass dieses heute ist. Das wollte ich anfangs vermeiden, weil unklar war wie zuverlässig das ist und ob dadurch neue Komplikationen in der Zeitauflösung auftreten die nicht praxisnah sind. Die Bedenken sind, dass das LLM über die API ebenfalls weiß welcher Tag heute wirklich ist und bei viel Kontext möglicherweise die vorgegebene Referenzzeit untergehen könnte. Aber in den Tests ist auch dieser Fall nicht eingetreten und alle Berechnungen gingen zuverlässig von der vorgegebenen Referenzzeit aus.

Zusammengefasst habe ich mich gegen extra Tools für die Zeitauflösung entschieden. Die Testdaten wurden einmal für einen fixen Zeitraum generiert und dem LLM eine fixe Referenzzeit vorgegeben. So ist gewährleistet, dass der Testdatensatz nachvollziebar und konsistent bleibt und das Vorgehen sauber und reproduzierbar ist.

== Zeitauflösung (Methodik)

Anfragen können relative Zeitangaben wie „gestern“, „letzte Woche“ oder „vorletztes Monat“ sowie komplexere Formulierungen enthalten. Diese müssen in konkrete Zeitintervalle überführt werden, um korrekte Toolaufrufe zu ermöglichen.

Zeitintervalle werden im System im Format [start, end) definiert, wobei der Startzeitpunkt inkludiert und der Endzeitpunkt exkludiert ist. Ein Datum wird dabei automatisch auf 00:00 Uhr gesetzt. Soll ein einzelner Tag abgefragt werden, muss daher als Endzeitpunkt der darauffolgende Tag verwendet werden.

Für die Experimente wird ein fixer Testdatensatz für einen definierten Zeitraum verwendet. Um konsistente und reproduzierbare Ergebnisse zu gewährleisten, wird dem LLM eine feste Referenzzeit vorgegeben, die als „heutiges Datum“ interpretiert werden soll. Alle relativen Zeitangaben beziehen sich auf diese Referenzzeit.

Durch diese Festlegung wird sichergestellt, dass identische Anfragen unabhängig vom tatsächlichen Ausführungszeitpunkt stets zu denselben Zeitintervallen führen.

== Zeitfauflösung (Herangehensweise)

Zunächst wurde untersucht, inwieweit aktuelle LLMs relative Zeitangaben selbstständig auflösen können. Dabei zeigte sich, dass mit geeigneten Instruktionen sowohl einfache als auch komplexe Zeitangaben zuverlässig in konkrete Zeitintervalle überführt werden können.

Auf Basis dieser Ergebnisse wurde auf die Implementierung eines separaten Tools zur Zeitauflösung verzichtet, um die Systemkomplexität zu reduzieren.


== Testdaten

=== Energiedaten
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

== Warum vergleichender Ansatz
== Orchestrierungsstrategien
== Bewertungskrieterien


// Typically, the methodology section addresses the "what" and "how" questions.
// It delineates the overarching approach you've taken, whether it involves experimental research, a comprehensive literature survey, a quantitative study, or another methodology altogether.

// Furthermore, it specifies the necessary data type and volume, elucidating the methods employed for data extraction and collection.
// Additionally, it outlines the evaluative processes, which might encompass experiment design, questionnaire development, and similar components.

// In many cases, the Methodology links hypotheses to specific experiments outlined here.
// Note that the implementation details are not part of the methodolology; we simply explain the rationale and high-level approach.
