#import "../globals.typ": *

#context if text.lang == "de" [
    = Ergebnisse
    <sec:results>
] else [
    = Results
    <sec:results>
]

// 4-6 Seite

Richtige Tools gewählt - ja/nein
optimal (keine unnötigen Tools) - ja/nein
Parameter (automatisch nein wenn fasche Tools) - ja/nein
Antwrot (richtige Results oder Info übergeben) - ja/nein


== Auswertung lokaler Modelle

#figure(
  table(
    columns: (1.5fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center),

    table.header([*Aufgabentyp*], [*Methode 1*], [*Methode 2*], [*Methode 3*]),

    table.cell(colspan: 4)[*Durchschnittliche Laufzeit \[s\]*],

    [Einfach], [], [], [],
    [Mehrschrittig], [], [], [],
    [Komplex], [], [], [],
    [Atypisch], [nicht unterstützt], [], [],

    table.cell(colspan: 4)[*Durchschnittlicher Tokenverbrauch \[Stk\]*],

    [Einfach], [], [], [],
    [Mehrschrittig], [], [], [],
    [Komplex], [], [], [],
    [Atypisch], [nicht unterstützt], [], [],

    table.cell(colspan: 4)[*Erfolgsrate / SucessRate*],

    [Einfach], [], [], [],
    [Mehrschrittig], [], [], [],
    [Komplex], [], [], [],
    [Atypisch], [nicht unterstützt], [], [],

      table.cell(colspan: 4)[*Tool Precision*],

    [Einfach], [], [], [],
    [Mehrschrittig], [], [], [],
    [Komplex], [], [], [],
    [Atypisch], [nicht unterstützt], [], [],

    table.cell(colspan: 4)[*Tool Recall*],

    [Einfach], [], [], [],
    [Mehrschrittig], [], [], [],
    [Komplex], [], [], [],
    [Atypisch], [nicht unterstützt], [], [],
  ),
  caption: [Evaluation - Modell 1],
) <tab:evaluation_modell_1>

=== Auswertung API Modelle

- Laufzeit nicht vergleichbar? - anders und nicht kontrollierbar!

// This section presents a comprehensive overview of measurements, data tables, and performance evaluations, encompassing factors such as accuracy and speed.
// This section is also where you evaluate your prototype or framework:
// What is the users' verdict?
// What worked and what didn't?

// In cases where an abundance of results is available, it is advisable to place the detailed data in a separate appendix chapter at the end of your document.
// Here, in the main text, include only the pertinent excerpts or noteworthy examples, directing readers to the comprehensive data compilation provided in the appendix.

// Note that this section is often merged with the Discussion part; if kept separate, the interpretation of your results happens below.
