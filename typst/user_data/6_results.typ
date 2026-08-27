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
    columns: (2fr, 2fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (center),

    table.header(
      [*Modell*],
      [*Aufgaben*],
      table.cell(colspan: 3)[*Erfolgsrate*],
      table.cell(colspan: 3)[*Laufzeit [s]*],
      table.cell(colspan: 3)[*Gesamttoken*]
      ),

    table.cell(colspan: 2)[*Methode:*], [*D*], [*P*],[*I*],[*D*],[*P*],[*I*],[*D*],[*P*],[*I*], 

    [qwen3:8b], [einfach], [0,8], [0,8], [0,8], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:8b], [mehrstufig], [0,8], [0,8], [0,8], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:8b], [komplex], [0,8], [0,8], [0,8], [0,27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:8b], [ungedeckt], [-], [0,8], [0,8], [-], [27,5], [27,5], [-], [5000], [5000],

    [qwen3:14b], [einfach], [0,8], [0,8], [0,8], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:14b], [mehrstufig], [0,8], [0,8], [0,8], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:14b], [komplex], [0,8], [0,8], [0,8], [0,27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:14b], [ungedeckt], [-], [0,8], [0,8], [-], [27,5], [27,5], [-], [5000], [5000],

    [qwen3:30b], [einfach], [0,8], [0,8], [0,8], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:30b], [mehrstufig], [0,8], [0,8], [0,8], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:30b], [komplex], [0,8], [0,8], [0,8], [0,27,5], [27,5], [27,5], [5000], [5000], [5000],
    [qwen3:30b], [ungedeckt], [-], [0,8], [0,8], [-], [27,5], [27,5], [-], [5000], [5000],

  ),
  caption: [Evaluation],
) <tab:evaluation>

=== Auswertung API Modelle

- Laufzeit nicht vergleichbar? - anders und nicht kontrollierbar!

// This section presents a comprehensive overview of measurements, data tables, and performance evaluations, encompassing factors such as accuracy and speed.
// This section is also where you evaluate your prototype or framework:
// What is the users' verdict?
// What worked and what didn't?

// In cases where an abundance of results is available, it is advisable to place the detailed data in a separate appendix chapter at the end of your document.
// Here, in the main text, include only the pertinent excerpts or noteworthy examples, directing readers to the comprehensive data compilation provided in the appendix.

// Note that this section is often merged with the Discussion part; if kept separate, the interpretation of your results happens below.
