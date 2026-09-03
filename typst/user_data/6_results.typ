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

Der Vergleich der drei Orchestrierungsmethoden zeigt ein konsistentes Muster hinsichtlich der Ausführungsqualität und des Ressourcenbedarfs. Die Ergebnisse sind in @tab:evaluation_by_methods zusammengefasst.

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

Die deterministische Methode erreicht mit 0,72 die höchste Korrektheit und mit 0,65 auch die höchste Effizienz. Mit zunehmendem Autonomiegrad sinken beide Kennzahlen und erreichen bei der iterativen Methode mit 0,44 beziehungsweise 0,38 ihre niedrigsten Werte. Gleichzeitig steigt der Ressourcenbedarf. Der durchschnittliche Tokenverbrauch erhöht sich von 4.019 Tokens bei der deterministischen auf 8.273 Tokens bei der iterativen Methode und damit auf mehr als das Doppelte. Auch die durchschnittliche Laufzeit steigt von 7,67 auf 13,16 Sekunden.

Ein vergleichbares Muster zeigt sich bei der Fehlerrate. Diese steigt von 0,15 bei der deterministischen über 0,29 bei der planbasierten auf 0,31 bei der iterativen Methode. Über die betrachteten Gesamtmetriken hinweg zeigt die deterministische Methode damit die günstigsten Ergebnisse hinsichtlich Korrektheit, Effizienz, Ressourcenbedarf und Fehlerrate.

Die Ergebnisse deuten somit darauf hin, dass ein höherer Autonomiegrad in der untersuchten Konfiguration mit einer geringeren Ausführungsqualität und einem höheren Ressourcenbedarf verbunden ist. Ein Vorteil der autonomeren Methoden zeigt sich im Gesamtvergleich dagegen nicht.

== Analyse der Korrektheits- und Effizienzkomponenten

Zur näheren Betrachtung der Korrektheits- und Effizienzergebnisse werden die zugrunde liegenden Komponenten Toolauswahl und Argumentübergabe getrennt betrachtet. Die Ergebnisse sind in @tab:evaluation_correct_efficient dargestellt.

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

Bei allen drei Methoden liegen die Werte der Argumentkomponenten nur geringfügig unter den entsprechenden Werten der Toolauswahl. Bei der Korrektheit beträgt die Differenz zwischen Toolauswahl und Argumentübergabe 0,03 bei der deterministischen sowie jeweils 0,01 bei der planbasierten und iterativen Methode. Ein vergleichbares Muster zeigt sich bei der Effizienz, bei der die Differenzen ebenfalls zwischen 0,01 und 0,03 liegen.

Die Ergebnisse deuten damit darauf hin, dass die wesentlichen Unterschiede zwischen den Orchestrierungsmethoden bereits bei der Auswahl der benötigten Tools auftreten. Die anschließende Argumentübergabe weist demgegenüber nur einen geringen zusätzlichen Rückgang auf. Wurde ein geeignetes Tool ausgewählt, werden die zugehörigen Argumente im untersuchten Setup somit in der Regel ebenfalls korrekt beziehungsweise effizient übergeben.

Damit liefert die Komponentenbetrachtung einen Hinweis darauf, dass die geringeren Gesamtwerte der planbasierten und iterativen Methoden nicht primär auf eine deutlich schlechtere Argumentübergabe zurückzuführen sind, sondern bereits bei der vorgelagerten Toolauswahl sichtbar werden.

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
  caption: [Gesamtvergleich der Aufgabentypen],
) <tab:evaluation_by_task_type>

#figure(
  image("../figures/correct_efficient_error_ratio_by_task_type.png", width: 90%),
  caption: [Vergleich von Korrektheit, Effizienz und Fehlerrate nach Aufgabentyp],
) <evaluation_correct_efficient_error_ratio_by_task_type>

Die Ergebnisse zeigen deutliche Unterschiede zwischen den Aufgabentypen. Direkte Datenabfragen weisen sowohl bei der Korrektheit als auch bei der Effizienz die höchsten Werte auf. Mit zunehmenden Anforderungen an die Verarbeitung sinken beide Kennzahlen. Besonders deutlich zeigt sich dies bei der Mehrquellenverarbeitung, bei der die Korrektheit 0,46 und die Effizienz 0,36 beträgt.

Ein umgekehrtes Muster zeigt sich bei der Fehlerrate. Diese liegt bei der Mehrquellenverarbeitung mit 0,40 deutlich über dem Wert der direkten Datenabfrage von 0,11. Die Ergebnisse deuten damit darauf hin, dass Aufgaben mit mehreren voneinander abhängigen Verarbeitungsschritten höhere Anforderungen an die untersuchten Orchestrierungsverfahren stellen.

Bei Laufzeit und Tokenverbrauch zeigt sich dagegen kein einheitlicher Zusammenhang mit den Aufgabentypen. Die Einzelquellenverarbeitung weist mit durchschnittlich 11,15 Sekunden die höchste Laufzeit auf, während die direkte Datenabfrage mit 6.102 Tokens den höchsten durchschnittlichen Tokenverbrauch verursacht. Ein höherer Ressourcenbedarf lässt sich daher aus den betrachteten Aufgabentypen nicht unmittelbar ableiten.

== Vergleich der Modelle

Neben der Orchestrierungsmethode wird der Einfluss des verwendeten Modells betrachtet. Die Ergebnisse sind in @tab:evaluation_by_models zusammengefasst.

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

gpt-5.4-mini erreicht über die betrachteten Modelle hinweg die höchste Korrektheit (0,73) und Effizienz (0,57) sowie gleichzeitig die niedrigste Fehlerrate (0,00). Die beiden Qwen-Modelle weisen dagegen deutlich höhere Fehlerraten auf. Dabei erreicht qwen3:8b mit einer Korrektheit von 0,56 und einer Effizienz von 0,51 jeweils bessere Werte als das größere qwen3:30b-Modell mit 0,46 beziehungsweise 0,44.

Auch beim Ressourcenbedarf zeigen sich deutliche Unterschiede. gpt-5.4-mini weist mit durchschnittlich 2,14 Sekunden die niedrigste Laufzeit und mit 4.351 Tokens den niedrigsten Tokenverbrauch auf. Zwischen den beiden Qwen-Modellen zeigt sich dagegen kein Vorteil des größeren Modells: qwen3:8b benötigt mit durchschnittlich 18,63 Sekunden und 7.252 Tokens sogar mehr Zeit und Tokens als qwen3:30b mit 11,56 Sekunden und 6.250 Tokens.

Insgesamt zeigen die Ergebnisse deutliche Unterschiede zwischen den verwendeten Modellen. Ein Zusammenhang zwischen Modellgröße und Leistungsfähigkeit lässt sich aus den Ergebnissen jedoch nicht ableiten, da das kleinere qwen3:8b sowohl hinsichtlich Korrektheit als auch Effizienz und Fehlerrate besser abschneidet als qwen3:30b. Die Unterschiede sind daher im Kontext der konkret untersuchten Modelle und Versuchsbedingungen zu interpretieren.

== Vergleich der Modelle und Methoden

Die bisherigen Vergleiche betrachten Modelle und Methoden jeweils getrennt. Um zu untersuchen, ob sich die Ergebnisse der Orchestrierungsmethoden abhängig vom verwendeten Modell unterscheiden, werden die Kombinationen aus Modell und Orchestrierungsmethode betrachtet. Die Ergebnisse sind in @tab:evaluation_by_model_and_method zusammengefasst.

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

Die kombinierte Betrachtung zeigt, dass die Leistungsunterschiede zwischen den Methoden vom verwendeten Modell abhängen. Bei gpt-5.4-mini erreicht die deterministische Methode mit einer Korrektheit von 0,83 den höchsten Wert, gefolgt von der planbasierten Methode mit 0,79 und der iterativen Methode mit 0,56. Auch bei qwen3:30b liegt die deterministische Methode mit 0,67 deutlich vor der planbasierten Methode mit 0,30 und der iterativen Methode mit 0,40.

Bei qwen3:8b zeigt sich dagegen eine abweichende Rangfolge. Die planbasierte Methode erreicht mit 0,67 knapp die höchste Korrektheit, während die deterministische Methode mit 0,66 nahezu gleichauf liegt. Die iterative Methode weist mit 0,36 erneut den niedrigsten Wert auf. Damit ist die Rangfolge der Methoden hinsichtlich der Korrektheit nicht für alle Modelle identisch.

Auch bei den Ressourcen zeigt sich ein modellabhängiger Unterschied. Die iterative Methode weist bei allen drei Modellen den höchsten Tokenverbrauch auf. Besonders ausgeprägt ist dies bei qwen3:8b mit durchschnittlich 12.149 Tokens und einer Laufzeit von 29,19 Sekunden. Bei gpt-5.4-mini bleiben die Laufzeitunterschiede zwischen den Methoden dagegen deutlich geringer.

Insgesamt zeigen die Ergebnisse, dass die Auswirkungen der Orchestrierungsmethode nicht unabhängig vom verwendeten Modell betrachtet werden können. Die deterministische Methode erzielt bei zwei der drei untersuchten Modelle die höchste Korrektheit, während beim qwen3:8b die planbasierte Methode knapp den höchsten Wert erreicht. Ein allgemeingültiger Zusammenhang zwischen Modell und optimaler Orchestrierungsmethode lässt sich aus den vorliegenden Ergebnissen jedoch nicht ableiten.

== Vergleich der Methoden und Aufgabentypen

Eine differenzierte Betrachtung der Orchestrierungsmethoden nach Aufgabentyp zeigt, dass die Unterschiede zwischen den Methoden insbesondere bei Aufgaben mit mehreren Verarbeitungsschritten und voneinander abhängigen Toolergebnissen zunehmen. Die entsprechenden Ergebnisse sind in @tab:evaluation__method_and_task_type und @evaluation_correct_by_method_and_task_type dargestellt.

#figure(

  table(
    columns: (auto, auto, 1fr, 1fr, 1fr),
    align: (left, left, center, center, center),
    table.header(
      [*Methode*],
      [*Aufgabentyp*],
      [*Korrektheit*],
      [*Effizienz*],
      [*Fehlerrate*]
    ),

    table.cell(rowspan: 3)[Deterministisch],
    [Direkte Verarbeitung], [0.79], [0.77], [0.04],
    [Einzelquellenverarbeitung], [0.64], [0.54], [0.16],
    [Mehrquellenverarbeitung], [0.72], [0.64], [0.24],

    table.cell(rowspan: 3)[Planbasiert],
    [Direkte Verarbeitung], [0.72], [0.69], [0.19],
    [Einzelquellenverarbeitung], [0.58], [0.47], [0.26],
    [Mehrquellenverarbeitung], [0.46], [0.31], [0.43],

    table.cell(rowspan: 3)[Iterativ],
    [Direkte Verarbeitung], [0.74], [0.70], [0.10],
    [Einzelquellenverarbeitung], [0.36], [0.30], [0.30],
    [Mehrquellenverarbeitung], [0.21], [0.13], [0.53],
  ),
  caption: [Vergleich der Methoden und Aufgabentypen],
) <tab:evaluation__method_and_task_type>

#figure(
  image("../figures/correct_by_method_and_task_type.png", width: 90%),
  caption: [Vergleich der Korrektheit nach Methode und Aufgabentyp],
) <evaluation_correct_by_method_and_task_type>

Bei direkten Datenabfragen liegen die drei Methoden hinsichtlich Korrektheit und Effizienz vergleichsweise nah beieinander. Die Korrektheit liegt zwischen 0,72 bei der planbasierten und 0,79 bei der deterministischen Methode. Auch bei der Einzelquellenverarbeitung bleiben die Unterschiede zwischen der deterministischen und der planbasierten Methode vergleichsweise gering, während die iterative Methode mit einer Korrektheit von 0,36 und einer Effizienz von 0,30 deutlich schlechter abschneidet.

Besonders deutlich treten die Unterschiede bei der Mehrquellenverarbeitung hervor. Die deterministische Methode erreicht hier eine Korrektheit von 0,72 und eine Effizienz von 0,64. Bei der planbasierten Methode sinken diese Werte auf 0,46 beziehungsweise 0,31 und bei der iterativen Methode auf 0,21 beziehungsweise 0,13. Gleichzeitig steigt die Fehlerrate von 0,24 bei der deterministischen über 0,43 bei der planbasierten auf 0,53 bei der iterativen Methode.

Damit hängt die Leistungsdifferenz zwischen den Orchestrierungsmethoden deutlich vom untersuchten Aufgabentyp ab. Während die Methoden bei direkten Datenabfragen hinsichtlich Korrektheit und Effizienz vergleichsweise nah beieinander liegen, verstärken sich die Unterschiede insbesondere bei der Mehrquellenverarbeitung. Auffällig ist dabei, dass die deterministische Methode auch bei der Mehrquellenverarbeitung eine hohe Korrektheit erreicht, während die autonomeren Methoden deutlich abfallen. Die Ergebnisse deuten darauf hin, dass insbesondere die Koordination mehrerer voneinander abhängiger Verarbeitungsschritte eine besondere Anforderung an Orchestrierungsmethoden mit größerem Entscheidungsspielraum darstellt.

== Fehlerrate

Die Fehlerrate beschreibt den Anteil der Durchläufe, bei denen ein Fehler auftrat. Ein wesentlicher Anteil der beobachteten Fehler entfällt auf Timeouts. Ein LLM-Aufruf wird nach einer Laufzeit von zwei Minuten abgebrochen und der betreffende Durchlauf als fehlerhaft bewertet. Bei der iterativen Methode gilt dieses Zeitlimit für jeden einzelnen LLM-Aufruf innerhalb einer Iteration.

Über alle 810 Durchläufe trat einmal ein Strukturfehler auf. Dieser trat beim Modell qwen3:8b auf. Dabei wurde eine Ausgabe in einer Form zurückgegeben, die beim anschließenden Zugriff nicht verarbeitet werden konnte. Die übrigen beobachteten Fehler entfielen überwiegend auf Timeouts. Darüber hinaus traten bei der iterativen Methode fehlerhafte Toolaufrufe auf, bei denen unter anderem nicht vorhandene `result_ids` verwendet wurden. Diese Fälle wurden aufgrund der grundsätzlich verarbeitbaren Rückgabestruktur nicht als Strukturfehler, sondern als fehlerhafte Toolaufrufe bewertet.

Die Fehlerrate unterscheidet sich sowohl zwischen den Methoden als auch zwischen den Modellen. Auf Methodenebene steigt sie von 0,15 bei der deterministischen über 0,29 bei der planbasierten auf 0,31 bei der iterativen Methode. Auf Modellebene weist gpt-5.4-mini mit 0,00 keine Fehler auf, während qwen3:8b eine Fehlerrate von 0,25 und qwen3:30b von 0,50 erreicht.

Auch die kombinierte Betrachtung zeigt deutliche Unterschiede zwischen den Modell-Methoden-Kombinationen. Besonders auffällig ist qwen3:30b, bei dem die Fehlerrate von 0,23 bei der deterministischen Methode auf 0,68 bei der planbasierten und 0,59 bei der iterativen Methode steigt. Bei gpt-5.4-mini treten dagegen unabhängig von der Methode keine Fehler auf. Die Ergebnisse zeigen damit, dass die Fehlerrate sowohl vom verwendeten Modell als auch von der gewählten Orchestrierungsmethode abhängt.

== Laufzeit

Die Laufzeit wird als durchschnittliche Dauer der gemessenen LLM-Aufrufe angegeben. Die Ausführung der Tools sowie weitere Verarbeitungsschritte außerhalb der LLM-Aufrufe sind nicht Bestandteil der Laufzeitmessung. Durchläufe ohne gültigen Laufzeitwert, beispielsweise aufgrund eines Timeouts, werden bei der Berechnung des Mittelwerts nicht berücksichtigt.

Auf Methodenebene steigt die durchschnittliche Laufzeit von 7,67 Sekunden bei der deterministischen über 8,84 Sekunden bei der planbasierten auf 13,16 Sekunden bei der iterativen Methode.

Auch innerhalb der einzelnen Modelle zeigt sich überwiegend eine längere Laufzeit bei autonomeren Methoden. Besonders deutlich ist dies bei qwen3:8b, dessen durchschnittliche Laufzeit von 12,52 Sekunden bei der deterministischen über 16,00 Sekunden bei der planbasierten auf 29,19 Sekunden bei der iterativen Methode steigt. Bei gpt-5.4-mini fällt der Unterschied mit 1,82 Sekunden bei der deterministischen und 2,51 Sekunden bei der iterativen Methode dagegen deutlich geringer aus.

Damit zeigt sich insbesondere bei der iterativen Methode ein erhöhter Laufzeitbedarf. Die absoluten Laufzeiten zwischen den Modellen sind aufgrund der unterschiedlichen technischen Ausführungsbedingungen jedoch nur eingeschränkt miteinander vergleichbar.

== Tokenverbrauch

Der Tokenverbrauch wird als durchschnittlicher Gesamtverbrauch von Input- und Output-Tokens ausgewertet.

Auf Methodenebene steigt der durchschnittliche Tokenverbrauch von 4.019 Tokens bei der deterministischen über 5.331 bei der planbasierten auf 8.273 Tokens bei der iterativen Methode. Dieses Muster zeigt sich auch innerhalb aller drei untersuchten Modelle.

Bei gpt-5.4-mini steigt der Verbrauch von 3.204 Tokens bei der deterministischen auf 5.344 Tokens bei der iterativen Methode. Bei qwen3:30b erhöht er sich von 4.656 auf 9.216 Tokens und bei qwen3:8b von 4.432 auf 12.149 Tokens. Die planbasierte Methode liegt bei allen drei Modellen zwischen der deterministischen und der iterativen Methode.

Der erhöhte Tokenverbrauch der iterativen Methode zeigt sich damit unabhängig vom verwendeten Modell. Besonders ausgeprägt ist der Unterschied bei qwen3:8b, bei dem die iterative Methode mit durchschnittlich 12.149 Tokens fast das Dreifache des Verbrauchs der deterministischen Methode erreicht.