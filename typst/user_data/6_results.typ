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
Antwort (richtige Results oder Info übergeben) - ja/nein

- korrekte Aufgabe = Toolaufrufe korrekt, Parameter korrekt, Antwort korrekt
- Erfolgsrate = korrekte Aufgaben/alle Aufgaben

#figure(
  table(
    columns: (2fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (center),

    table.header(
      [*Typ*],
      [*Aufgabe*],
      table.cell(colspan: 3)[*Tool korrekt*],
      table.cell(colspan: 3)[*Parameter korrekt*],
      table.cell(colspan: 3)[*Antwort korrekt*],
      table.cell(colspan: 3)[*Zeit [s]*],
      table.cell(colspan: 3)[*Gesamttoken*]
      ),

    table.cell(colspan: 2)[],
    [*D*], [*P*], [*I*],
    [*D*], [*P*], [*I*],
    [*D*], [*P*], [*I*],
    [*D*], [*P*], [*I*],
    [*D*], [*P*], [*I*],

    [einfach], [1], [✗], [✓], [✓], [✗], [✓], [✓], [✗], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],
    [einfach], [1], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [✓], [27,5], [27,5], [27,5], [5000], [5000], [5000],

  ),
  caption: [Beispielevaluation vom Modell 1. D=Deterministisch, P=Plan-Basiert, I=Iterativ],
) <tab:evaluation_example>

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

    table.cell(colspan: 2)[], [*D*], [*P*],[*I*],[*D*],[*P*],[*I*],[*D*],[*P*],[*I*], 

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
  caption: [Aggregierte Evaluation pro Modell und Aufgabentyp. D=Deterministisch, P=Plan-Basiert, I=Iterativ],
) <tab:evaluation>

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr ,1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (center),

    table.header(
      [*Aufgabentyp*],
      table.cell(colspan: 3)[*Erfolgsrate*],
      table.cell(colspan: 3)[*Effizienzrate*],
      table.cell(colspan: 3)[*Laufzeit [s]*],
      table.cell(colspan: 3)[*Gesamttoken*]
    ),

    [], [*D*], [*P*],[*I*],[*D*],[*P*],[*I*],[*D*],[*P*],[*I*], [*D*], [*P*], [*I*],

    table.cell(colspan: 13, fill: luma(240))[qwen3:4b],

    [einfach], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[27,5],[100,5], [27,5], [5000], [5000], [15000],
    [komlex], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[100,5],[100,5], [27,5], [5000], [5000], [15000],
    [ungedeckt], [-],[0,8],[0,8],[-],[0,8],[0,8],[-],[100,5], [27,5], [-], [5000], [15000],

    table.cell(colspan: 13, fill: luma(240))[qwen3:8b],

    [einfach], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[27,5],[100,5], [27,5], [5000], [5000], [15000],
    [komlex], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[100,5],[100,5], [27,5], [5000], [5000], [15000],
    [ungedeckt], [-],[0,8],[0,8],[-],[0,8],[0,8],[-],[100,5], [27,5], [-], [5000], [15000],

    table.cell(colspan: 13, fill: luma(240))[qwen3:14b],

    [einfach], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[27,5],[100,5], [27,5], [5000], [5000], [15000],
    [komlex], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[100,5],[100,5], [27,5], [5000], [5000], [15000],
    [ungedeckt], [-],[0,8],[0,8],[-],[0,8],[0,8],[-],[100,5], [27,5], [-], [5000], [15000],

    table.cell(colspan: 13, fill: luma(240))[qwen3:30b],

    [einfach], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[27,5],[100,5], [27,5], [5000], [5000], [15000],
    [komlex], [0,8],[0,8],[0,8],[0,8],[0,8],[0,8],[100,5],[100,5], [27,5], [5000], [5000], [15000],
    [ungedeckt], [-],[0,8],[0,8],[-],[0,8],[0,8],[-],[100,5], [27,5], [-], [5000], [15000],

  ),
  caption: [Aggregierte Evaluation pro Modell und Aufgabentyp. D=Deterministisch, P=Plan-Basiert, I=Iterativ],
) <tab:evaluation>

=== Auswertung API Modelle

- Laufzeit nicht vergleichbar? - anders und nicht kontrollierbar!

=== Brainstorming
- Die plan-basierte Methode ermöglicht bei der getesteten einfachen Aufgabe eine zuverlässige Erstellung eines plausiblen Plans.
- Qwen3:8B benötigt bei einem direkten Aufruf der getesteten Aufgabe ungefähr 15 Sekunden.
- Der erste Iterationsschritt der iterativen Methode funktioniert grundsätzlich.
- Die Schwierigkeiten treten insbesondere nach der Verarbeitung der ersten Tool-Ergebnisse auf.
- Bei Qwen3:8B können im iterativen Ansatz sehr lange LLM-Laufzeiten auftreten.
- Qwen3:30B zeigt ein besseres Verständnis der Struktur des iterativen Systems.
- Qwen3:30B führt jedoch teilweise bereits ausgeführte Tools erneut mit identischen Argumenten aus.
- Dadurch kann der iterative Prozess ohne Fortschritt weitere Iterationen durchführen.
- Die explizite Bereitstellung von `available_results` verhindert redundante Tool Calls nicht zuverlässig.
- Technische Fehler der Orchestrierung, beispielsweise fehlerhafte Python-Datenstrukturen, müssen von tatsächlichen LLM-Fehlern getrennt betrachtet werden.

- Iterationen werden oft nicht richtig aufgelöst.
- Zeiträume falsch erkannt
- Verfügbare Tools nicht richtig erkannt und wiederholt die selbe Aktion ausgeführte
- Bei der Menge an Informationen von Systeminformationen Kontext Strukturregeln usw scheinen schnell mal wichtige Informationen unterzugehen und das llm macht Dinge die ihm ausdrücklich verboten sind, zum Beispiel eine ID erfinden usw.
- Bei Iterativ wird die Wahrscheinlichkeit für Timeout aufgrund höherer Aufrufe und steigender Komplexität erhöht (Prüfen ob Ergebnisse zu dieser Hypothese passen)
- Offensichtlich falsche oder wiedersprüchliche Aufgaben werden relativ zuverlässig erkannt. Subtile Fehler gehen schnell einmal unter auch wenn sie ganz klar in den Systeminformationen erklärt werden. Auch falsche Dateiformate kommen bei der Üerbergabe manchmal vor. Das war auch ein Grund warum nur auf die Result_ids verwiesen werden soll damit die Datei zuverlässig im richtigen Format und unverändert übergeben wird.
- Das lokale llm arbeitet viel zuverlässiger mit der Referenzzeit, weil es den aktuell realen Zeitpunkt gar nicht kennt. Beim Cloudmodell geht die Referenzzeit immer wieder unter und es wird behauptet es gebe keine Daten. Das hat deutliche Auswirkungen auf die Fehlerquote des Cloudmodells. Die Referenzzeit mit Datum ist aber für alle Methoden gleich. Wenn sich zum Beispiel zeigen sollte, dass bei der Pipeline weniger Probleme mit Referenzzeiten auftreten könnte das an der geringeren Komplexität liegen, dass dieses Detail weniger untergeht. Beim Auswerten hatte ich das Gefühl, dass das Cloudmodell dort weniger oft diesen Fehler macht.
- Es gibt wirklich die vielfältigsten Fehler: voneinander abhängige Iterationen mit erfundenen IDs, falsche Toolreihenfolge, falsche Ergebnisse übergeben, Ergebnisse übergeben und beschreiben wie es zu berechnen wäre anstatt die Tools für die Berechnung zu nutzen, immer wieder wichtige Informationen und Hinweise vergessen und ignorieren, ...
- Das cloud Modell erkennt viel zuverlässiger wenn es etwas nicht kann. Ich musste dem lokalen LLM sehr deutlich machen, dass es nachfragen soll wenn es weitere Informationen braucht oder zurückgeben soll wenn es etwas nicht kann. Das Cloudmodell scheint darauf deutlich sensibler zu reagieren und fragt bei jeder noch so kleinen Ungenauigkeit nach auch wenn es eigentlich offensichtlich nur eine sinnvolle Interpretation gibt. Zb. schreibe ich bewusst "mp3" statt "mp_3" und das lokale Modell nimmt sogut wie immer einfach mp_3 an weil es die einzig logische Option ist. Aber da ich so deutlich gemacht habe, dass bei Unklarheiten nachgefragt werden muss kann ich das dem Cloudmodell schlecht als Fehler ausgelgen. Ich musste die Prompts in einigen Aspekten sehr deutlich und teilweise ausführlich definieren damit das lokale LLM wichtige Punkte berücksichtigt. Das Cloudmodell scheint das dann stark zu priorisieren und teilweise sehr konsequent anzuwenden auch wenn es nicht unbedingt nötig wäre. Durch die vielen Nachfragen musste das Modell aber auch deutlich weniger oft beweisen ob es die Tools tatsächlich richtig auswählen hätte können wenn die Systeminformationen auf dieses optimiert gewesen wären. Allerdings war das Ziel ja mit allen Modellen die gleichen Systeminformationen zu verwenden um die Vergleichbarkeit zu gewährleisten. Und das ist schließlich auch eine Erkenntnis daraus.

// This section presents a comprehensive overview of measurements, data tables, and performance evaluations, encompassing factors such as accuracy and speed.
// This section is also where you evaluate your prototype or framework:
// What is the users' verdict?
// What worked and what didn't?

// In cases where an abundance of results is available, it is advisable to place the detailed data in a separate appendix chapter at the end of your document.
// Here, in the main text, include only the pertinent excerpts or noteworthy examples, directing readers to the comprehensive data compilation provided in the appendix.

// Note that this section is often merged with the Discussion part; if kept separate, the interpretation of your results happens below.
