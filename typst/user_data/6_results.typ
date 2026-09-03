#import "../globals.typ": *

#context if text.lang == "de" [
    = Ergebnisse
    <sec:results>
] else [
    = Results
    <sec:results>
]

// 4-6 Seite

Im Rahmen der Evaluation wurden insgesamt 810 Durchläufe durchgeführt. Diese ergeben sich aus 90 Aufgaben, die jeweils mit drei Orchestrierungsmethoden und drei Modellen bearbeitet wurden. Die 90 Aufgaben verteilen sich gleichmäßig auf die drei Aufgabentypen direkte Datenabfrage, Einzelquellenverarbeitung und Mehrquellenverarbeitung mit jeweils 30 Aufgaben.

Für die Bewertung werden die Korrektheit und Effizienz der Orchestrierung als zentrale Kriterien betrachtet. Ergänzend werden die Fehlerrate, die durchschnittliche Laufzeit der LLM-Aufrufe sowie der durchschnittliche Tokenverbrauch ausgewertet. Korrektheit und Effizienz werden als Raten angegeben. Laufzeit und Tokenverbrauch stellen Mittelwerte der jeweils erfassten Werte dar.

== Gesamtvergleich der Methoden

Der Vergleich der drei Orchestrierungsmethoden zeigt deutliche Unterschiede hinsichtlich Korrektheit und Effizienz.

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
      [*Fehlerrate*]
    ),

    [Deterministisch], [0,72], [0,65], [7,67], [4019], [0.15],
    [Planbasiert], [0.59], [0.49], [8.84], [5331], [0.29],
    [Iterativ], [0.44], [0.38], [13.16], [8273], [0.31],

  ),
  caption: [Gesamtvergleich der Methoden],
) <tab:evaluation_by_methods>

Die deterministische Methode erreicht mit einer Korrektheitsrate von 0,72 den höchsten Wert der drei Methoden. Die planbasierte Methode erreicht eine Korrektheitsrate von 0,59, während die iterative Methode mit 0,44 den niedrigsten Wert aufweist. Ein vergleichbares Verhältnis zeigt sich bei der Effizienz. Die deterministische Methode erreicht mit 0,65 den höchsten Wert, gefolgt von der planbasierten Methode mit 0,49 und der iterativen Methode mit 0,38.

Auch bei der Laufzeit unterscheiden sich die Methoden. Die deterministische Methode weist mit durchschnittlich 7,67 Sekunden die niedrigste Laufzeit auf. Die planbasierte Methode benötigt durchschnittlich 8,84 Sekunden, während die iterative Methode mit 13,16 Sekunden den höchsten Wert erreicht.

Beim durchschnittlichen Tokenverbrauch zeigt sich ebenfalls eine Abstufung zwischen den Methoden. Die deterministische Methode benötigt durchschnittlich 4.019 Tokens, die planbasierte Methode 5.331 Tokens und die iterative Methode 8.273 Tokens.

Die Fehlerrate beträgt bei der deterministischen Methode 0,15. Die planbasierte Methode weist eine Fehlerrate von 0,29 auf, während die iterative Methode mit 0,31 den höchsten Wert erreicht. Damit weist die deterministische Methode in allen betrachteten Kriterien außer der expliziten Betrachtung von Einzelaspekten der Komponenten die günstigsten Werte auf.

== Analyse der Korrektheits- und Effizienzkomponenten

Zur näheren Betrachtung der Korrektheits- und Effizienzergebnisse werden die zugrunde liegenden Komponenten Toolauswahl und Argumentübergabe getrennt betrachtet.

#figure(
  table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center, center),

    table.header(
      [*Methode*],
      [*Toolauswahl\ korrekt*],
      [*Argument\ korrekt*],
      [*Toolauswahl\ effizient*],
      [*Argumente\ effizient*]
    ),
    [Deterministisch], [0.75], [0.72], [0.68], [0.65],
    [Planbasiert], [0.60], [0.59],  [0.50], [0.49],
    [Iterativ], [0.45], [0.44], [0.39], [0.38]
  ),
  caption: [Analyse der Korrektheits- und Effizienzkomponenten],
) <tab:evaluation_correct_efficient>

Die Werte der einzelnen Komponenten zeigen, dass die Korrektheit der Toolauswahl bei allen drei Methoden nur geringfügig über der Korrektheit der Argumentübergabe liegt. Bei der deterministischen Methode beträgt die Rate der korrekten Toolauswahl 0,75 und die Rate der korrekten Argumentübergabe 0,72. Bei der planbasierten Methode liegen die entsprechenden Werte bei 0,60 und 0,59. Die iterative Methode erreicht 0,45 bei der Toolauswahl und 0,44 bei den Argumenten.

Ein vergleichbares Verhältnis zeigt sich bei der Effizienz. Die deterministische Methode erreicht eine effiziente Toolauswahl in 0,68 der Fälle und eine effiziente Argumentübergabe in 0,65 der Fälle. Bei der planbasierten Methode liegen die Werte bei 0,50 beziehungsweise 0,49. Die iterative Methode erreicht 0,39 beziehungsweise 0,38.

Damit liegen die Werte der Argumentkomponenten bei allen drei Methoden jeweils nur geringfügig unter den entsprechenden Werten der Toolauswahl. Die größten Unterschiede zwischen den Methoden zeigen sich somit bereits bei der Auswahl der benötigten Tools.

== Gesamtvergleich der Aufgabentypen

Neben dem Vergleich der Orchestrierungsmethoden wird untersucht, wie sich die Ergebnisse in Abhängigkeit vom Aufgabentyp unterscheiden. Da die 90 Aufgaben gleichmäßig auf die drei Aufgabentypen verteilt sind, entfallen jeweils 30 Aufgaben auf direkte Datenabfragen, Einzelquellenverarbeitung und Mehrquellenverarbeitung.

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
      [*Fehlerrate*]
    ),
    [Direkte Datenabfrage], [0,75], [0,72], [8,43], [6102], [0,11],
    [Einzelquellenverarbeitung], [0,53], [0,44], [11,15], [5718], [0,24],
    [Mehrquellenverarbeitung], [0,46], [0,36], [9,82], [5213], [0,40],
  ),
  caption: [Vergleich der Aufgabentypen],
) <tab:evaluation_by_task_type>

Bei den direkten Datenabfragen wird mit 0,75 die höchste Korrektheitsrate erreicht. Die Einzelquellenverarbeitung erreicht eine Korrektheitsrate von 0,53, während die Mehrquellenverarbeitung mit 0,46 den niedrigsten Wert aufweist.

Dasselbe Muster zeigt sich bei der Effizienz. Direkte Datenabfragen erreichen mit 0,72 den höchsten Wert. Die Einzelquellenverarbeitung erreicht 0,44 und die Mehrquellenverarbeitung 0,36.

Die Fehlerrate steigt dagegen von 0,11 bei direkten Datenabfragen über 0,24 bei der Einzelquellenverarbeitung auf 0,40 bei der Mehrquellenverarbeitung. Die niedrigste Fehlerrate tritt damit bei den direkten Datenabfragen auf, während die Mehrquellenverarbeitung die höchste Fehlerrate aufweist.

Bei der durchschnittlichen Laufzeit erreicht die direkte Datenabfrage mit 8,43 Sekunden den niedrigsten Wert. Die Einzelquellenverarbeitung weist mit 11,15 Sekunden die höchste durchschnittliche Laufzeit auf. Die Mehrquellenverarbeitung liegt mit 9,82 Sekunden dazwischen.

Beim durchschnittlichen Tokenverbrauch weist die direkte Datenabfrage mit 6.102 Tokens den höchsten Wert auf. Die Einzelquellenverarbeitung erreicht 5.718 Tokens und die Mehrquellenverarbeitung 5.213 Tokens.

== Vergleich der Modelle

Neben der Orchestrierungsmethode wird der Einfluss des verwendeten Modells betrachtet.

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
      [*Fehlerrate*]
    ),
    [gpt-5.4-mini], [0,73], [0,57], [2,14], [4351], [0,00],
    [qwen3:30b], [0,46], [0,44], [11,56], [6250], [0,50],
    [qwen3:8b], [0,56], [0,51], [18,63], [7252], [0,25],
  ),
  caption: [Vergleich der verwendeten Modelle],
) <tab:evaluation_by_models>

Beim Vergleich der Modelle erreicht gpt-5.4-mini mit 0,73 die höchste Korrektheitsrate. qwen3:8b erreicht eine Korrektheitsrate von 0,56, während qwen3:30b mit 0,46 den niedrigsten Wert aufweist.

Auch bei der Effizienz erreicht gpt-5.4-mini mit 0,57 den höchsten Wert. qwen3:8b erreicht 0,51 und qwen3:30b 0,44.

Deutliche Unterschiede zeigen sich bei der Fehlerrate. Für gpt-5.4-mini beträgt diese 0,00. qwen3:8b erreicht eine Fehlerrate von 0,25, während qwen3:30b mit 0,50 den höchsten Wert der drei Modelle aufweist.

Auch die durchschnittliche Laufzeit unterscheidet sich deutlich. gpt-5.4-mini weist mit 2,14 Sekunden die niedrigste durchschnittliche Laufzeit auf. qwen3:30b erreicht 11,56 Sekunden und qwen3:8b 18,63 Sekunden.

Beim durchschnittlichen Tokenverbrauch benötigt gpt-5.4-mini mit 4.351 Tokens die geringste Anzahl an Tokens. qwen3:30b erreicht 6.250 Tokens und qwen3:8b 7.252 Tokens.

== Vergleich der Modelle und Methoden

Die bisherigen Vergleiche betrachten Modelle und Methoden jeweils getrennt. Um zu untersuchen, ob sich die Ergebnisse der Methoden abhängig vom verwendeten Modell unterscheiden, werden die Kombinationen aus Modell und Orchestrierungsmethode betrachtet.

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
      [*Fehlerrate*]
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

Die kombinierte Betrachtung von Modell und Methode zeigt, dass die Korrektheit der Methoden innerhalb der Modelle unterschiedlich ausfällt.

Bei gpt-5.4-mini erreicht die deterministische Methode mit 0,83 die höchste Korrektheitsrate. Die planbasierte Methode erreicht 0,79 und die iterative Methode 0,56. Auch hinsichtlich der Effizienz liegt die deterministische Methode mit 0,70 vor der planbasierten Methode mit 0,58 und der iterativen Methode mit 0,42. Die Fehlerrate beträgt bei allen drei Methoden 0,00. Die durchschnittliche Laufzeit liegt zwischen 1,82 Sekunden bei der deterministischen und 2,51 Sekunden bei der iterativen Methode. Der Tokenverbrauch steigt von 3.204 Tokens bei der deterministischen über 4.503 Tokens bei der planbasierten auf 5.344 Tokens bei der iterativen Methode.

Bei qwen3:30b erreicht die deterministische Methode mit 0,67 die höchste Korrektheitsrate. Die iterative Methode erreicht 0,40 und die planbasierte Methode 0,30. Ein ähnliches Verhältnis zeigt sich bei der Effizienz. Die deterministische Methode erreicht 0,64, die iterative Methode 0,39 und die planbasierte Methode 0,29. Die Fehlerrate beträgt bei der deterministischen Methode 0,23, bei der planbasierten Methode 0,68 und bei der iterativen Methode 0,59. Die durchschnittliche Laufzeit beträgt 10,32 Sekunden bei der deterministischen, 12,04 Sekunden bei der planbasierten und 13,51 Sekunden bei der iterativen Methode. Der Tokenverbrauch beträgt 4.656, 6.261 beziehungsweise 9.216 Tokens.

Bei qwen3:8b erreicht die planbasierte Methode mit 0,67 die höchste Korrektheit und liegt damit knapp vor der deterministischen Methode mit 0,66. Bei der Effizienz liegt dagegen die deterministische Methode mit 0,61 knapp vor der planbasierten Methode mit 0,60. Die iterative Methode weist mit 0,36 bei der Korrektheit und 0,32 bei der Effizienz jeweils die niedrigsten Werte auf. Die iterative Methode erreicht 0,32. Die Fehlerrate beträgt 0,21 bei der deterministischen, 0,20 bei der planbasierten und 0,34 bei der iterativen Methode. Die durchschnittliche Laufzeit beträgt 12,52 Sekunden bei der deterministischen, 16,00 Sekunden bei der planbasierten und 29,19 Sekunden bei der iterativen Methode. Der Tokenverbrauch beträgt 4.432 Tokens bei der deterministischen, 6.001 Tokens bei der planbasierten und 12.149 Tokens bei der iterativen Methode.

Damit zeigt die kombinierte Betrachtung, dass die Rangfolge der Methoden nicht für alle Modelle identisch ist. Während die deterministische Methode bei gpt-5.4-mini und qwen3:30b die höchste Korrektheitsrate erreicht, weist bei qwen3:8b die planbasierte Methode den höchsten Korrektheitswert auf.

== Fehlerrate

Die Fehlerrate beschreibt den Anteil der Durchläufe, bei denen ein Fehler auftrat. Ein wesentlicher Anteil der beobachteten Fehler entfällt auf Timeouts. Ein LLM-Aufruf wird nach einer Laufzeit von zwei Minuten abgebrochen und der betreffende Durchlauf als fehlerhaft bewertet. Bei der iterativen Methode gilt dieses Zeitlimit für jeden einzelnen LLM-Aufruf innerhalb einer Iteration.

Über alle 810 Durchläufe trat einmal ein Strukturfehler auf. Dieser trat beim Modell qwen3:8b auf. Dabei wurde eine Ausgabe in einer Form zurückgegeben, die beim anschließenden Zugriff nicht verarbeitet werden konnte. Die übrigen beobachteten Fehler entfielen überwiegend auf Timeouts.

Darüber hinaus traten bei der iterativen Methode fehlerhafte Toolaufrufe auf, bei denen Toolaufrufe einer nachfolgenden Iteration vorweggenommen und dabei unter anderem nicht vorhandene `result_ids` verwendet wurden. Diese Fälle wurden nicht als Strukturfehler erfasst, da die zurückgegebene Struktur grundsätzlich verarbeitet werden konnte. Sie wurden stattdessen als fehlerhafte Toolaufrufe bewertet.

Die Fehlerraten unterscheiden sich sowohl zwischen den Methoden als auch zwischen den Modellen. Auf Methodenebene weist die deterministische Methode mit 0,15 die niedrigste Fehlerrate auf. Die planbasierte Methode erreicht 0,29 und die iterative Methode 0,31. Auf Modellebene weist gpt-5.4-mini mit 0,00 keine Fehler in den betrachteten Durchläufen auf. qwen3:8b erreicht 0,25 und qwen3:30b 0,50.

Die kombinierte Betrachtung von Modell und Methode zeigt ebenfalls deutliche Unterschiede. Bei gpt-5.4-mini beträgt die Fehlerrate unabhängig von der Methode 0,00. Bei qwen3:30b reicht sie von 0,23 bei der deterministischen Methode bis 0,68 bei der planbasierten Methode. Bei qwen3:8b liegen die Werte zwischen 0,20 bei der planbasierten und 0,34 bei der iterativen Methode.

== Laufzeit

Die Laufzeit wird als durchschnittliche Dauer der gemessenen LLM-Aufrufe angegeben. Die Ausführung der Tools sowie weitere Verarbeitungsschritte außerhalb der LLM-Aufrufe sind nicht Bestandteil der Laufzeitmessung. Durchläufe ohne gültigen Laufzeitwert, beispielsweise aufgrund eines Timeouts, werden bei der Berechnung des Mittelwerts nicht berücksichtigt.

Auf Methodenebene weist die deterministische Methode mit durchschnittlich 7,67 Sekunden die niedrigste Laufzeit auf. Die planbasierte Methode erreicht 8,84 Sekunden und die iterative Methode 13,16 Sekunden.

Bei den Modellen unterscheiden sich die durchschnittlichen Laufzeiten stärker. gpt-5.4-mini erreicht 2,14 Sekunden, qwen3:30b 11,56 Sekunden und qwen3:8b 18,63 Sekunden.

Die Kombination von Modell und Methode zeigt, dass die Laufzeit innerhalb eines Modells ebenfalls mit der verwendeten Methode variiert. Bei gpt-5.4-mini liegen die Werte zwischen 1,82 Sekunden bei der deterministischen und 2,51 Sekunden bei der iterativen Methode. Bei qwen3:30b reichen sie von 10,32 Sekunden bei der deterministischen bis 13,51 Sekunden bei der iterativen Methode. Bei qwen3:8b beträgt die Laufzeit 12,52 Sekunden bei der deterministischen, 16,00 Sekunden bei der planbasierten und 29,19 Sekunden bei der iterativen Methode.

Die höchsten Laufzeitwerte treten damit insbesondere bei der Kombination aus qwen3:8b und der iterativen Methode auf.

== Tokenverbrauch

Der Tokenverbrauch wird als durchschnittlicher Gesamtverbrauch von Input- und Output-Tokens ausgewertet.

Auf Methodenebene weist die deterministische Methode mit durchschnittlich 4.019 Tokens den niedrigsten Verbrauch auf. Die planbasierte Methode erreicht 5.331 Tokens, während die iterative Methode mit 8.273 Tokens den höchsten Wert aufweist.

Auch zwischen den Modellen bestehen Unterschiede. gpt-5.4-mini erreicht durchschnittlich 4.351 Tokens, qwen3:30b 6.250 Tokens und qwen3:8b 7.252 Tokens.

Bei der kombinierten Betrachtung von Modell und Methode zeigt sich für alle drei Modelle ein höherer Tokenverbrauch der iterativen Methode gegenüber der deterministischen Methode. Bei gpt-5.4-mini steigt der Verbrauch von 3.204 auf 5.344 Tokens, bei qwen3:30b von 4.656 auf 9.216 Tokens und bei qwen3:8b von 4.432 auf 12.149 Tokens. Die planbasierte Methode liegt bei allen drei Modellen zwischen der deterministischen und der iterativen Methode.

Die Unterschiede zwischen den Methoden fallen damit beim Tokenverbrauch insbesondere bei der iterativen Methode deutlich aus. Den höchsten Wert der kombinierten Auswertung erreicht qwen3:8b mit der iterativen Methode mit durchschnittlich 12.149 Tokens.