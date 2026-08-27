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

    table.cell(colspan: 2)[*Hardware*],

    [GPU], [NVIDIA RTX 3090, 24 GB VRAM],
    [CPU], [Intel Core i5-13600K],
    [Arbeitsspeicher], [32 GB DDR5],

    table.cell(colspan: 2)[*Software*],

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
    align: (left, left, left, center, center),

    table.header([*Abk.*], [*Bedeutung Englisch*], [*Bedeutung Deutsch*], [*Einheit*], [*Zeitbezug*],),

    // Basisdaten

    table.cell(colspan: 5)[*Basisdaten*],

    [PF], [Participation Factor], [Teilnahmefaktor], [–], [konstant],
    [CPC], [Current Power Consumption], [Aktueller Verbrauch], [kW], [aktuell],
    [CPG], [Current Power Generation], [Aktuelle Erzeugung], [kW], [aktuell],
    [MC], [Measured Consumption], [Gemessener Verbrauch], [kWh], [15 min],
    [MG], [Measured Generation], [Gemessene Erzeugung], [kWh], [15 min],
    [$"MC"_"EG"$], [Total Consumption], [Gesamtverbrauch], [kWh], [15 min],
    [$"MG"_"EG"$], [Total Generation], [Gesamterzeugung], [kWh], [15 min],

    table.cell(colspan: 5)[*Abgeleitete Daten*],

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

    table.cell(colspan: 2)[*Datenzugriff*],

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

    table.cell(colspan: 2)[*Allgemeine Operationen*],

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

    table.cell(colspan: 2)[*Fachliche Berechnungen*],

    [`get_weighted_measured_energy`],
    [Berechnet die teilnahmefaktor-gewichtete gemessene Energie eines Zählpunkts.],

    [`calculate_community_potential`],
    [Berechnet den Gemeinschaftsanteil aus der gemeinschaftlichen Erzeugung und dem Teilnahmefaktor.],

    [`calculate_community_coverage`],
    [Berechnet die Eigenabdeckung eines Verbrauchszählpunkts.],

    table.cell(colspan: 2)[*Darstellung*],

    [`create_energy_plot`],
    [Erzeugt ein Liniendiagramm aus einer oder mehreren Zeitreihen und stellt diese mit einer Legende dar.],

    table.cell(colspan: 2)[*Antwortgenerierung*],

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

== Modellauswahl

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr),
    align: (left, center, center, center, center),

    table.header(
      [*Modell*],
    [*Parameter [Mrd.]*],
    [*Quantisierung*],
    [*Speichergröße [GB]*],
    [*Maximales Kontextfenster [Token]*]
    ),

    // table.cell(colspan: 5)[*Lokal*],

    [qwen3:4b], [4,0], [Q4_K_M], [2,5], [262144],
    [qwen3:8b], [8,2], [Q4_K_M], [5,2], [40960],
    [qwen3:14b], [14,8], [Q4_K_M], [9,3], [40960],
    [qwen3:30b], [30,5], [Q4_K_M], [18], [262144],

    // table.cell(colspan: 5)[*API*],

    // [gpt], [], [], [], [],

  ),
  caption: [Modellauswahl für Orchestrierung],
) <tab:modelselection>

gewähltes Kontextfenster für alle Modelle: 32768

// Modelle für Bildanalyse und Finalisierung

=== Lokale Modelle

// Auwahlkriterien
// Ein weiteres Auswahlkriterium war die vollständige Ausführbarkeit der Modelle im verfügbaren GPU-Speicher.
// Modellgrößen
// Quantisierung
// Spezialisierungen?


=== API-Modell // Modell(e): ein großes oder zusätzlich ein kleineres das immer noch viel größer ist als die lokalen?

Die Laufzeit des API-Modells hängt von vielen Faktoren ab und ist daher nicht direkt vergleichbar:
- Netzwerk
- Serverauslastung
- API-Latenz
- möglicherweise Queueing
- unbekannte Hardware
- unbekannte Modellimplementierung

== Prompts

*Kernaufgaben*
- unterteilung in Kategorien
- separate und gemeinsame Bewertung
- SucessRate = korrekt gelöste Kernaufgaben / alle Kernaufgaben

- „Vergleiche den Verbrauch gestern mit der Prognose für morgen.“ // gestern und heute und morgen sind forecast!
- „Wie viel hat die Energiegemeinschaft im Januar verbraucht und was hätte dieser Verbrauch zu den Spotmarktpreisen gekostet?“ // Funktionen für Berechnung

// Output von Tokenmenge abziehen, weil unterschiedlich lange Antworten möglich sind aber nichts mit der Qualität zu tun haben müssen?

- nur Toolbeschreibung
- Mit System-Prompts: Nachfragen bei Mehrdeutigkeit, Umfang mit fehlenden Daten, usw.

== Bewertungskrieterien

#figure(
  table(
    columns: (1fr, 2fr),
    align: (left, left),

    table.header([*Kriterium*], [*Metriken*],),

    [Toolplanung], [korrekt, teilweise, falsch],
    [Parameterauswahl], [korrekt, teilweise, falsch],
    [Ergebnis], [korrekt, teilweise, falsch],
    [Effizienz], [korrekte notwendige Toolaufrufe / alle Toolaufrufe],
    // wenn weniger falsche Toolaufrufe -> auch guter Wert!
    [Tool Precision], [korrekte Toolaufrufe / alle Toolaufrufe],
    [Tool Recall], [korrekte notwendige Toolaufrufe / notwendige Toolaufrufe],
    [Tokenverbrauch], [Anzahl an Tokens ausschließlich für Toolplanung],
    [Laufzeit], [Inferenzzeit],
    [Robustheit], [Verhalten bei fehlenden Daten],
  ),
  caption: [Bewertungskriterien],
) <tab:evaluation>

=== Toolauswahl

- korrekte
- teilweise
- falsch
// - überflüssig/redundante

=== Parameter

- korrekt/optimal
- korrekt, aber suboptimal/überflüssig (z.B.: zu langer Zeitraum)
- falsch (sobald ein Paremter falsch - alles falsch?)

=== Rolle des Aufrufs // Aufruf: jeder Toolaufruf separat oder gesamte Ausführung?

- notwendig
- optonal/sinnvoll
- redundant
- unnötig

// Korrektheit: Hat der Orchestrator alle für die korrekte Beantwortung notwendigen Informationen beschafft und korrekt verarbeitet?
// Effizienz: Hat er dies mit möglichst wenigen bzw. möglichst passenden Toolaufrufen und Parametern getan?





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
