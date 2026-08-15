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

=== Hardware

- GPU: NVIDIA RTX 3090, 24 GB VRAM
- CPU: Intel Core i5-13600K
- RAM: 32 GB DDR5

=== Software

- Betriebssystem: Microsoft Windows 11 Pro, 64-Bit, Version 25H2
- NVIDIA-Treiber: Version 610.88
- Python: Version 3.11.14
- Ollama: Version 0.32.9
- OpenAI-Python-Paket: Version 2.30.0

=== Ausführungsbedingungen

// Ollama, OpenAI-Python-Bibliothek
Die Sprachmodelle werden über eine in Python implementierte Schnittstelle angesprochen. Für die lokale Inferenz wird Ollama verwendet. Sowohl die lokalen Modelle als auch das externe API-Modell werden über die OpenAI-Python-Bibliothek angesprochen, wodurch für beide Varianten eine weitgehend einheitliche Schnittstelle verwendet werden kann.

// Modelle vollständig in VRAM
Für die lokalen Modelle wird sichergestellt, dass diese vollständig im GPU-Speicher ausgeführt werden. Dadurch soll CPU-Offloading als zusätzlicher Einflussfaktor auf die Inferenzzeit ausgeschlossen werden @HandlingBigModels.

// GPU-Powerlimit
Für die Messungen wurde das Powerlimit der GPU auf 70 % des Standardwerts begrenzt. In vorbereitenden Tests mit identischen Eingaben zeigte sich unter den verwendeten Bedingungen kein nennenswerter Einfluss dieser Begrenzung auf die Inferenzzeit. Gleichzeitig wurde dadurch die thermische Belastung der GPU reduziert, wodurch mögliche thermisch bedingte Schwankungen der Taktfrequenz begrenzt werden sollten. Diese Einstellung wurde daher für die nachfolgenden Messungen beibehalten @HardwareSoftwareEnvironment.

// Warmup
Vor den eigentlichen Messungen werden zunächst Warm-up-Durchläufe durchgeführt, um mögliche Einflüsse der Initialisierung der Inferenzumgebung auf die gemessenen Laufzeiten zu reduzieren.

== Modelle

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

== Testdaten

=== Szenarien

*Datensätze*
- 365 Tage (für längere Zeitreihenabfragen)
- vollständig, keine Auffälligkeiten
- mehrere Anomalien (defekter ZP)
- fehlende Werte (Ausfälle)
- Verbrauchsvorhersage?

*Nutzer*
- Nutzer mit einem Zählpunkt für isolierte Problembehandlung
- Nutzer mit mehreren Zählpunkten und teils bewusst mehrdeutigen Situationen

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

=== Referenzzeit // festes Zeifenster für Zeitreihendaten - Referenzzeit -> Tools

Es wurde die Verwendung dynamisch generierter Testdaten untersucht. Da relative Zeitangaben abhängig vom tatsächlichen Ausführungszeitpunkt unterschiedliche Ergebnisse liefern würden, wurde stattdessen ein fester Testdatensatz mit einer vollständig definierten Referenzzeit verwendet. Diese umfasst neben dem Datum auch die Uhrzeit sowie die zugehörige Zeitzone und wird vom LLM als aktueller Zeitpunkt interpretiert. Dadurch können neben tagesbasierten auch stundenbasierte Zeitangaben, beispielsweise „vor drei Stunden“ oder „seit heute Morgen“, eindeutig aufgelöst werden. Gleichzeitig wird sichergestellt, dass identische Anfragen unabhängig vom tatsächlichen Zeitpunkt der Versuchsdurchführung stets zu denselben Zeitintervallen und damit zu identischen Toolparametern führen.

Diese Entscheidungen stellen sicher, dass Unterschiede zwischen den Orchestrierungsmethoden nicht durch die Verarbeitung natürlicher Zeitangaben beeinflusst werden und die Evaluation reproduzierbar durchgeführt werden kann.

== Tooldesign

Tools werden als strukturierte Schnittstellen mit einer eindeutigen Bezeichnung, Beschreibung sowie einer formalisierten Parameterdefinition bereitgestellt. Diese Darstellung orientiert sich an etablierten Ansätzen zur Tool-Nutzung durch Large Language Models, bei denen das Modell sowohl die Auswahl geeigneter Tools als auch die Generierung korrekter Argumente übernehmen muss. 

Orientiert an "OpenAI Developers Using Tools" @UsingToolsOpenAI

In dieser Arbeit werden die verfügbaren Werkzeuge daher als strukturierte Funktionsdefinitionen bereitgestellt. Für jedes Werkzeug werden unter anderem eine eindeutige Bezeichnung, eine Beschreibung seiner Funktion sowie die erwarteten Parameter und deren Eigenschaften definiert. Die konkrete Darstellung dieser Informationen wird im Folgenden festgelegt und bildet die Grundlage für die anschließende Toolauswahl und -ausführung durch das LLM.



=== OpenAI Tool Search // Anwendungsbeispiel strukturierter Umstetzung

Mit der OpenAI API gibt es die Möglichkeit tools als Json zu übergeben. Auf openai.com findet man die Dokumentation die unter anderem beschreibt wie genau die Json strukturiert sein muss. Auf genau diese Struktur wurde das zugrundeliegende Modell trainiert. Sobald man tools auf diese Weise übergibt verändert sich der Output und man bekommt falls notwendig eine Toolauswahl und Reasoning zurück. Man kann aber auch direkt Content generieren lassen den man als Antwort verwenden kann. Zum Beispiel wird dann nachgefragt wenn Informationen fehlen um ein Tool auszuführen.Ich habe ein Notebook erstellt um zu verstehen wie genau das funktioniert und wie gut das tatsächlich funktioniert. Dafür habe ich zwei Funktionen erstellt die Zeitreihen für Stromverbrauch und Stromproduktion erzeugen. Als Parameter habe ich Startzeit, Endzeit und Pattern definiert. Pattern definiert einfach nur ob es einen Haushalt oder eine Industrieanlage simulieren soll. Fragt
man nun nach dem Verbrauch der letzten Woche gibt das LLM die strukturiert den entsprechenden Funktionsnamen mit den notwendigen Parametern zurück. Mit diesen kann man dann den Funktionsaufruf starten und den Output wieder in das LLM einspeisen. Fehlt beim Input ein Zeitraum gibt das LLM keine Funktion zurück und fragt nach den Informationen die ihm noch fehlen. In diesem Fall wäre das der Zeitraum. Dieses Vorgehen sollte besser und zuverlässiger funktionieren als die Tools nur in der Message einzubinden, weil es auch speziell darauf trainiert wurde. Allerdings ist diese Anwendung sehr spezifisch und nicht so auf andere LLMs übertragbar. Es ist quasi schon eine fertige Lösung. Leider scheint diese Funktion nur auf den API-Zugriff beschränkt zu sein und ist somit nicht lokal nutzbar. Aber es kann als Inspiration dienen wie wir das selbst umsetzen wollen @UsingToolsOpenAI.

=== Datenbankzugriff

Für den Datenzugriff werden vordefinierte Funktionen verwendet, die dem Sprachmodell über eine strukturierte Schnittstelle zur Verfügung gestellt werden. Die Funktionen kapseln die konkrete Implementierung des jeweiligen Datenzugriffs und definieren die vom Modell bereitstellbaren Operationen sowie deren Parameter. Dadurch wird die Datenzugriffsschnittstelle auf zuvor festgelegte Operationen beschränkt, während die konkrete Datenhaltung von der Entscheidungslogik des Sprachmodells entkoppelt wird. Die Funktionen werden so gestaltet, dass sie die für die jeweiligen Testfälle benötigten Daten zuverlässig und in einer definierten Struktur zurückgeben @costaEnhancingAccuracyMaintainability2025.

=== Zeitauflösung

Zeitangaben in Benutzeranfragen müssen vor einem Toolaufruf eindeutig in konkrete Zeitintervalle überführt werden. Da Anfragen sowohl relative als auch komplex formulierte Zeitangaben enthalten können und sich diese auf unterschiedliche zeitliche Granularitäten beispielsweise Tage oder Stunden beziehen, stellt die zuverlässige Parametrisierung der Werkzeuge eine grundlegende Voraussetzung für eine reproduzierbare Evaluation dar.

Im System werden Zeitintervalle durch einen Start- und Endzeitpunkt beschrieben, wobei der Startzeitpunkt inkludiert und der Endzeitpunkt exkludiert ist. Ein einzelner Kalendertag wird daher durch den Beginn dieses Tages sowie den Beginn des Folgetages beschrieben.

Für die Zeitauflösung wurden zwei Ansätze betrachtet: die Verwendung eines dedizierten Werkzeugs zur Interpretation natürlicher Zeitangaben sowie die direkte Parametrisierung durch das LLM. Zur Bewertung beider Ansätze wurde eine Voruntersuchung mit aktuellen Sprachmodellen durchgeführt. Hierbei wurden repräsentative Anfragen mit relativen und komplexen Zeitangaben formuliert und die erzeugten Toolparameter analysiert.

Die Untersuchung zeigte, dass aktuelle Modelle mit geeigneten Instruktionen Zeitangaben zuverlässig in korrekte Zeitintervalle überführen können. Auf die Implementierung eines separaten Zeitauflösungswerkzeugs wurde daher verzichtet, wodurch die Komplexität der Werkzeuglandschaft reduziert werden konnte.
 
=== Bereitstellung und Interpretation von Zeitreihendaten // Bezug zu "Stand der Forschung - Zeitreihendaten" herstellen

Zeitreihendaten stellen besondere Anforderungen an die Interaktion zwischen LLM und Werkzeugen. Während Energiedaten häufig aus mehreren hundert bis tausend Messwerten bestehen, sind Large Language Models primär für die Verarbeitung natürlicher Sprache optimiert. Die direkte Übergabe vollständiger Zeitreihen als JSON oder Array erhöht den Tokenverbrauch erheblich und erschwert gleichzeitig die Identifikation relevanter Muster innerhalb langer Zahlenfolgen.

Grundsätzlich bestehen zwei Möglichkeiten, Zeitreihendaten für ein LLM bereitzustellen. Der erste Ansatz besteht darin, die Rohdaten direkt als strukturierte Werte zu übergeben und die Interpretation vollständig dem Sprachmodell zu überlassen. Alternativ können Zeitreihen vor der Übergabe aufbereitet werden, beispielsweise durch externe Analysewerkzeuge oder durch eine visuelle Darstellung in Form von Diagrammen. In der Literatur konnte bereits gezeigt werden, dass insbesondere Visualisierungen die Verarbeitung von Zeitreihen durch LLMs verbessern und gleichzeitig den Tokenverbrauch deutlich reduzieren können @liuPictureWorthThousand.

// Testergebnisse: Zeitreihendaten aus Stand der Forschung (vl-time_png_vs_array.ipynb, multiagent_energydata.pdf - 3.3. Eigener Test 1 ... und 3.4. Eigener Test 2 ...)
// Testergebnisse: Referenzzeit (resolve_time.ipynb)

Zur Bewertung dieser Ansätze wurde eine Voruntersuchung im Kontext synthetischer Energiedaten durchgeführt. Hierbei wurden Zeitreihen unterschiedlicher Länge sowohl als strukturierte JSON-Daten als auch als Liniendiagramme an das Modell übergeben und hinsichtlich Antwortqualität, Tokenverbrauch und Bearbeitungszeit verglichen. Zusätzlich wurde untersucht, inwieweit mehrere Zeitreihen gleichzeitig verarbeitet werden können.

Die Ergebnisse zeigten, dass beide Darstellungsformen eine korrekte Interpretation einfacher Verbrauchsmuster ermöglichen. Mit zunehmender Länge der Zeitreihen erwiesen sich Visualisierungen jedoch als deutlich effizienter hinsichtlich Tokenverbrauch und Verarbeitungszeit. Gleichzeitig zeigte sich, dass die eigentliche Mustererkennung nicht zwangsläufig durch das LLM erfolgen muss. Wiederkehrende Analysen, wie beispielsweise die Erkennung von Lastspitzen oder die Berechnung statistischer Kennwerte, können konsistenter und ressourcenschonender durch spezialisierte Analysewerkzeuge durchgeführt werden.

Auf Basis der Erkenntnisse aus dem Kapitel "Stand der Forschung" (2.x) wurde das Tooldesign so gewählt, dass das LLM Zeitreihen nicht grundsätzlich selbst interpretieren muss. Stattdessen stellen Werkzeuge je nach Anwendungsfall entweder aufbereitete Visualisierungen oder bereits analysierte Informationen bereit. Das LLM übernimmt damit primär die Orchestrierung sowie die sprachliche Interpretation der Ergebnisse, während rechenintensive oder wiederkehrende Zeitreihenanalysen an spezialisierte Werkzeuge ausgelagert werden.

=== Tools

// - Zeitabschnitt abfragen (Tage, Stunden?) und interpretieren (Plot?)
// - Zeitpunkt abfragen
// - Statistische Werte abfragen (einzeln oder gesammelt um Komplexität zu reduzieren)
// - Plot erzeugen und darstellen (mehrere)

== Orchestrierungsstrategien

Orchestrierungsmethoden - mehrere Modelle vergleichen @schickToolformerLanguageModels2023

== Bewertungskrieterien

- Tool Selection Accuracy
- unnötige/redundante Toolaufrufe
- Schrittanzahl
- Antwortqualität
- Laufzeit
- Tokenverbrauch

== Prompts

- nur Toolbeschreibung
- Mit System-Prompts: Nachfragen bei Mehrdeutigkeit, Umfang mit fehlenden Daten, usw.

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
