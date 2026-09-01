#import "../globals.typ": *

#context if text.lang == "de" [
    = Einleitung
    <sec:intro>
] else [
    = Introduction
    <sec:intro>
]

== Problemfeld

Large Language Models (LLMs) werden zunehmend eingesetzt, um komplexe Informationsanfragen zu verarbeiten und Aufgaben auf Basis natürlicher Sprache zu bearbeiten @paranjapeARTAutomaticMultistep2023, @yangGPT4ToolsTeachingLarge2023. Durch die Integration externer Werkzeuge können Sprachmodelle beispielsweise auf strukturierte Daten zugreifen, Berechnungen durchführen oder weitere Verarbeitungsschritte auslösen @yangGPT4ToolsTeachingLarge2023, @duanMultitoolIntegrationApplication2024, @alazrakiMetaReasoningImprovesTool2025. Die dabei eingesetzte Orchestrierung bestimmt, welche Werkzeuge für eine Anfrage verwendet werden und wie deren Aufrufe miteinander koordiniert werden @huangMetaToolBenchmarkLarge2024, @liuWTUEVALWhetherorNotTool2025.

Energiegemeinschaften sind Zusammenschlüsse von Teilnehmenden, zu denen beispielsweise Privatpersonen, Gemeinden oder Unternehmen gehören können. Sie ermöglichen die gemeinsame Produktion, Speicherung und Nutzung von Energie mit dem Ziel, lokal erzeugte Energie möglichst effizient zu nutzen @gmbhWasSindEnergiegemeinschaften, @energiegemeinschaftenRechtsgrundlagenFurEnergiegemeinschaften. Für die Verwaltung und Analyse einer Energiegemeinschaft fallen dabei unter anderem Verbrauchs- und Erzeugungsdaten verschiedener Zählpunkte an. Auf Grundlage dieser Daten können beispielsweise Fragen zu aktuellen oder vergangenen Verbrauchs- und Erzeugungsmengen, Kennzahlen oder kombinierten Energieflüssen gestellt werden.

Eine mögliche Schnittstelle zur Nutzung dieser Daten stellt ein Chatbot dar, über den Teilnehmende ihre Anfragen in natürlicher Sprache formulieren können. Die Herausforderung besteht dabei nicht ausschließlich darin, die Anfrage inhaltlich zu verstehen. Das System muss zusätzlich bestimmen, welche Daten und Werkzeuge für die Bearbeitung benötigt werden und wie deren Ergebnisse zu einem korrekten Ergebnis zusammengeführt werden.

Dabei kann die Orchestrierung unterschiedlich stark autonomisiert werden. Bei einer deterministischen Orchestrierung werden die möglichen Verarbeitungsschritte weitgehend durch vorgegebene Regeln bestimmt. Autonomere Ansätze übertragen dagegen einen größeren Teil der Entscheidungsfindung auf das LLM, das beispielsweise selbst geeignete Werkzeuge auswählen, Verarbeitungsschritte planen oder auf Zwischenergebnisse reagieren kann. Dadurch können flexiblere Abläufe ermöglicht werden, gleichzeitig steigt jedoch der Entscheidungsspielraum des Modells und damit die Möglichkeit unerwarteter oder fehlerhafter Toolaufrufe @zhangGeospatialLargeLanguage2025, @alazrakiMetaReasoningImprovesTool2025, @liuWTUEVALWhetherorNotTool2025, @chenToolUseAlignment2024.

== Forschungsproblem

Mit zunehmendem Autonomiegrad kann ein LLM einen größeren Teil der Tool-Orchestrierung selbst übernehmen. Dies ermöglicht eine flexible Reaktion auf unterschiedliche und komplexe Anfragen, kann jedoch auch zu unnötigen oder fehlerhaften Toolaufrufen führen. Beispielsweise könnte ein Modell bereits vorhandene Informationen erneut abrufen oder Verarbeitungsschritte durchführen, die für die Beantwortung einer Anfrage nicht erforderlich sind. Dadurch können zusätzlicher Ressourcenbedarf und längere LLM-Laufzeiten entstehen.

Darüber hinaus können fehlerhafte Entscheidungen bei der Toolauswahl oder bei der Verarbeitung der Ergebnisse zu falschen Antworten führen. Insbesondere bei Aufgaben, für deren Bearbeitung mehrere Datenquellen miteinander verknüpft werden müssen, steigt die Anzahl der Entscheidungen, die während der Orchestrierung getroffen werden müssen. Gleichzeitig kann eine stark regelbasierte Orchestrierung zwar die möglichen Abläufe stärker kontrollieren, bei komplexeren oder nicht vollständig vorhersehbaren Anfragen jedoch weniger flexibel sein.

Für den Einsatz in Energiegemeinschaften ist eine zuverlässige Verarbeitung der Energiedaten von besonderer Bedeutung. Die aus den Daten abgeleiteten Informationen können beispielsweise als Grundlage für Entscheidungen der Teilnehmenden dienen. Fehlerhafte oder unvollständige Ergebnisse können dadurch zu falschen Einschätzungen der eigenen Energieerzeugung oder des Verbrauchs führen. Die Wahl einer geeigneten Orchestrierungsstrategie stellt somit einen Zielkonflikt zwischen der Flexibilität autonomer Verfahren und der Kontrolle durch vorgegebene Abläufe dar.

== Forschungsfrage

Wie beeinflusst der Grad der Autonomie bei der Tool-Orchestrierung von Large Language Models die Genauigkeit und den Ressourcenbedarf bei der Analyse von Zeitreihendaten in Energiegemeinschaften?

== Ziel der Arbeit

Ziel dieser Arbeit ist es, den Einfluss unterschiedlicher Autonomiegrade bei der Tool-Orchestrierung von Large Language Models auf die Bearbeitung datenbasierter Aufgaben in Energiegemeinschaften systematisch zu untersuchen. Hierzu werden deterministische, planbasierte und iterative Orchestrierungsansätze hinsichtlich ihrer Genauigkeit und ihres LLM-seitigen Ressourcenbedarfs verglichen. Dabei soll untersucht werden, ob ein höherer Autonomiegrad bei der Bearbeitung komplexerer Aufgaben einen Vorteil bietet und wie sich dieser auf die benötigten LLM-Ressourcen auswirkt.

== Hypothese

Es wird angenommen, dass ein höherer Autonomiegrad insbesondere bei Aufgaben mit mehreren voneinander abhängigen Verarbeitungsschritten Vorteile bei der flexiblen Bearbeitung bietet. Gleichzeitig wird erwartet, dass durch die zusätzliche Entscheidungsfreiheit des LLM der Ressourcenbedarf und die Wahrscheinlichkeit fehlerhafter Toolentscheidungen steigen können.

== Methodisches Vorgehen

Diese Arbeit verfolgt einen experimentellen und vergleichenden Forschungsansatz. Auf Basis einer Literaturrecherche werden zunächst bestehende Ansätze zur Orchestrierung von LLMs und zur Tool-Nutzung untersucht. Darauf aufbauend werden drei Orchestrierungsansätze mit unterschiedlichen Autonomiegraden implementiert und für die Untersuchung verwendet.

Für die experimentelle Evaluation wird ein Prototyp entwickelt, dessen Datenstruktur sich an einer realen Energiegemeinschaft orientiert. Die für die Versuche verwendeten Energiedaten werden synthetisch erzeugt und bilden ausgewählte Anforderungen einer realen Energiegemeinschaft ab. Die Evaluation umfasst 90 Aufgaben, die in direkte Datenabfragen, Einzelquellenverarbeitung und Mehrquellenverarbeitung unterteilt sind. Die Aufgaben werden mit einem kleineren lokalen Modell, einem größeren lokalen Modell und einem über eine API bereitgestellten Cloud-Modell bearbeitet. Dabei werden für alle Modelle und Orchestrierungsansätze dieselben Aufgaben, Prompts und Werkzeuge verwendet.

Die Ergebnisse der einzelnen Durchläufe werden anschließend hinsichtlich der zuvor definierten Bewertungskriterien ausgewertet. Ergänzend werden der Tokenverbrauch und die Laufzeit der LLM-Aufrufe erfasst, um den Ressourcenbedarf der verschiedenen Orchestrierungsansätze zu vergleichen. Auf diese Weise soll der Einfluss des Autonomiegrades unter kontrollierten Versuchsbedingungen untersucht und die Eignung der unterschiedlichen Ansätze für die Bearbeitung von Tool-basierten Aufgaben im Kontext von Energiegemeinschaften bewertet werden.