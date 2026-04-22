#import "../globals.typ": *

#context if text.lang == "de" [
    = Einleitung
    <sec:intro>
] else [
    = Introduction
    <sec:intro>
]

== Problemfeld

Large Language Models (LLMs) werden immer häufiger eingesetzt, um auch komplexe Informationsanfragen zu beantworten
#cite(<paranjape2023artautomaticmultistepreasoning>) #cite(<NEURIPS2023_e3936777>).
Durch Integration von externen Werkzeugen können Sprachmodelle beispielsweise auf Datenbanken zugreifen oder Berechnungen durchführen
#cite(<NEURIPS2023_e3936777>) #cite(<10629085>) #cite(<alazraki-rei-2025-meta>).
Die Entscheidungslogik (Orchestrierung) bestimmt, welche Tools wann und in welcher Reihenfolge aufgerufen werden
#cite(<huang2024metatoolbenchmarklargelanguage>) #cite(<10889153>).


Energiegemeinschaften sind Zusammenschlüsse von Teilnehmenden die Privatpersonen, Gemeinden oder Unternehmen sein können. Diese verwalten gemeinsam die Produktion, Speicherung und Nutzung von Energie, um diese effizient zu nutzen
#cite(<energiegemeinschaften_definition>) #cite(<energiegemeinschaften_rechtsgrundlagen>).
In diesem Kontext können Anfragen darin bestehen Analysen von Energiedaten oder Prognosen zu erstellen oder bei Entscheidungsfragen zu unterstützen.

Dabei gibt es eine entscheidende Herausforderung. Die Orchestrierung kann unterschiedlich stark autonomisiert sein. Das bedeutet wie viel Entscheidungsspielraum das LLM bei der Toolauswahl selbst hat und wie viel durch feste Regeln vorgegeben wird. Einfache deterministische Ansätze ermöglichen eine hohe Kontrolle. Autonomere Ansätze können flexibler auf komplexe Anfragen reagieren, sind dagegen schwerer vorhersehbar
#cite(<ZHANG2025104312>) #cite(<alazraki-rei-2025-meta>)
#cite(<10889153>) #cite(<chen-etal-2024-towards-tool>).

== Forschungsproblem

Mit zunehmendem Autonomiegrad können LLMs selbst entscheiden, welche Tools wann und in welcher Reihenfolge aufgerufen werden. Dies kann zwar komplexere Anfragen abdecken, aber auch zu ineffizienten Toolaufrufen führen und ist weniger kontrollierbar. 

Ineffizient wäre es zum Beispiel, wenn das LLM entscheidet die selben Daten mehrfach abzufragen oder andere unnötige Toolaufrufe zu machen die für die Antwort keinen Mehrwert bieten. Das führt zu höherem Ressourcenverbrauch und damit auch höhere Wartezeit und höhere Kosten als notwendig wäre. Im schlechtesten Fall können auch falsche Toolaufrufe gewählt werden die falsche oder unpräzise Antworten zur Folge haben können. Bei Häufung dieser Fälle gilt es zu überlegen ob man auf eine weniger autonome Orchestrierungsmethode setzt, um Effizienz und Kontrollierbarkeit zu gewähleisten
#cite(<10889153>).

Kontrollierbarkeit ist deshalb wichtig, weil davon die Richtigkeit der Daten abhängen kann und es nicht trivial ist wer wann welche Informationen erhält, wie sie aufbereitet werden und welche Handlungsempfehlungen daraus abgeleitet werden oder welche konkret durch das LLM gegeben werden. Was den Teilnehmenden empfohlen wird kann deren Entscheidungen beeinflussen dadurch starken Einfluss auf die jeweilige Energiegemeinschaft haben. Falsche Empfehlungen können dazu führen, dass der Verbrauch nicht sinnvoll an die verfügbare Energie angepasst wird. Und selbst wenn die Empfehlung korrekt ist, aber deshalb jeder zum gleichen Zeitpunkt hohe Verbraucher einschaltet kann das in Summe wieder zu schlechter Ausnutzung der verfügbaren Energie führen.

== Forschungsfrage

Wie beeinflusst der Grad an Autonomie in der Orchestrierung von Large Language Models die Qualität der Toolauswahl, Effizienz der Systemausführung und Kontrollierbarkeit des Systems im Kontext von Energiegemeinschaften?

== Ziel der Arbeit

Ziel ist dieser Arbeit ist es, den Einfluss des Autonomiegrades in der Orchestrierung von Large Language Models auf Effizienz, Toolauswahl und Kontrollierbarkeit systematisch zu untersuchen und daraus eine Entscheidungsgrundlage für geeignete Orchestrierungsstrategien im Kontext von Energiegemeinschaften zu bieten.

== Hypothese

Die Annahme ist, dass Orchestrierungsstrategien mit höherer Autonomie komplexere Anfragen flexibler verarbeiten können, jedoch zu geringerer Kontrollierbarkeit, höheren Ausführungskosten sowie höheren Laufzeiten führt.

== Methodisches Vorgehen

Diese Arbeit verfolgt einen analytischen und vergleichenden Forschungsansatz. Zunächst wird eine strukturierte Literaturrecherche durchgeführt, um den aktuellen Stand der Forschung zu bestehenden Orchestrierungsstrategien für LLM-Systeme zu ermitteln. Basierend darauf werden exemplarische Ansätze mit unterschiedlichen Autonomiegraden ausgewählt und systematisch analysiert.

Für den Vergleich werden Bewertungskriterien definiert, die sich an theoretischen Überlegungen und spezifischen Anforderungen des Anwendungsfeldes von Energiegemeinschaften orientieren. Anschließend folgt ein strukturierter Vergleich der gewählten Ansätze anhand dieser Kriterien sowie exemplarischer Anwendungsszenarien. Ziel ist es Stärken, Schwächen und Grenzen transparent herauszuarbeiten.

// == Aufbau der Arbeit (wird erwartet?)

