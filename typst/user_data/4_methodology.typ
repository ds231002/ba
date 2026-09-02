#import "../globals.typ": *

#context if text.lang == "de" [
    = Methodik
    <sec:methodology>
] else [
    = Methodology
    <sec:methodology>
]

// 4-6 Seiten

== Forschungsdesign

// vergleichende Studie → Was für ein Untersuchungsansatz?
// kontrollierte Experimente → Wie werden die Vergleiche durchgeführt?
// gleiche Testbedingungen → Was wird kontrolliert?
// synthetische Daten → Welche Art von Testdaten?
// Fokus auf Reproduzierbarkeit → Welches methodische Ziel bzw. welche Anforderungen gelten?

// vergleichende experimentelle Studie
// kontrollierte Experimente
// verschiedene Orchestrierungsansätze als Vergleichsbedingungen
// identische Aufgaben/Testfälle
// kontrollierte Rahmenbedingungen
// synthetische bzw. kontrolliert erzeugte Testdaten
// wiederholbare/reproduzierbare Durchführung

Die Untersuchung wird als vergleichende experimentelle Studie durchgeführt. Ziel ist es, unterschiedliche Ansätze zur Orchestrierung von Tool-Aufrufen unter kontrollierten Bedingungen miteinander zu vergleichen und hinsichtlich ihrer Eignung für die Bearbeitung mehrstufiger Aufgaben zu bewerten. Hierzu werden definierte Testaufgaben verwendet, deren Bearbeitung die Auswahl und gegebenenfalls aufeinander aufbauende Nutzung mehrerer Werkzeuge erfordert.

Für die Vergleichbarkeit der Ergebnisse werden die Versuchsbedingungen soweit möglich konstant gehalten. Insbesondere werden für die zu vergleichenden Ansätze dieselben Testaufgaben, Eingangsdaten und verfügbaren Werkzeuge verwendet. Unterschiede in den Ergebnissen sollen damit möglichst auf die jeweils untersuchte Orchestrierungsstrategie beziehungsweise die betrachtete Modellkonfiguration zurückzuführen sein.
// Die Experimente werden wiederholt durchgeführt, um zufällige Schwankungen zu reduzieren und eine reproduzierbare Bewertung zu ermöglichen.

Die verwendeten Testdaten werden kontrolliert beziehungsweise synthetisch erzeugt. Dadurch können relevante Eigenschaften der Aufgaben gezielt variiert und bekannte erwartete Ergebnisse definiert werden. Dies ermöglicht insbesondere die systematische Untersuchung unterschiedlicher Schwierigkeitsgrade und Tool-Abhängigkeiten, ohne von den Eigenschaften eines einzelnen realen Datensatzes abhängig zu sein.

Die Bewertung erfolgt anhand von Kriterien, die sowohl die Korrektheit der Aufgabenbearbeitung als auch die Effizienz der Ausführung berücksichtigen. Neben dem letztendlichen Erfolg einer Aufgabe werden daher auch Eigenschaften der zugrunde liegenden Tool-Aufrufsequenz betrachtet. Dazu gehören insbesondere die korrekte Auswahl und Parametrisierung von Werkzeugen sowie die erfolgreiche Ausführung mehrstufiger Abläufe. Ergänzend werden Laufzeit und gegebenenfalls weitere Ausführungsmerkmale betrachtet.

Vor der eigentlichen Hauptuntersuchung werden ausgewählte technische und methodische Fragestellungen in Voruntersuchungen betrachtet. Diese dienen dazu, geeignete Rahmenbedingungen für die Hauptuntersuchung zu bestimmen und mögliche Einflussfaktoren auf die Ergebnisse zu identifizieren. Aus den Ergebnissen dieser Voruntersuchungen werden, sofern erforderlich, konkrete Designentscheidungen für die anschließenden Experimente abgeleitet.

== Literaturrecherche

Zu Beginn wurde eine strukturierte Literaturrecherche durchgeführt. Hierfür wurden die Datenbanken Google Scholar und IEEE Xplore verwendet. Als Suchbegriffe wurden verschiedene Kombinationen der Begriffe „large language model“, „large language models“, „tool“, „tools“ und „use“ verwendet. Die Ergebnisse wurden jeweils auf Publikationen ab dem Jahr 2022 eingeschränkt. In Google Scholar wurde am 05.03.2026 mit folgendem Suchbegriff gesucht: `allintitle: (tool OR tools) use ("large language model" OR "large language models")`. Dabei wurden 64 Treffer erzielt. In IEEE Xplore wurde am 10.03.2026 mit folgendem Suchbegriff gesucht: `("Document Title":large language model) AND ("Document Title":tool) AND ("All Metadata":use)`. Dabei wurden 37 Treffer erzielt. Auf Basis einer ersten Sichtung der Titel und Zusammenfassungen sowie einer anschließenden detaillierten Prüfung der relevanten Publikationen wurden 17 Publikationen ausgewählt, die sich unmittelbar mit Tool Use, Tool Selection oder der Orchestrierung von Large Language Models beschäftigen. Im weiteren Verlauf der Arbeit wurde die Literaturbasis durch einzelne zusätzliche Publikationen ergänzt. Diese wurden insbesondere über Referenzen bereits identifizierter Arbeiten sowie durch gezielte Recherchen zu offenen Fragestellungen und thematischen Lücken identifiziert.

// 15.08.2026 - Google Scholar

// llm database sql - ab 2025 - 14200 Treffer
// Next-generation database interfaces: A survey of llm-based text-to-sql - 358 Zitate, 2025
// Querying large language models with SQL - 70 mal zitiert, 2026

// llm database function calling - ab 2025 - 17300 Treffer
// Enhancing Accuracy and Maintainability in Nuclear Plant Data Retrieval: A Function-Calling LLM Approach Over NL-to-SQL 


== Technische Rahmenbedingungen

Für die Durchführung und Reproduzierbarkeit der Experimente wurde die nachfolgend dargestellte technische Umgebung verwendet. Tabelle @tab:technische-rahmenbedingungen gibt einen Überblick über die eingesetzte Hardware und Software einschließlich der jeweiligen Versionen.

#figure(
  table(
    columns: (2fr, 4fr),
    inset: 8pt,
    align: left,

    table.header(
      [*Komponente*],
      [*Spezifikation*],
    ),

    table.cell(colspan: 2, fill: luma(240), align: center)[*Hardware*],

    [GPU], [NVIDIA RTX 3090, 24 GB VRAM],
    [CPU], [Intel Core i5-13600K],
    [Arbeitsspeicher], [32 GB DDR5],

    table.cell(colspan: 2, fill: luma(240), align: center)[*Software*],

    [Betriebssystem], [Microsoft Windows 11 Pro, 64-Bit, Version 25H2],
    [NVIDIA-Treiber], [Version 610.88],
    [Python], [Version 3.11.14],
    [Ollama], [Version 0.32.9],
    [OpenAI-Python-Paket], [Version 2.30.0],
  ),
  caption: [Technische Rahmenbedingungen],
) <tab:technische-rahmenbedingungen>

=== Ausführungsbedingungen

// Ollama, OpenAI-Python-Bibliothek
Die Sprachmodelle werden über eine in Python implementierte Schnittstelle angesprochen. Für die lokale Inferenz wird Ollama verwendet. Sowohl die lokalen Modelle als auch das externe API-Modell werden über die OpenAI-Python-Bibliothek angesprochen, wodurch für beide Varianten eine weitgehend einheitliche Schnittstelle verwendet werden kann.

// Modelle vollständig in VRAM
Für die lokalen Modelle wird sichergestellt, dass diese vollständig im GPU-Speicher ausgeführt werden. Dadurch soll CPU-Offloading als zusätzlicher Einflussfaktor auf die Inferenzzeit ausgeschlossen werden @HandlingBigModels.

// GPU-Powerlimit
Für die Messungen wurde das Powerlimit der GPU auf 70 % des Standardwerts begrenzt. In vorbereitenden Tests mit identischen Eingaben zeigte sich unter den verwendeten Bedingungen kein nennenswerter Einfluss dieser Begrenzung auf die Inferenzzeit. Gleichzeitig wurde dadurch die thermische Belastung der GPU reduziert, wodurch mögliche thermisch bedingte Schwankungen der Taktfrequenz begrenzt werden sollten. Diese Einstellung wurde daher für die nachfolgenden Messungen beibehalten @HardwareSoftwareEnvironment.

// Warmup
Vor den eigentlichen Messungen werden zunächst Warm-up-Durchläufe durchgeführt, um mögliche Einflüsse der Initialisierung der Inferenzumgebung auf die gemessenen Laufzeiten zu reduzieren.

== Datengrundlage

Für die Evaluation wird eine synthetische Energiedatenbasis verwendet. Die Verwendung synthetischer Daten ermöglicht eine kontrollierte und reproduzierbare Durchführung der Experimente und stellt sicher, dass alle untersuchten Orchestrierungsstrategien auf dieselbe Datengrundlage zugreifen. Die Datenbasis umfasst Messdaten einzelner Zählpunkte sowie Daten, die sich auf die gesamte Energiegemeinschaft beziehen.

=== Energiedaten

Die Datenbasis umfasst Verbrauchs- und Erzeugungsdaten verschiedener Zählpunkte eines Benutzers. Dabei werden sowohl Zählpunkte mit Verbrauch als auch Zählpunkte mit Erzeugung berücksichtigt. Zusätzlich werden der Gesamtverbrauch und die Gesamterzeugung der Energiegemeinschaft als eigene Datenquellen bereitgestellt.

Die Messdaten werden mit einer zeitlichen Auflösung von 15 Minuten modelliert. Ein Messwert beschreibt dabei die innerhalb eines 15-minütigen Intervalls gemessene Energiemenge in kWh. Zusätzlich werden aktuelle Verbrauchs- und Erzeugungsleistungen in kW bereitgestellt. Der Teilnahmefaktor wird als dimensionsloser Wert zwischen 0 und 1 modelliert und ist für einen Zählpunkt über den gesamten betrachteten Zeitraum konstant.

Die für die Evaluation verwendeten Größen sind in @tab:energiedaten zusammengefasst.

#figure(
  table(
    columns: (0.8fr, 2.3fr, 3fr, 1fr, 1.3fr),
    align: (center, left, left, center, center),

    table.header([*Abk.*], [*Bedeutung Englisch*], [*Bedeutung Deutsch*], [*Einheit*], [*Zeitbezug*],),

    // Basisdaten

    table.cell(colspan: 5, fill: luma(240))[*Basisdaten*],

    [PF], [Participation Factor], [Teilnahmefaktor], [–], [konstant],
    [CPC], [Current Power Consumption], [Aktueller Verbrauch], [kW], [aktuell],
    [CPG], [Current Power Generation], [Aktuelle Erzeugung], [kW], [aktuell],
    [MC], [Measured Consumption], [Gemessener Verbrauch], [kWh], [15 min],
    [MG], [Measured Generation], [Gemessene Erzeugung], [kWh], [15 min],
    [$"MC"_"EG"$], [Total Consumption], [Gesamtverbrauch], [kWh], [15 min],
    [$"MG"_"EG"$], [Total Generation], [Gesamterzeugung], [kWh], [15 min],

    table.cell(colspan: 5, fill: luma(240))[*Abgeleitete Daten*],

    [CP], [Community Potential], [Gemeinschaftsanteil], [kWh], [15 min],
    [CC], [Community Coverage], [Eigenabdeckung], [kWh], [15 min],
    // [SG], [Surplus Generation], [Restüberschuss], [kWh], [15 min],
    // [WSG], [Weighted Surplus Generation], [Restüberschuss gemäß Teilnahmefaktor], [kWh], [15 min],
    [WMC], [Weighted Measured Consumption], [Gemessener Verbrauch gemäß Teilnahmefaktor], [kWh], [15 min],
    [WMG], [Weighted Measured Generation], [Gemessene Erzeugung gemäß Teilnahmefaktor], [kWh], [15 min],
  ),
  caption: [Für die Evaluation verwendete Energiedaten],
) <tab:energiedaten>

Die Einteilung in Basisdaten und abgeleitete Daten beschreibt die Verfügbarkeit der jeweiligen Größen innerhalb der Testumgebung. Die Größen $"MC"_"EG"$ und $"MG"_"EG"$ könnten grundsätzlich aus den Messwerten der einzelnen Zählpunkte aggregiert werden. Für die vorliegende Evaluation werden sie dennoch als Basisdaten behandelt. Da keine realen Messdaten einer vollständigen Energiegemeinschaft vorliegen, werden sie als synthetische, bereits aggregierte Datenquellen bereitgestellt. Dadurch stehen allen Orchestrierungsstrategien identische und reproduzierbare gemeinschaftsweite Daten zur Verfügung.

=== Synthetische Datengenerierung

Die benötigten Energiedaten werden synthetisch erzeugt. Für die Verbrauchsdaten wird ein Tagesprofil mit einer Grundlast und typischen Verbrauchsspitzen am Morgen und Abend verwendet. Zusätzlich werden zufällige Schwankungen berücksichtigt. Die Erzeugungsdaten bilden ein vereinfachtes Photovoltaikprofil ab, bei dem während der Nacht keine und während der Tagesstunden eine tageszeitabhängige Erzeugung angenommen wird.

Durch unterschiedliche Skalierungsfaktoren werden Zählpunkte mit unterschiedlichen Verbrauchs- und Erzeugungsniveaus simuliert. Die Energiegemeinschaft wird zusätzlich als virtueller Zählpunkt mit höher skalierten Werten modelliert. Die entsprechenden Zeitreihen stellen somit synthetische gemeinschaftsweite Größen dar und sind nicht als reale Messwerte einer bestehenden Energiegemeinschaft zu interpretieren.

Für die zufälligen Schwankungen wird ein fester Seed verwendet. Dadurch können die Testdaten reproduzierbar erzeugt werden und bleiben bei wiederholter Ausführung mit identischen Parametern unverändert.

Die erzeugten Daten werden in CSV-Dateien gespeichert. Beim Einlesen werden die Zeitstempel in ein standardisiertes Zeitformat überführt und als Index der jeweiligen Zeitreihe verwendet. Dadurch weisen die eingelesenen Zeitreihen eine einheitliche Struktur auf.

=== Fachliche Definitionen

Die folgenden Definitionen beschreiben die für die Evaluation relevanten Zusammenhänge zwischen den verfügbaren Basisdaten und den daraus abgeleiteten Größen. Dabei bezeichnet $t$ das betrachtete Messintervall, $i$ den Index eines Verbrauchszählpunkts und $j$ den Index eines Erzeugungszählpunkts. $n$ und $m$ bezeichnen die Anzahl der Verbrauchs- bzw.
Erzeugungszählpunkte. Der Index $k$ dient als Laufindex bei Summationen über die Verbrauchszählpunkte.

==== Gesamtverbrauch und Gesamterzeugung

Der Gesamtverbrauch und die Gesamterzeugung beschreiben die über alle betrachteten Zählpunkte aggregierten Energiemengen der Energiegemeinschaft.

Der Gesamtverbrauch ergibt sich aus der Summe der gemessenen Verbrauchswerte aller Verbrauchszählpunkte:

$ "MC"_"EG"(t) = sum_(i=1)^n "MC"_i(t) $

Analog ergibt sich die Gesamterzeugung aus der Summe der gemessenen Erzeugungswerte aller Erzeugungszählpunkte:

$ "MG"_"EG"(t) = sum_(j=1)^m "MG"_j(t) $

Die beiden Größen werden in der Testumgebung als Basisdaten bereitgestellt, obwohl sie grundsätzlich aus den Messwerten der einzelnen Zählpunkte aggregiert werden könnten.

==== Teilnahmefaktor und gewichtete Messwerte

Der Teilnahmefaktor bestimmt, mit welchem Anteil der gemessene Verbrauch bzw. die gemessene Erzeugung für die Energiegemeinschaft berücksichtigt wird. Für die Evaluation wird der Teilnahmefaktor als zeitlich konstanter Wert pro Zählpunkt modelliert und als dimensionsloser Faktor zwischen 0 und 1 angegeben.

Der gewichtete Verbrauch eines Verbrauchszählpunkts ergibt sich aus der Multiplikation des gemessenen Verbrauchs mit dem jeweiligen Teilnahmefaktor:

$ "WMC"_i(t) = "MC"_i(t) dot "PF"_i(t) $

Analog ergibt sich die Teilnahmefaktor-gewichtete Erzeugung eines Erzeugungszählpunkts:

$ "WMG"_j(t) = "MG"_j(t) dot "PF"_j(t) $

==== Gemeinschaftsanteil und Eigenabdeckung

Der Gemeinschaftsanteil beschreibt die dem jeweiligen Verbrauchszählpunkt
zugeordnete Energiemenge aus der gemeinschaftlichen Erzeugung. Er wird
aus der Gesamterzeugung der Energiegemeinschaft und dem Teilnahmefaktor
des betrachteten Verbrauchszählpunkts bestimmt:

$ "CP"_i(t) = "MG"_"EG"(t) dot "PF"_i(t) $

Die Eigenabdeckung begrenzt den Gemeinschaftsanteil auf den
tatsächlich für die Energiegemeinschaft berücksichtigten Verbrauch des
betrachteten Zählpunkts. Sie entspricht daher dem jeweils kleineren
Wert aus Gemeinschaftsanteil und Teilnahmefaktor-gewichteten Verbrauch:

$ "CC"_i(t) = min("CP"_i(t), "WMC"_i(t)) $

Damit kann die Eigenabdeckung weder den verfügbaren Gemeinschaftsanteil noch den Teilnahmefaktor-gewichteten Verbrauch überschreiten.

Die Größen WMC, WMG, CP und CC werden im weiteren Verlauf als abgeleitete Daten bezeichnet.

=== Datenverfügbarkeit

Für die Evaluation wird ein fester Referenzzeitpunkt verwendet. Die Verfügbarkeit der Energiedaten wird relativ zu diesem Referenzzeitpunkt festgelegt. Die Datenbasis reicht bis einschließlich des Tages, der zwei Kalendertage vor dem Referenzzeitpunkt liegt. Daten des Vortages und des aktuellen Tages gelten somit als nicht verfügbar.

Beispielsweise gilt bei einem Referenzdatum von 02.01.2026:

- verfügbar: bis einschließlich 31.12.2025
- nicht verfügbar: 01.01.2026 und 02.01.2026

Diese Einschränkung wird dem Sprachmodell als Teil der Systembeschreibung mitgeteilt. Ein separater Toolaufruf zur Ermittlung des verfügbaren Datenzeitraums ist daher nicht vorgesehen. Fordert das Sprachmodell dennoch über ein Werkzeug Daten für einen nicht verfügbaren Zeitraum an, wird dies im Rahmen der Evaluation als fehlerhafter Toolaufruf bewertet.

Die Untersuchung der Verarbeitung tatsächlich fehlender oder lückenhafter Messdaten ist nicht Bestandteil der Evaluation. Dadurch bleibt die Datenverfügbarkeit für alle Orchestrierungsstrategien identisch und die Untersuchung konzentriert sich auf die Auswahl und Kombination der verfügbaren Werkzeuge.

== Tooldesign

Das Toolset wurde mit dem Ziel entwickelt, dem Sprachmodell einen kontrollierten Zugriff auf die für die Evaluation relevanten Energiedaten und Berechnungsoperationen zu ermöglichen. Bei der Auswahl der Werkzeuge wurde der Funktionsumfang auf die für die definierten Evaluationsaufgaben erforderlichen Operationen begrenzt. Werkzeuge für externe Datenquellen oder zusätzliche fachliche Bereiche wurden nicht berücksichtigt, da sie den Umfang der Werkzeuglandschaft und die Abhängigkeiten zwischen den einzelnen Werkzeugen erhöhen würden, ohne für die untersuchte Orchestrierung unmittelbar erforderlich zu sein.

=== Struktur der Werkzeuge

Die verfügbaren Werkzeuge werden als strukturierte Funktionsdefinitionen bereitgestellt. Für jedes Werkzeug werden eine eindeutige Bezeichnung, eine Beschreibung seiner Funktion sowie die erwarteten Parameter und deren Eigenschaften definiert. Die Struktur orientiert sich an der von OpenAI beschriebenen Schnittstelle für Tool-Aufrufe @UsingToolsOpenAI. Auf Grundlage dieser Definitionen kann das Sprachmodell ein geeignetes Werkzeug auswählen und einen strukturierten Aufruf mit den erforderlichen Argumenten erzeugen. Die umgebende Anwendung führt den Aufruf aus und stellt das Ergebnis anschließend wieder dem Sprachmodell zur Verfügung. Die konkrete Implementierung der Werkzeuge bleibt dabei vom Sprachmodell getrennt. Das Modell interagiert somit ausschließlich über die definierten Werkzeugschnittstellen.

Die für die Evaluation bereitgestellten Werkzeuge sind in @tab:tools zusammengefasst.

#figure(
  table(
    columns: (1fr, 1.5fr),
    align: (left, left),

    table.header([*Werkzeug*], [*Funktion*]),

    table.cell(colspan: 2, fill: luma(240))[*Datenzugriff*],

    [`get_participation_factor`],
    [Lädt den Teilnahmefaktor eines Zählpunkts.],

    [`get_current_power_consumption`],
    [Liefert den aktuellen Verbrauch eines Zählpunkts.],

    [`get_current_power_generation`],
    [Liefert die aktuelle Erzeugung eines Zählpunkts.],

    [`get_community_consumption`],
    [Lädt den Gesamtverbrauch der Energiegemeinschaft für einen definierten Zeitraum.],

    [`get_community_generation`],
    [Lädt die Gesamterzeugung der Energiegemeinschaft für einen definierten Zeitraum.],

    [`get_measured_energy`],
    [Lädt die gemessene Energie eines Zählpunkts für einen definierten Zeitraum.],

    table.cell(colspan: 2, fill: luma(240))[*Allgemeine Operationen*],

    [`get_statistical_value`],
    [Berechnet einen statistischen Kennwert einer Zeitreihe.],

    [`add_timeseries`],
    [Addiert mehrere Zeitreihen punktweise.],

    [`subtract_timeseries`],
    [Subtrahiert eine Zeitreihe punktweise von einer anderen.],

    [`multiply_timeseries`],
    [Multipliziert eine Zeitreihe mit einem Skalar.],

    [`divide_timeseries`],
    [Dividiert eine Zeitreihe durch einen Skalar.],

    [`min_timeseries`],
    [Bestimmt für jedes Messintervall den kleineren Wert mehrerer Zeitreihen.],

    [`max_timeseries`],
    [Bestimmt für jedes Messintervall den größeren Wert mehrerer Zeitreihen.],

    table.cell(colspan: 2, fill: luma(240))[*Fachliche Berechnungen*],

    [`get_weighted_measured_energy`],
    [Berechnet die teilnahmefaktor-gewichtete gemessene Energie eines Zählpunkts.],

    [`calculate_community_potential`],
    [Berechnet den Gemeinschaftsanteil aus der gemeinschaftlichen Erzeugung und dem Teilnahmefaktor.],

    [`calculate_community_coverage`],
    [Berechnet die Eigenabdeckung eines Verbrauchszählpunkts.],

    table.cell(colspan: 2, fill: luma(240))[*Darstellung*],

    [`create_energy_plot`],
    [Erzeugt ein Liniendiagramm aus einer oder mehreren Zeitreihen und stellt diese mit einer Legende dar.],

    table.cell(colspan: 2, fill: luma(240))[*Antwortgenerierung*],

    [`generate_answer`],
    [Erzeugt anhand ausgewählter Ergebnisse und einer frei definierbaren Nachricht eine finale Antwort.],

  ),
  caption: [Für die Evaluation bereitgestellte Werkzeuge],
) <tab:tools>

=== Zeitliche Parametrisierung

Für die zeitliche Interpretation der Testfälle wird ein fester Referenzzeitpunkt definiert. Dieser umfasst Datum, Uhrzeit und Zeitzone und wird dem Sprachmodell als aktueller Zeitpunkt vorgegeben. Dadurch können sowohl absolute als auch relative Zeitangaben eindeutig in konkrete Zeitintervalle überführt werden. Die Verwendung eines festen Referenzzeitpunkts stellt sicher, dass identische Anfragen unabhängig vom tatsächlichen Zeitpunkt der Versuchsdurchführung auf dieselben Zeitintervalle und damit auf identische Toolparameter abgebildet werden. Zeitintervalle werden durch einen Start- und Endzeitpunkt beschrieben, wobei der Startzeitpunkt inkludiert und der Endzeitpunkt exkludiert wird. Ein einzelner Kalendertag wird daher durch den Beginn dieses Tages und den Beginn des Folgetages beschrieben.

Zur Interpretation natürlicher Zeitangaben wurde zunächst die Verwendung eines separaten Werkzeugs zur Zeitauflösung betrachtet. Eine Voruntersuchung mit aktuellen Sprachmodellen zeigte jedoch, dass die verwendeten Modelle relative und komplexe Zeitangaben mit geeigneten Instruktionen zuverlässig in konkrete Zeitintervalle überführen können. Auf ein separates Zeitauflösungswerkzeug wurde daher verzichtet.

=== Datenzugriff

Die Datenzugriffswerkzeuge kapseln die konkrete Implementierung des Zugriffs auf die Energiedaten und stellen dem Sprachmodell ausschließlich die in @tab:tools definierten Datenzugriffe zur Verfügung. Die abgerufenen Zeitreihen werden in einer einheitlichen Struktur bereitgestellt und enthalten ausschließlich den Zeitstempel und den zugehörigen Energiewert in kWh. Die für die Auswahl der Datenquelle erforderlichen Informationen, insbesondere Zählpunkt und Energieart, werden über die Parameter des jeweiligen Werkzeugs festgelegt und sind nicht Bestandteil der zurückgegebenen Zeitreihe.

=== Verarbeitung von Zeitreihen

Zeitreihen werden nicht als vollständige numerische Daten direkt an das Sprachmodell übergeben. Der Zugriff auf Zeitreihen und deren numerische Verarbeitung erfolgt ausschließlich über die bereitgestellten Werkzeuge. Für die Darstellung von Zeitreihen steht zusätzlich das Werkzeug `create_energy_plot` zur Verfügung. Dieses kann eine oder mehrere bereits vorliegende Zeitreihen in einem Liniendiagramm darstellen und die einzelnen Zeitreihen anhand der übergebenen Bezeichnungen in einer Legende unterscheiden. Dadurch kann das Sprachmodell neben der Auswahl und Kombination von Datenzugriffs- und Berechnungswerkzeugen auch eine explizit angeforderte Visualisierung veranlassen.

=== Allgemeine Operationen

Die allgemeinen Operationen stellen elementare Verarbeitungsschritte für Zeitreihen bereit. Sie ermöglichen die punktweise Addition, Subtraktion, Multiplikation und Division sowie die Bestimmung des Minimums und Maximums mehrerer Zeitreihen. Zusätzlich können mit einem eigenen Werkzeug statistische Kennwerte einer Zeitreihe berechnet werden. Die Operationen arbeiten auf Zeitreihen mit identischer zeitlicher Struktur. Die Zeitstempel werden dabei als gemeinsamer Index verwendet, sodass die Berechnung jeweils für dasselbe Messintervall erfolgt.

=== Fachliche Berechnungen

Die fachlichen Berechnungen stellen höher abstrahierte domänenspezifische Funktionen bereit. Sie kapseln mehrere Datenzugriffe und Berechnungsschritte und ermöglichen dadurch die direkte Berechnung fachlicher Größen der Energiegemeinschaft. Dazu gehören die teilnahmefaktor-gewichtete gemessene Energie, der Gemeinschaftsanteil und die Eigenabdeckung. Die Unterscheidung zwischen allgemeinen Operationen und fachlichen Berechnungen bildet eine wesentliche Grundlage für den Vergleich der Orchestrierungsstrategien. Während höher abstrahierte Werkzeuge komplexere Berechnungsschritte direkt bereitstellen, können dieselben Berechnungen bei Verwendung elementarer Werkzeuge aus mehreren aufeinanderfolgenden Toolaufrufen zusammengesetzt werden.

=== Antwortgenerierung

Nach Abschluss der Orchestrierung werden die für die Beantwortung der Benutzeranfrage relevanten Ergebnisse an die Funktion `generate_answer` übergeben. Diese erzeugt auf Grundlage der Benutzeranfrage und der bereitgestellten Ergebnisse die finale sprachliche Antwort. Die Auswahl der an `generate_answer` übergebenen Ergebnisse erfolgt abhängig von der jeweiligen Orchestrierungsstrategie. Bei der pipelinebasierten Orchestrierung ist bereits bei der Definition der Pipeline festgelegt, welches Ergebnis für die finale Antwort verwendet wird. Bei der planbasierten Orchestrierung wird diese Auswahl gemeinsam mit dem Ablaufplan durch das Sprachmodell festgelegt. Bei der iterativen Orchestrierung entsteht die Auswahl erst während der schrittweisen Bearbeitung der Anfrage, da die benötigten Ergebnisse zu Beginn noch nicht vollständig bekannt sind.

Die einzelnen Ergebnisse werden innerhalb der Anwendung über eindeutige Ergebniskennungen referenziert. Dadurch können Zwischenergebnisse unabhängig von ihrer Position innerhalb des Orchestrierungsablaufs eindeutig adressiert und für nachfolgende Werkzeugaufrufe oder die finale Antwort verwendet werden. Die Ergebniskennungen werden von der umgebenden Anwendung vergeben und
sind unabhängig von der verwendeten Orchestrierungsstrategie.

== Orchestrierungsstrategien

Die Nutzung mehrerer Werkzeuge stellt nicht nur die Frage nach dem jeweils geeigneten Werkzeug, sondern auch nach der Organisation der einzelnen Werkzeugaufrufe. Sobald mehrere Werkzeuge innerhalb einer Aufgabe verwendet werden, können Abhängigkeiten zwischen den einzelnen Aufrufen entstehen. So kann beispielsweise die Ausgabe eines Werkzeugs als Eingabe für ein nachfolgendes Werkzeug benötigt werden. Die Auswahl der Werkzeuge muss daher gemeinsam mit ihrer Anordnung und Ausführungsreihenfolge betrachtet werden @luOrchDAGComplexTool2025.

In dieser Arbeit wird diese Organisation als Orchestrierung bezeichnet. Orchestrierung umfasst damit insbesondere die Auswahl und Anordnung von Werkzeugaufrufen, die Berücksichtigung von Abhängigkeiten sowie die Verarbeitung von Zwischenresultaten. Bei komplexeren Aufgaben kann eine solche Ausführung als strukturierte Kette oder als Graph von Werkzeugaufrufen dargestellt werden @paranjapeARTAutomaticMultistep2023
@luOrchDAGComplexTool2025.

Die betrachteten Ansätze unterscheiden sich insbesondere darin, wie stark die Ausführungsstruktur vorgegeben ist und zu welchem Zeitpunkt das LLM über den weiteren Ablauf entscheidet. In der Forschung werden unter anderem reaktive Verfahren, bei denen Entscheidungen schrittweise während der Ausführung getroffen werden, und planbasierte Verfahren, bei denen zunächst ein globaler Plan erzeugt wird, unterschieden @zheRobustEfficientTool2026. Auch die in dieser Arbeit betrachtete iterative Strategie basiert auf einer solchen schrittweisen Entscheidung unter Berücksichtigung bereits ausgeführter Werkzeugaufrufe @hernandezReActModularAgent2025.

Für die Untersuchung werden drei Orchestrierungsstrategien betrachtet: eine deterministische, eine planbasierte und eine iterative Strategie. Abbildung @orchestrierungsmethoden stellt die grundlegende Struktur der drei Ansätze gegenüber.

#figure(
  image("../figures/orchestrierungsmethoden.drawio.png", width: 90%),
  caption: [Vergleich der untersuchten Orchestrierungsstrategien],
) <orchestrierungsmethoden>

Die Abbildung verdeutlicht dabei insbesondere die zunehmende Flexibilität der Ausführungsentscheidung. Bei der deterministischen Strategie wird eine vorgegebene Pipeline ausgewählt und anschließend abgearbeitet. Bei der planbasierten Strategie erzeugt das LLM zunächst einen vollständigen Plan, dessen Schritte anschließend ausgeführt werden. Bei der iterativen Strategie entscheidet das LLM dagegen nach der Ausführung von Werkzeugen erneut über die benötigten nächsten Schritte. Die Strategien unterscheiden sich damit vor allem darin, auf welcher Ebene und zu welchem Zeitpunkt die Ausführungsentscheidungen getroffen werden.

=== Deterministische Orchestrierung

Die deterministische Orchestrierung stellt den einfachsten der betrachteten Ansätze dar. Die möglichen Pipelines und deren Abläufe sind vorgegeben. Das LLM erhält die Benutzeranfrage sowie die verfügbaren Werkzeuge und entscheidet, welche der vorgesehenen Pipelines für die Anfrage geeignet ist. Die ausgewählte Pipeline wird anschließend entsprechend ihrer festgelegten Reihenfolge abgearbeitet.

Die zentrale Eigenschaft dieses Ansatzes besteht darin, dass die Ausführungsstruktur nach der Auswahl der Pipeline nicht mehr durch das LLM verändert wird. Die Reihenfolge der Werkzeugaufrufe sowie die grundsätzliche Struktur des Ablaufs sind damit durch die jeweilige Pipeline bestimmt. Entscheidungen über alternative Ausführungswege finden während der Abarbeitung nicht statt.

Für die vorliegende Untersuchung ist insbesondere die Auswahl der richtigen Pipeline relevant. Die tatsächliche Ausführung der Werkzeuge ist hierfür nicht erforderlich. Entscheidend ist, ob das LLM anhand der Benutzeranfrage die Pipeline auswählt, die die für die Aufgabe erforderlichen Schritte enthält. Die Pipeline kann anschließend entsprechend der vorgegebenen Struktur ausgeführt werden.

Die deterministische Strategie bildet damit den Fall mit der stärksten Vorabstrukturierung. Die Ausführungsentscheidung des LLM beschränkt sich auf die Auswahl der geeigneten Pipeline, während die einzelnen Ausführungsschritte anschließend durch die vorgegebene Struktur bestimmt werden. Dies ermöglicht eine einfache und nachvollziehbare Ausführung, begrenzt jedoch gleichzeitig die Möglichkeit, den Ablauf an während der Ausführung gewonnene Informationen anzupassen.

=== Planbasierte Orchestrierung

Bei der planbasierten Orchestrierung wird der konkrete Ablauf nicht mehr durch eine vorgegebene Pipeline festgelegt. Stattdessen erzeugt das LLM zunächst einen vollständigen Plan für die Bearbeitung der Benutzeranfrage. Dieser Plan enthält die benötigten Werkzeugaufrufe und deren Reihenfolge.

Das Prinzip entspricht der in der Forschung beschriebenen Plan-and-Execute-Struktur, bei der zunächst ein globaler Plan erzeugt und anschließend ausgeführt wird @zheRobustEfficientTool2026. Eine explizite Darstellung von Werkzeugabhängigkeiten findet sich beispielsweise bei OrchDAG. Dort werden Werkzeugaufrufe als Knoten eines gerichteten azyklischen Graphen dargestellt, während Kanten die Abhängigkeiten zwischen den Aufrufen beschreiben @luOrchDAGComplexTool2025.

Für die vorliegende Implementierung wird der Plan als Folge von Werkzeugaufrufen dargestellt. Jeder Werkzeugaufruf erhält eine eindeutige ID. Diese entspricht bei dieser Methode seiner Position innerhalb des erzeugten Plans und ermöglicht die Referenzierung des zugehörigen Ergebnisses.

Die tatsächliche Ausführung des Plans ist für die Evaluation der Orchestrierungsentscheidung nicht erforderlich. Bewertet wird, ob das LLM die für die Anfrage erforderlichen Werkzeuge auswählt und diese in der richtigen Reihenfolge in den Plan aufnimmt. Der erzeugte Plan könnte anschließend Schritt für Schritt abgearbeitet werden. Durch die Referenzierung vorheriger Ergebnisse kann dabei festgelegt werden, welches
Ergebnis eines vorherigen Werkzeugaufrufs als Eingabe für einen nachfolgenden Aufruf dient.

Im Unterschied zur deterministischen Strategie muss damit nicht bereits vor der Anfrage festgelegt sein, welche konkrete Pipeline für die Aufgabe benötigt wird. Das LLM kann den Ablauf an die jeweilige Anfrage anpassen. Die wesentliche Entscheidung wird jedoch weiterhin vor der Ausführung der geplanten Werkzeugaufrufe getroffen.

Diese Eigenschaft unterscheidet die planbasierte von einer iterativen Orchestrierung. Bei einem vorab erzeugten Plan stehen die späteren Werkzeugergebnisse zum Zeitpunkt der Planung noch nicht zur Verfügung. Zhe et al. beschreiben entsprechend, dass vollständig vorab erzeugte Pläne gegenüber Abweichungen während der tatsächlichen Ausführung empfindlich sein können @zheRobustEfficientTool2026.

=== Iterative Orchestrierung

Die iterative Orchestrierung legt den konkreten Ausführungsweg nichtvollständig im Voraus fest. Stattdessen entscheidet das LLM schrittweise, welche Werkzeugaufrufe als Nächstes erforderlich sind. Die Ergebnisse bereits ausgeführter Werkzeuge werden dabei in die nächste Entscheidungsrunde einbezogen.

Dieses Vorgehen entspricht grundsätzlich dem in der Forschung beschriebenen Zusammenspiel von Planung, Aktion und Beobachtung. Beim ReAct-Prinzip werden die Ergebnisse einer Aktion als Beobachtung verwendet und können die anschließende Entscheidung beeinflussen @hernandezReActModularAgent2025. Hernández et al. beschreiben hierzu eine Architektur, in der ein Planner zunächst Aktionen bestimmt, diese ausgeführt werden und die erhaltenen Ergebnisse anschließend wieder an den Planner zurückgegeben werden. Auf Grundlage dieser Ergebnisse können weitere Aktionen geplant werden @hernandezReActModularAgent2025.

Die iterative Strategie der vorliegenden Arbeit folgt diesem Grundprinzip. Das LLM erstellt keinen vollständigen Plan für die gesamte Aufgabe. Statt dessen erzeugt es in jeder Iteration die für den nächsten Ausführungsschritt benötigten Werkzeugaufrufe. Die Werkzeugaufrufe werden anschließend ausgeführt und ihre Ergebnisse für die nächste Iteration bereitgestellt. Dadurch kann die Entscheidung über den weiteren Ablauf von den tatsächlich erhaltenen Ergebnissen abhängig gemacht werden.

Jeder Werkzeugaufruf erhält dabei eine eindeutige ID. Bei der iterativen Methode kodiert diese ID zusätzlich die Iteration, in der der Aufruf erfolgt. Nach der Ausführung wird dieselbe ID zur Referenzierung des erzeugten Ergebnisses verwendet. Dadurch können Ergebnisse eindeutig den zugehörigen Werkzeugaufrufen zugeordnet und in späteren Iterationen referenziert werden.

Die iterative Verarbeitung wird beendet, sobald das LLM den letzten für die Antwort erforderlichen Schritt erreicht. Hierfür steht das Werkzeug `generate_answer` zur Verfügung. Dieser Schritt entscheidet, welche der bisher erzeugten Ergebnisse für die anschließende Antwortgenerierung benötigt werden. Die Orchestrierung kann damit auch dann beendet werden, wenn nicht sämtliche verfügbaren Werkzeuge verwendet wurden.

Die Zahl der Iterationen ist für die vorliegende Implementierung auf sechs begrenzt. Innerhalb einer Iteration können mehrere Werkzeugaufrufe vorgesehen werden. Die Werkzeugausführung erfolgt anschließend anhand der erzeugten Aufrufliste.

Eine zentrale Eigenschaft der iterativen Strategie ist die Verarbeitung der Zwischenergebnisse. Dabei werden die Ergebnisse abhängig von ihrem Datentyp an das LLM übergeben. Insbesondere Zeitreihen würden den Kontext und die Token stark erhöhen. Das Ziel ist es die Zeitreihen mit zur verfügung stehenden Tools zu verarbeiten.

=== Ergebnisaufbereitung

Für alle drei Strategien wird eine gemeinsame grundlegende Werkzeug-Infrastruktur verwendet. Das LLM erhält die Benutzeranfrage, einen System-Prompt, die verfügbaren Werkzeuge mit ihren Definitionen, den Benutzerkontext, zeitliche Rahmenbedingungen, Datenverfügbarkeiten sowie fachliche Zusammenhänge und Berechnungsregeln.

Die Kommunikation mit dem lokalen Modell erfolgt über eine OpenAI-kompatible Schnittstelle zu Ollama. Die Wahl des Modells ist dabei unabhängig von der jeweiligen Orchestrierungsstrategie.

Die Ergebnisse von Werkzeugaufrufen werden in einer einheitlichen Struktur gespeichert. Neben der ID des Ergebnisses werden der verwendete Werkzeugaufruf, dessen Argumente und der Status der Ausführung gespeichert. Bei einer erfolgreichen Ausführung wird zusätzlich das Ergebnis des Werkzeugs abgelegt. Bei einem Fehler wird stattdessen die aufgetretene Fehlermeldung gespeichert.

Für die iterative Orchestrierung werden diese Ergebnisse anschließend für die nächste LLM-Iteration aufbereitet. Dabei werden einfache numerische Ergebnisse wie ganzzahlige oder reelle Werte mit ihrem konkreten Wert bereitgestellt. Zeitreihendaten werden dagegen nicht vollständig an das LLM übergeben. Stattdessen werden der ausgeführte Werkzeugaufruf einschließlich seiner Argumente sowie der Ergebnistyp `timeseries` übergeben. Das LLM erhält damit insbesondere Informationen darüber, welches Werkzeug mit welchen Parametern ausgeführt wurde und dass das Ergebnis eine Zeitreihe darstellt, nicht jedoch die einzelnen Werte der Zeitreihe.

Diese Einschränkung wurde gewählt, um die Übergabe umfangreicher numerischer Zeitreihendaten in den Kontext des LLM zu vermeiden. Wie im Stand der Forschung beschrieben, können längere numerische Zeitreihen einen erheblichen Tokenaufwand verursachen und gleichzeitig Schwierigkeiten bei der Verarbeitung zeitlicher, dimensionaler oder frequenzbezogener Merkmale hervorrufen @liuPictureWorthThousand. Liu et al. zeigen für ein untersuchtes Zeitreihenbeispiel, dass die numerische Repräsentation bis zu 60.000 Input-Tokens umfassen kann. Gleichzeitig untersuchen sie mit VL-Time eine alternative visuelle Repräsentation, die den benötigten Kontext deutlich reduziert @liuPictureWorthThousand.

Die in dieser Arbeit gewählte Ergebnisaufbereitung verfolgt einen anderen Ansatz. Die Zeitreihe selbst bleibt in der Werkzeug- beziehungsweise Ausführungsschicht verfügbar, wird jedoch nicht als vollständige numerische Folge in den Kontext des LLM aufgenommen. Dadurch kann das LLM weiterhin erkennen, dass ein entsprechender Werkzeugaufruf erfolgreich eine Zeitreihe bereitgestellt hat und auf welchen Zeitraum sich der Aufruf bezieht. Die Verarbeitung der eigentlichen Zeitreihendaten erfolgt dagegen außerhalb des LLM-Kontexts.

Auch andere nicht-numerische oder umfangreiche Ergebnisse werden nicht zwangsläufig vollständig an das LLM übergeben. Bei erzeugten Plots wird beispielsweise lediglich der Ergebnistyp `plot` als Information für die weitere Orchestrierung bereitgestellt. Die eigentliche Darstellung wird damit nicht Bestandteil des textuellen Kontexts der nächsten Orchestrierungsiteration.

=== Gemeinsame Konfiguration und Messgrößen

Um die drei Strategien möglichst vergleichbar zu untersuchen, werden weitgehend identische System-Prompts verwendet. Die allgemeinen Informationen und die grundlegende Struktur der Werkzeugbeschreibungen bleiben über die Methoden hinweg gleich. Unterschiede bestehen dort, wo sie für die jeweilige Orchestrierungsstrategie erforderlich sind. Die deterministische Strategie verwendet aufgrund der vorgegebenen Pipelines eine entsprechend angepasste Werkzeugbeschreibung.

Für jeden LLM-Aufruf werden die Laufzeit, die Anzahl der Input-Tokens, die Anzahl der Output-Tokens, die Gesamtzahl der Tokens sowie die Finish Reason erfasst. Für die LLM-Aufrufe wird ein Timeout von 120 Sekunden verwendet. Bei der iterativen Strategie werden diese Werte zusätzlich für jede Iteration separat gespeichert und anschließend zu einer Gesamtnutzung aggregiert.

Die drei Strategien unterscheiden sich damit gezielt in der Organisation der Werkzeugausführung, während die übrige technische Grundlage möglichst vergleichbar gehalten wird. Die deterministische Strategie bildet dabei den Fall einer vorgegebenen Ausführungsstruktur, die planbasierte Strategie einen durch das LLM erzeugten Ablauf und die iterative Strategie eine schrittweise, auf Zwischenergebnissen basierende Orchestrierung.

== Modellauswahl

Für die Evaluation werden drei Modelle ausgewählt, die unterschiedliche Voraussetzungen hinsichtlich lokaler Ressourcen und Modellbereitstellung repräsentieren. Ziel der Auswahl ist dabei nicht, die gesamte Größenabstufung einer Modellfamilie zu untersuchen, sondern den Einfluss unterschiedlicher Modellcharakteristika auf die Wirksamkeit der untersuchten Orchestrierungsmethoden zu betrachten. Hierzu werden mit Qwen3:8B und Qwen3:30B zwei lokal ausführbare Modelle derselben Modellfamilie sowie mit GPT-5.4 mini ein über eine API bereitgestelltes Cloud-Modell verwendet. Die wesentlichen technischen Merkmale der Modelle sind in @tab:modelselection dargestellt.

#figure(
  table(
    columns: (auto, 1fr, 1fr, auto),
    align: (left, center, center, center, center),

    table.header([*Merkmale*], [*qwen3:8b*], [*qwen3:30b*], [*gpt-5.4-mini-2026-03-17*]),

    [Parameter [Mrd]], [8,2], [30,5], [n.v.],
    [Quantisierung], [Q4_K_M], [Q4_K_M], [n.v.],
    [Speichergröße [GB]], [5,2], [18], [n.v.],
    [Maximales Kontextfenster], [40.960], [262.144], [400.000],
    [Ausführung], [lokal], [lokal], [API]

  ),
  caption: [Modellauswahl für Orchestrierung],
) <tab:modelselection>

*Anmerkung:* n. v. = nicht veröffentlicht.

=== Lokale Modelle

Die beiden Qwen3-Modelle wurden ausgewählt, um unterschiedliche Anforderungen an die Ressourcen einer lokalen Ausführungsumgebung abzubilden. Qwen3:8B repräsentiert dabei ein vergleichsweise ressourcenarmes Modell, das aufgrund seiner geringeren Parameterzahl auch auf Systemen mit begrenzten GPU- oder Arbeitsspeicherressourcen betrieben werden kann. Qwen3:30B stellt demgegenüber ein deutlich größeres Modell dar, dessen Ausführung leistungsfähigere Hardware erfordert. Beide Modelle stammen aus derselben Modellfamilie und werden mit derselben Quantisierung ausgeführt. Dadurch kann insbesondere untersucht werden, ob die höhere Modellkapazität des 30B-Modells gegenüber dem 8B-Modell einen zusätzlichen Nutzen bei der Bearbeitung der untersuchten Tool-basierten Aufgaben bietet und in welchem Verhältnis dieser mögliche Vorteil zur Verwendung unterschiedlicher Orchestrierungsmethoden steht.

Die Auswahl stellt bewusst keine vollständige Abdeckung der verfügbaren Qwen3-Modellgrößen dar. Kleinere beziehungsweise zwischen den beiden gewählten Modellen liegende Varianten wie Qwen3:4B und Qwen3:14B wurden nicht in die Evaluation aufgenommen. Ziel der Untersuchung ist nicht die Bestimmung eines Zusammenhangs zwischen Parameterzahl und Leistungsfähigkeit über die gesamte Modellfamilie hinweg. Stattdessen sollen zwei deutlich unterschiedliche lokale Ressourcenszenarien gegenübergestellt werden. Die zusätzliche Untersuchung weiterer Modellgrößen würde den Evaluationsumfang erhöhen, ohne für die zentrale Fragestellung nach dem Einfluss der Orchestrierung einen vergleichbaren zusätzlichen Erkenntnisgewinn zu erwarten.

Ein weiteres Auswahlkriterium für die lokalen Modelle war die vollständige Ausführbarkeit innerhalb des verfügbaren GPU-Speichers. Dadurch können beide Modelle unter vergleichbaren lokalen Bedingungen evaluiert werden, ohne dass für die Verarbeitung auf externe Rechenressourcen zurückgegriffen werden muss.

=== Cloud-Modell

Als dritter Modelltyp wird GPT-5.4 mini in der versionierten Modellvariante `gpt-5.4-mini-2026-03-17` eingesetzt. Damit wird neben den beiden lokalen Modellen ein Cloud-Modell berücksichtigt, dessen Ausführung über eine API erfolgt. GPT-5.4 mini wurde insbesondere aufgrund seiner Eignung für Tool-basierte und agentische Anwendungen ausgewählt. OpenAI positioniert das Modell ausdrücklich für Coding, Computer Use und Subagents und dokumentiert unter anderem die Unterstützung von Function Calling und Structured Outputs. In den vom Hersteller veröffentlichten Evaluationen erreicht GPT-5.4 mini zudem hohe Ergebnisse bei Tool-Calling-Aufgaben. @GPT54MiniModel

Die Verwendung eines Cloud-Modells erweitert die Untersuchung über die lokale Qwen3-Modellfamilie hinaus. Dadurch kann untersucht werden, ob die beobachteten Unterschiede zwischen den Orchestrierungsmethoden auch bei einem leistungsfähigen proprietären Modell auftreten. Da für GPT-5.4 mini unter anderem die Anzahl der Modellparameter, die Quantisierung und die Größe der Modellgewichte nicht veröffentlicht werden, werden diese Merkmale in der Tabelle als nicht veröffentlicht gekennzeichnet.

Die Laufzeit des Cloud-Modells ist aufgrund der API-basierten Ausführung zudem nicht unmittelbar mit der Laufzeit der lokal ausgeführten Modelle vergleichbar. Während die lokale Laufzeit maßgeblich durch die verwendete Hardware und die lokale Inferenz beeinflusst wird, können bei der API-Ausführung unter anderem Netzwerkverzögerungen, Serverauslastung, API-Latenzen und weitere infrastrukturelle Faktoren auftreten. Die Laufzeitwerte werden daher entsprechend getrennt betrachtet und nicht als direkter Vergleich der reinen Modellinferenz interpretiert.

=== Vergleichbarkeit der Evaluation

Um den Einfluss der Modellwahl und der Orchestrierungsmethoden möglichst getrennt betrachten zu können, werden für alle drei Modelle dieselben Aufgaben, Prompts und verfügbaren Werkzeuge verwendet. Ebenso werden sämtliche untersuchten Orchestrierungsmethoden mit jedem Modell auf demselben Aufgabensatz ausgeführt. Unterschiede in den Evaluationsergebnissen können dadurch unter den gegebenen Versuchsbedingungen im Zusammenhang mit dem verwendeten Modell und der jeweiligen Orchestrierungsmethode betrachtet werden.

== Aufgabenauswahl

Für die Evaluation wurde ein Aufgabensatz mit insgesamt 90 Aufgaben erstellt. Dieser umfasst jeweils 30 Aufgaben der drei Aufgabentypen *Direkte Datenabfrage*, *Einzelquellenverarbeitung* und *Mehrquellenverarbeitung*. Die Aufgaben wurden so zusammengestellt, dass das verfügbare Toolset unter den jeweiligen Anforderungen der drei Aufgabentypen möglichst vollständig abgedeckt wird. Die Zuordnung der Aufgaben zu den Aufgabentypen erfolgte vor Beginn der Evaluation manuell anhand der für die Bearbeitung erforderlichen Tool- und Verarbeitungsschritte.

=== Direkte Datenabfrage

Bei direkten Datenabfragen werden Informationen angefordert, die unmittelbar durch einen oder mehrere einzelne Toolaufrufe ermittelt werden können. Werden mehrere Informationen abgefragt, können dafür auch mehrere Toolaufrufe erforderlich sein. Voraussetzung für die Einordnung in diesen Aufgabentyp ist jedoch, dass keine Abhängigkeit zwischen den einzelnen Toolaufrufen besteht und keine Verarbeitung der Ergebnisse mehrerer Quellen erforderlich ist.

=== Einzelquellenverarbeitung

Bei der Einzelquellenverarbeitung wird eine einzelne Datenquelle zunächst über ein Tool abgerufen und anschließend durch einen Verarbeitungsschritt in das geforderte Ergebnis überführt. Die Aufgaben umfassen dabei verschiedene Verarbeitungsoperationen und Darstellungsformen, darunter beispielsweise die Berechnung von Summen, Mittelwerten, Minimal- und Maximalwerten sowie die Veränderung und Visualisierung von Zeitreihen. Auch bei diesem Aufgabentyp können mehrere Ergebnisse innerhalb einer Aufgabe gefordert werden, sofern diese jeweils unabhängig voneinander aus einer einzelnen Quelle und einem Verarbeitungsschritt hervorgehen.

=== Mehrquellenverarbeitung

Die Mehrquellenverarbeitung erfordert die gemeinsame Verarbeitung von Informationen aus mehreren Quellen, um das geforderte Ergebnis zu bestimmen. Hierzu zählen beispielsweise die Addition oder Subtraktion von Verbrauchs- und Erzeugungsdaten sowie die Berechnung von Kennzahlen, bei denen mehrere Datenquellen miteinander verknüpft werden müssen. Ebenso können mehrere Ergebnisse innerhalb einer Aufgabe gefordert werden, sofern für deren Berechnung jeweils mehrere Quellen gemeinsam verarbeitet werden müssen. Im Vergleich zu den vorherigen Aufgabentypen stehen hierbei insbesondere die Abhängigkeiten zwischen mehreren Toolergebnissen im Mittelpunkt.

Die drei Aufgabentypen unterscheiden sich somit hinsichtlich der für ihre Bearbeitung erforderlichen Tool- und Verarbeitungsschritte. Die Einteilung stellt dabei keine allgemeingültige Bewertung der Schwierigkeit einer Aufgabe dar, sondern dient der systematischen Untersuchung unterschiedlicher Anforderungen an die Orchestrierung.

=== Aufgabenvarianten und Konsistenz

Bei der Erstellung des Aufgabensatzes wurden teilweise mehrere inhaltlich ähnliche Aufgaben aufgenommen. Diese unterscheiden sich beispielsweise hinsichtlich des verwendeten Zählpunkts, des abgefragten Zeitraums oder der konkreten Formulierung der Anfrage. Die Varianten stellen eigenständige Aufgaben dar und werden entsprechend separat bewertet.

Die Aufnahme ähnlicher Aufgaben basiert auf Beobachtungen aus vorangegangenen Testdurchläufen. Dabei zeigte sich, dass Modelle bei vergleichbaren Anfragen nicht immer konsistent reagieren und dieselbe Art von Aufgabe in unterschiedlichen Durchläufen unterschiedlich bearbeiten können. Durch die Verwendung mehrerer Varianten soll der Einfluss einzelner zufälliger Fehlleistungen auf die aggregierten Evaluationsergebnisse reduziert werden. Eine vollständige Eliminierung dieser Variabilität wird dadurch nicht angestrebt.

=== Unvollständige und nicht eindeutig beantwortbare Anfragen

Ein Teil der Aufgaben wurde bewusst so gestaltet, dass die Anfrage mit den zum jeweiligen Zeitpunkt verfügbaren Informationen nicht eindeutig bearbeitet werden kann. Hierzu gehören beispielsweise Anfragen, bei denen ein Zählpunkt nicht eindeutig spezifiziert ist, eine angeforderte Eigenschaft für den genannten Zählpunkt nicht vorliegt oder für die Anfrage notwendige Daten fehlen. Ebenso wurden Anfragen aufgenommen, deren Inhalt nicht durch das verfügbare Toolset abgedeckt wird.

Mit diesen Aufgaben wird untersucht, ob das Modell die fehlenden oder widersprüchlichen Informationen erkennt und angemessen darauf reagiert. Ist für eine Bearbeitung eine zusätzliche Information erforderlich, wird eine entsprechende Rückfrage erwartet. Ist die Anfrage mit den verfügbaren Werkzeugen nicht bearbeitbar, soll das Modell dies erkennen, anstatt eigenständig Annahmen zu treffen oder einen nicht passenden Toolaufruf auszuführen. Ein unpassender Toolaufruf beziehungsweise eine darauf basierende falsche Bearbeitung wird als Fehler bewertet.

== Bewertungskrieterien

#figure(
  table(
    columns: (1fr, 2fr),
    align: (left, left),

    table.header([*Kriterium*], [*Beschreibung*],),

    // korrekt
    [Toolauswahl korrekt], [Wurden die korrekten Tools ausgewählt?],
    [Argumente korrekt], [Wurden die Argumente korrekt übergeben?\ Trifft nicht zu, wenn Toolauswahl falsch ist.],
    [Korrekt], [Sind Toolauswahl, Argumente und Informationen für die Antwort korrekt?],
    
    // effizient
    [Toolauswahl effizient], [Wurden ausschließlich notwendige Toolaufrufe ausgewählt?\ Trifft nicht zu, wenn Toolauswahl falsch ist. Ausschließlich auf Toolauswahl beschränkt. Keine etwaigen Token durch Toolaufrufe selbst enthalten.],
    [Antwort effizient], [War die Antwort effizient],
    [Effizienz], [Sind Toolauswahl und Antwort effizient?],

    // usage
    [Gesamttokenverbrauch], [Wie viele Token sind instgesamt verbraucht worden? (Input + Output)],
    [Laufzeit], [Wie lange hat ausschließlich das Erstellen der Toolauswahl gedauert? Toolausführungszeit ist nicht enthalten.],

    // aggregierte Werte
    [Erfolgsrate], [korrekte gelöste Aufgaben / alle Aufgaben], // Precision?
    [Effizienzrate], [Effizient gelöste Aufgaben / alle Aufgaben],

    // Error
    [Error], [Timeout, Strukturfehler, anderer Fehler]
  ),
  caption: [Bewertungskriterien],
) <tab:evaluation>

- Jede Orchestrierungsmethode hat die Möglichkeit kein Tool auszuwählen was auch teilweise die korrekt Toolauswahl darstellt @liuWTUEVALWhetherorNotTool2025.
- Der mehrfache Durchlauf der selben Aufgabe kann vor allem bei kleineren Modellen zu unterschiedlichen Ergebnissen führen. Das messe ich hier aber nicht. Stattdessen werden einige ähnliche Aufgaben erstellt wobei sich die Inkonsistenz über mehrere Aufgaben verteilt und so direkten Einfluss auf die Erfolgsrate hat.


// Korrektheit: Hat der Orchestrator alle für die korrekte Beantwortung notwendigen Informationen beschafft und korrekt verarbeitet?
// Effizienz: Hat er dies mit möglichst wenigen bzw. möglichst passenden Toolaufrufen und Parametern getan?

== Versuchsablauf

Die Evaluation wird als vollständige Kombination aus den definierten Aufgaben, den ausgewählten Modellen und den untersuchten Orchestrierungsmethoden durchgeführt. Für jede Kombination aus Modell, Orchestrierungsmethode und Aufgabe wird genau ein Durchlauf ausgeführt. Bei 90 Aufgaben und den drei ausgewählten Modellen wird somit jede Aufgabe unter jeder Orchestrierungsmethode mit jedem Modell bearbeitet. Auf eine mehrfache Ausführung identischer Kombinationen wird aufgrund des hohen daraus resultierenden Evaluationsumfangs verzichtet. Die Berücksichtigung möglicher Inkonsistenzen im Modellverhalten erfolgt stattdessen durch die im Aufgabensatz enthaltenen inhaltlich ähnlichen Aufgabenvarianten.

Zu Beginn eines jeden Durchlaufs wird dem LLM die jeweilige Nutzeranfrage zusammen mit der für die Bearbeitung erforderlichen Systemanweisung und dem verfügbaren Toolset bereitgestellt. Zusätzlich erhält das Modell allgemeine Informationen über den zugrunde liegenden Datensatz sowie die vorhandenen Zählpunkte. Zu den allgemeinen Informationen gehören beispielsweise Einschränkungen hinsichtlich des verfügbaren Datenbestands. Dadurch verfügt das Modell über die für die Planung und Ausführung der jeweiligen Aufgabe relevanten Rahmenbedingungen.

Der weitere Ablauf unterscheidet sich abhängig von der eingesetzten Orchestrierungsmethode. Bei der deterministischen Orchestrierung wird ein einzelner LLM-Aufruf durchgeführt, in dem anhand der Nutzeranfrage die erforderlichen Pipelines ausgewählt werden. Die ausgewählten Pipelines werden anschließend ausgeführt. Welche der daraus resultierenden Toolergebnisse für die abschließende Antwort verwendet werden, ist durch die jeweilige Pipeline festgelegt und wird nicht durch das LLM bestimmt.

Bei der planbasierten Orchestrierung erzeugt das LLM in einem einzelnen Aufruf einen Plan für die Bearbeitung der Aufgabe. Neben den vorgesehenen Verarbeitungsschritten legt der Plan auch fest, welche der erzeugten Toolergebnisse für die anschließende Antwortgenerierung verwendet werden sollen. Die im Plan vorgesehenen Verarbeitungsschritte werden anschließend ausgeführt und die im Plan bestimmten Ergebnisse für die Antwortgenerierung bereitgestellt.

Bei der iterativen Orchestrierung kann die Aufgabe hingegen mehrere LLM-Aufrufe erfordern. Nach der Ausführung der vom LLM vorgeschlagenen Werkzeuge werden die daraus resultierenden Ergebnisse erneut an das LLM übergeben. Auf Grundlage dieser Ergebnisse entscheidet das Modell, ob weitere Toolaufrufe erforderlich sind oder die Aufgabe bereits ausreichend bearbeitet wurde. Dieser Ablauf wird wiederholt, bis das Modell keine weiteren Toolaufrufe mehr anfordert. Anschließend bestimmt das LLM, welche der vorliegenden Toolergebnisse für die Beantwortung der Nutzeranfrage relevant sind und für die abschließende Antwortgenerierung verwendet werden. Zeitreihendaten werden dabei nicht als Rohdaten an das LLM übergeben, sondern entsprechend der im Kapitel zur Orchestrierung beschriebenen Verarbeitung aufbereitet.

Während jedes Durchlaufs werden die Ergebnisse der Modell- und Toolinteraktionen sowie die für die spätere Evaluation relevanten Messwerte protokolliert. Die Erfassung der Laufzeit und des Tokenverbrauchs beschränkt sich dabei ausdrücklich auf die LLM-Aufrufe. Die Laufzeit von Toolaufrufen sowie weitere Verarbeitungsschritte der Orchestrierung werden nicht in diese Messwerte einbezogen. Bei den einstufigen Orchestrierungsmethoden entspricht die gemessene LLM-Laufzeit daher der Dauer des jeweiligen einzelnen LLM-Aufrufs. Beim iterativen Verfahren werden Laufzeit und Tokenverbrauch jedes einzelnen LLM-Aufrufs erfasst und anschließend zu einer Gesamtnutzung (`total_usage`) aggregiert. Der Ablauf entspricht somit konzeptionell einer Folge aus LLM-Aufruf, Toolausführung und erneuter LLM-Verarbeitung, bis keine weiteren Toolaufrufe erforderlich sind und die relevanten Ergebnisse für die abschließende Antwort bestimmt wurden.

Tritt während eines Durchlaufs ein technischer Fehler auf, wird die Bearbeitung der jeweiligen Aufgabe abgebrochen. Der Fehler wird für die spätere manuelle Bewertung protokolliert. Eine erneute Ausführung derselben Kombination aus Aufgabe, Modell und Orchestrierungsmethode erfolgt nicht.

