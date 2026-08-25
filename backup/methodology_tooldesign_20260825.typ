== Tooldesign

// Referenzzeit (resolve_time.ipynb)
Für die zeitliche Interpretation der Testfälle wurde eine feste Referenzzeit definiert. Diese umfasst neben dem Datum und der Uhrzeit auch die zugehörige Zeitzone und wird dem LLM als aktueller Zeitpunkt vorgegeben. Dadurch können neben tagesbasierten auch stundenbasierte relative Zeitangaben, beispielsweise „vor drei Stunden“ oder „seit heute Morgen“, eindeutig aufgelöst werden. Die Verwendung einer festen Referenzzeit stellt sicher, dass identische Anfragen unabhängig vom tatsächlichen Zeitpunkt der Versuchsdurchführung stets auf dieselben Zeitintervalle und damit auf identische Toolparameter abgebildet werden. Dadurch wird verhindert, dass Unterschiede zwischen den Orchestrierungsmethoden durch eine unterschiedliche zeitliche Interpretation der Testanfragen beeinflusst werden.

=== Struktur

// An Tool Use von OpenAI orientiert
Die verfügbaren Werkzeuge werden als strukturierte Funktionsdefinitionen bereitgestellt. Für jedes Werkzeug werden eine eindeutige Bezeichnung, eine Beschreibung seiner Funktion sowie die erwarteten Parameter und deren Eigenschaften definiert. Die Struktur orientiert sich an der von OpenAI für Tool-Aufrufe beschriebenen Darstellung. In dieser Schnittstelle werden Werkzeuge mit einer Beschreibung und einem formalisierten Schema für ihre Eingabeparameter bereitgestellt. Bei einer Anfrage kann das Modell daraufhin einen strukturierten Tool-Aufruf mit dem Namen des gewählten Werkzeugs und den entsprechenden Argumenten erzeugen. Die aufgerufene Funktion wird anschließend von der umgebenden Anwendung ausgeführt und ihr Ergebnis dem Modell zur weiteren Verarbeitung bereitgestellt @UsingToolsOpenAI.

// konkrete Designentscheidungen

=== Datenbankzugriff

Für den Datenzugriff werden vordefinierte Funktionen verwendet, die dem Sprachmodell über eine strukturierte Schnittstelle zur Verfügung gestellt werden. Die Funktionen kapseln die konkrete Implementierung des jeweiligen Datenzugriffs und definieren die vom Modell bereitstellbaren Operationen sowie deren Parameter. Dadurch wird die Datenzugriffsschnittstelle auf zuvor festgelegte Operationen beschränkt. Die konkrete Implementierung des Datenzugriffs bleibt dabei vom Sprachmodell getrennt. Die Funktionen werden so gestaltet, dass sie die für die jeweiligen Testfälle benötigten Daten zuverlässig und in einer definierten Struktur zurückgeben @costaEnhancingAccuracyMaintainability2025.

=== Zeitliche Parametrisierung

// start, end: datetime

Zeitangaben in Benutzeranfragen müssen vor einem Toolaufruf eindeutig in konkrete Zeitintervalle überführt werden. Da Anfragen sowohl relative als auch komplex formulierte Zeitangaben enthalten können und sich diese auf unterschiedliche zeitliche Granularitäten beispielsweise Tage oder Stunden beziehen, stellt die zuverlässige Parametrisierung der Werkzeuge eine grundlegende Voraussetzung für eine reproduzierbare Evaluation dar.

Im System werden Zeitintervalle durch einen Start- und Endzeitpunkt beschrieben, wobei der Startzeitpunkt inkludiert und der Endzeitpunkt exkludiert ist. Ein einzelner Kalendertag wird daher durch den Beginn dieses Tages sowie den Beginn des Folgetages beschrieben.

Für die Zeitauflösung wurden zwei Ansätze betrachtet: die Verwendung eines dedizierten Werkzeugs zur Interpretation natürlicher Zeitangaben sowie die direkte Parametrisierung durch das LLM. Zur Bewertung beider Ansätze wurde eine Voruntersuchung mit aktuellen Sprachmodellen durchgeführt. Hierbei wurden repräsentative Anfragen mit relativen und komplexen Zeitangaben formuliert und die erzeugten Toolparameter analysiert.

Die Untersuchung zeigte, dass aktuelle Modelle mit geeigneten Instruktionen Zeitangaben zuverlässig in korrekte Zeitintervalle überführen können. Auf die Implementierung eines separaten Zeitauflösungswerkzeugs wurde daher verzichtet, wodurch die Komplexität der Werkzeuglandschaft reduziert werden konnte.
 
// === Bereitstellung von Zeitreihendaten // (vl-time_png_vs_array.ipynb, multiagent_energydata.pdf - 3.3. Eigener Test 1 ... und 3.4. Eigener Test 2 ...)

// Für die Bereitstellung von Zeitreihendaten wurden unterschiedliche Repräsentationsformen betrachtet. In einer Voruntersuchung wurden Zeitreihen unterschiedlicher Länge sowohl als strukturierte JSON-Daten als auch als Liniendiagramme an die verwendeten Modelle übergeben. Dabei wurden die Antwortqualität, der Tokenverbrauch und die Bearbeitungszeit betrachtet. Zusätzlich wurde untersucht, inwieweit mehrere Zeitreihen gleichzeitig verarbeitet werden können.

// Die Ergebnisse zeigten, dass beide Repräsentationsformen bei kurzen Zeitreihen eine korrekte Interpretation einfacher Verbrauchsmuster ermöglichten. Mit zunehmender Länge der Zeitreihen erwiesen sich Visualisierungen hinsichtlich Tokenverbrauch und Bearbeitungszeit als vorteilhaft. Auf Grundlage dieser Ergebnisse werden längere Zeitreihen im untersuchten System nicht grundsätzlich als vollständige numerische Daten an das LLM übergeben, sondern je nach Anwendungsfall als Visualisierung oder in aufbereiteter Form bereitgestellt.

// Darüber hinaus werden wiederkehrende oder eindeutig definierte Analysen nicht ausschließlich dem Sprachmodell überlassen. Funktionen zur Berechnung statistischer Kennwerte oder zur Erkennung definierter Merkmale können die entsprechenden Verarbeitungsschritte übernehmen. Das LLM übernimmt in diesen Fällen die Auswahl und Orchestrierung der Werkzeuge sowie die Interpretation der zurückgegebenen Ergebnisse.

=== Tools
