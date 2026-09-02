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

== Gesamtvergleich der Methoden

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center, center, center),

    table.header(
      [*Methode*],
      [*Korrektheit*],
      [*Effizienz*],
      [*Laufzeit [s]*],
      [*Tokens*],
      [*Fehlerquote*]
    ),

    [Deterministisch], [0,72], [0,65], [7,67], [4019], [0.15],
    [Planbasiert], [0.59], [0.49], [8.84], [5331], [0.29],
    [Iterativ], [0.44], [0.38], [13.16], [8273], [0.31],
    
  ),
  caption: [Gesamtvergleich der Methoden],
) <tab:evaluation_by_methods>

== Gesamtvergleich der Aufgabentypen

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center, center, center),

    table.header(
      [*Aufgabentyp*],
      [*Korrektheit*],
      [*Effizienz*],
      [*Laufzeit [s]*],
      [*Tokens*],
      [*Fehlerquote*]
    ),

    [Direkte Datenabfrage], [0,75], [0,72], [8,43], [6102], [0,11],
    [Einzelquellenverarbeitung], [0,53], [0,44], [11,15], [5718], [0,24],
    [Mehrquellenverarbeitung], [0,46], [0,36], [9,82], [5213], [0,40],
  ),
  caption: [Vergleich der Aufgabentypen],
) <tab:evaluation_by_task_type>

== Vergleich der Modelle

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center, center, center),

    table.header(
      [*Modell*],
      [*Korrektheit*],
      [*Effizienz*],
      [*Laufzeit [s]*],
      [*Tokens*],
      [*Fehlerquote*]
    ),

    [gpt-5.4-mini], [0,73], [0,57], [2,14], [4351], [0,00],
    [qwen3:30b], [0,46], [0,44], [11,56], [6250], [0,50],
    [qwen3:8b], [0,56], [0,51], [18,63], [7252], [0,25],
  ),
  caption: [Vergleich der verwendeten Modelle],
) <tab:evaluation_by_models>

== Vergleich der Modelle und Methoden

#figure(
  table(
    columns: (auto, auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, left, center, center, center, center, center),

    table.header(
      [*Modell*],
      [*Methode*],
      [*Korrektheit*],
      [*Effizienz*],
      [*Laufzeit [s]*],
      [*Tokens*],
      [*Fehlerquote*]
    ),

    table.cell(rowspan: 3)[gpt-5.4-mini],
    
    [deterministic], [0,83], [0,70], [1,82], [3204], [0,00],
    [plan-based], [0,79], [0,58], [2,08], [4503], [0,00],
    [iterative], [0,56], [0,42], [2,51], [5344], [0,00],

    table.cell(rowspan: 3)[qwen3:30b],

    [deterministic], [0,67], [0,64], [10,32], [4656], [0,23],
    [plan-based], [0,30], [0,29], [12,04], [6261], [0,68],
    [iterative], [0,40], [0,39], [13,51], [9216], [0,59],

    table.cell(rowspan: 3)[qwen3:8b],
    
    [deterministic], [0,66], [0,61], [12,52], [4432], [0,21],
    [plan-based], [0,67], [0,60], [16,00], [6001], [0,20],
    [iterative], [0,36], [0,32], [29,19], [12149], [0,34],
  ),
  caption: [Vergleich der Modelle und Methoden],
) <tab:evaluation_by_model_and_method>



=== Korrektheit
- Korrekt ist ein Durchlauf wenn die richtigen Tools aufgerufen wurden und die richtigen Argumente übergeben wurden.
- Korrekt = 1, Falsch = 0, mit dem Durchschnitt wird die Ratio berechnet
- Ein Error wird als falscher Toolaufruf gewertet.

=== Effizienz
- Effizient ist ein Durchlauf wenn der Durchlauf korrekt ist und nur die notwendigen Tools und Argumente verwendet wurden.
- Effizient = 1, Ineffizient = 0, mit dem Durchschnitt wird die Ratio berechnet
- Tokenverbrauch wurde bei der Effizienz nicht berücksichtigt.

=== Laufzeit
- Laufzeit wird in Sekunden angegeben
- Es werden ausschließlich die LLM Aufrufe gemessen und nicht die Toolausführung, Speicherung oder sonstige Abläufe die außerhalb dessen passieren.

=== Tokenverbrauch
- Es wird der Durschnittswert berechnet.
- Bei deterministisch und planbasiert sehr konstant weil immer nur ein Durchlauf stattfindet und der Input überwiegend identisch ist.
- deterministisch ist geringer weil weniger erklärt werden muss.Die Struktur ist deultich einfacher und die Formeln müssen nicht erläutert werden weil diese in den Pipelines schon korrekt berechnet werden.
- planbasiert ist etwas höher weil die Struktur erläutert werden muss. ist ebenfalls konstant.
- iterativ hat die höchste Komplexität und damit mehr Erklärungsbedarf. Zusätzlich hängen die Gesamttoken stark von der Gesamtzahl der Iterationen ab. Damit gibt es hier eine deutliche Streuung. Mit jeder Iteration wird auch der Kontext mit den bisherigen Resulaten länger. Weniger Token muss nicht unbedingt besser sein da ein fehlerhafter Durchlauf mit weniger Iterationen zu deutlich weniger Tokenverbrauch führt als ein möglicher korrekter.

=== Fehlerquote

- die absolute Mehrheit der Fehler ist der timeout. Ab 2 Minuten wird der Durchlauf abgebrochen und als falsch gewertet. Wie in den Tabellen zu erkennen brauchen die meisten LLM Aufrufe um die 10 Sekunden. Wenn ein Aufruf über 2 Minuten dauert läuft es meistens sehr lange weiter. Zum einen hätte das den Zeitaufwand meiner Testdurchläufe unverhältnismäßig verlängert und zum anderen möchte kein Nutzer 10 Minuten auf eine Antwort warten die vielleicht garnicht kommt. Bei der Iterativen Methode gilt der timeout pro Iteration. Also jeder llm Aufruf in jeder Iteration hat 2 Minuten Zeitlimit.
- Ein einziges mal von 810 Versuchen wurde eine falsche Struktur zurückgegeben die zu einem Fehler beim Zugriff führte und das war beim kleinsten Modell qwen3:8b. Somit scheint die vorgegebene Struktur sehr zuverlässig eingehalten zu werden. Einzig bei der iterativen Methode wurden Toolaufrufe der nächsten Iteration vorweggenommen und result_ids erfunden. Also ähnlich wie es beim Planbasierten Modell vorgesehen ist. Das wurde aber als fehlerhafter Toolaufruf gewertet und nicht als Strutkurfehler, weil der Zugriff darauf möglich war. Es scheint so zu sein, dass die getesteten Modelle deutlich zuverlässiger mit pipelines und planbasierten Ansätzen arbeiten und schwierigkeiten mit iterativen Ansätzen haben.




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
