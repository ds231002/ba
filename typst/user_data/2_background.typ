#import "../globals.typ": *

#context if text.lang == "de" [
    = Grundlagen
    <sec:background>
] else [
    = Prerequisites
    <sec:background>
]

// 4-5 Seiten

== Large Language Models

Large Language Models (LLMs) sind Modelle der künstlichen Intelligenz, die auf großen Datensätzen trainiert werden und natürliche Sprache verarbeiten und erzeugen können. Moderne LLMs basieren überwiegend auf der Transformer-Architektur, die mithilfe des Attention-Mechanismus Zusammenhänge zwischen verschiedenen Teilen eines Eingabekontexts berücksichtigen kann @kelbertWieFunktionierenLLMs2024.

Bei der Verarbeitung wird ein Text zunächst in kleinere Einheiten, sogenannte Tokens, zerlegt. Diese werden anschließend in numerische Vektorrepräsentationen überführt und vom Modell verarbeitet. Während der Inferenz erzeugt das Modell seine Ausgabe schrittweise, indem es auf Grundlage des bisherigen Kontexts Wahrscheinlichkeiten für mögliche nächste Tokens berechnet und daraus das jeweils nächste Token bestimmt. Die erzeugte Ausgabe entsteht somit nicht durch das Ausführen einer fest vorgegebenen Programmabfolge, sondern durch die schrittweise Vorhersage von Tokens @kelbertWieFunktionierenLLMs2024.

Unter *Inferenz* wird dabei die Anwendung eines bereits trainierten Modells auf neue Eingabedaten verstanden. Das Modell nutzt die während des Trainings erlernten Parameter, um auf Grundlage einer Eingabe eine Ausgabe zu erzeugen @kelbertWieFunktionierenLLMs2024.

Für die vorliegende Arbeit ist insbesondere relevant, dass ein LLM neben natürlichsprachlichen Antworten auch strukturierte Ausgaben erzeugen kann. Eine solche Ausgabe kann beispielsweise die Bezeichnung eines aufzurufenden Werkzeugs und die dafür vorgesehenen Argumente enthalten. Dadurch kann das LLM in einen softwaregestützten Verarbeitungsablauf eingebunden werden. Die eigentliche Ausführung von Funktionen oder der Zugriff auf externe Daten erfolgt dabei jedoch nicht durch das Sprachmodell selbst, sondern durch die umgebende Software.

== Tool Calling

Large Language Models können durch die Anbindung externer Werkzeuge auf Informationen und Funktionen zugreifen, die nicht allein durch das im Modell enthaltene Wissen bereitgestellt werden können. Werkzeuge können beispielsweise den Zugriff auf externe Datenquellen, Softwarefunktionen oder andere digitale Systeme ermöglichen. Dadurch können unter anderem aktuelle oder strukturierte Informationen abgefragt und Berechnungen oder weitere Verarbeitungsschritte außerhalb des Sprachmodells durchgeführt werden @huangMetaToolBenchmarkLarge2024, @patilBerkeleyFunctionCalling2025.

Damit ein LLM ein Werkzeug verwenden kann, wird dieses über eine strukturierte Beschreibung bereitgestellt. Diese enthält unter anderem einen eindeutigen Namen, eine Beschreibung der bereitgestellten Funktion sowie die erwarteten Eingabeparameter. Auf Grundlage dieser Informationen kann das Modell entscheiden, ob ein Werkzeug benötigt wird, ein geeignetes Werkzeug auswählen und die dafür erforderlichen Argumente erzeugen @huangMetaToolBenchmarkLarge2024.

Der erzeugte Tool Call wird anschließend von einer ausführenden Umgebung verarbeitet. Diese übernimmt die tatsächliche Ausführung des Werkzeugs und stellt das daraus resultierende Ergebnis wieder für das LLM bereit. Das Ergebnis kann beispielsweise aus Text, strukturierten Daten oder einer Fehlermeldung bestehen. Es kann anschließend als neue Information in die weitere Verarbeitung einbezogen werden @huangMetaToolBenchmarkLarge2024.

Der grundlegende Ablauf lässt sich damit vereinfacht wie folgt beschreiben:

*Anfrage > Toolauswahl > Argumenterzeugung > Toolausführung > Ergebnis > weitere Verarbeitung*

Bei Aufgaben, für deren Bearbeitung mehrere Werkzeuge benötigt werden, kann dieser Ablauf wiederholt werden. Die einzelnen Werkzeugaufrufe können dabei voneinander abhängig sein, wenn das Ergebnis eines vorherigen Aufrufs als Eingabe für einen nachfolgenden Aufruf benötigt wird.

Für die Zuverlässigkeit eines solchen Systems sind daher mehrere Entscheidungen relevant. Neben der grundsätzlichen Entscheidung für oder gegen die Verwendung eines Werkzeugs muss das LLM das passende Werkzeug auswählen und dessen Parameter korrekt bestimmen. Bei mehreren aufeinanderfolgenden Aufrufen muss zusätzlich der bisherige Verarbeitungszustand berücksichtigt und das Ergebnis vorheriger Aufrufe korrekt in weitere Entscheidungen einbezogen werden. Die Forschung zur Toolnutzung betrachtet entsprechend nicht nur die Erzeugung einzelner Funktionsaufrufe, sondern zunehmend auch deren Verwendung in mehrstufigen und zustandsbehafteten Abläufen @huangMetaToolBenchmarkLarge2024, @patilBerkeleyFunctionCalling2025.

== Agenten und Autonomie

Ein KI-Agent kann als Softwaresystem verstanden werden, das innerhalb einer bestimmten Umgebung arbeitet, Informationen aus dieser Umgebung verarbeitet und Aktionen ausführen kann. Werkzeuge stellen dabei eine Möglichkeit dar, über die ein Agent Aktionen in seiner Umgebung ausführen oder auf externe Informationen zugreifen kann @fengLevelsAutonomyAI2025. Ein Agent kann beispielsweise ein LLM als zentrale Komponente verwenden und dieses mit Werkzeugen sowie einer ausführenden Umgebung verbinden.

Für die vorliegende Arbeit ist insbesondere der Begriff der *Autonomie* relevant. Feng et al. definieren den Autonomiegrad eines KI-Agenten als das Ausmaß, in dem dieser dafür ausgelegt ist, ohne Beteiligung eines Nutzers zu arbeiten. Dabei kann Autonomie als eigenständige Gestaltungseigenschaft eines Systems betrachtet werden und ist nicht unmittelbar mit dessen Fähigkeiten gleichzusetzen @fengLevelsAutonomyAI2025.

Übertragen auf die Tool-Orchestrierung bedeutet ein höherer Autonomiegrad, dass ein größerer Teil der Entscheidungen über den weiteren Ablauf an das LLM übertragen wird. Bei einer stark vorgegebenen Ausführung werden beispielsweise Werkzeuge und deren Reihenfolge durch die umgebende Software festgelegt. Bei einer stärker autonomisierten Ausführung kann das LLM dagegen selbst bestimmen, welches Werkzeug als Nächstes benötigt wird, welche Argumente verwendet werden und ob nach einem erhaltenen Ergebnis weitere Verarbeitungsschritte erforderlich sind.

Diese Unterscheidung bildet die Grundlage für die in dieser Arbeit untersuchten Orchestrierungsansätze. Die *deterministische Orchestrierung* legt den Ablauf weitgehend durch vorgegebene Regeln fest. Die *planbasierte Orchestrierung* überträgt dem LLM die Erstellung einer übergeordneten Abfolge von Verarbeitungsschritten, während deren Ausführung anschließend durch das System gesteuert wird. Bei der *iterativen Orchestrierung* wird die Entscheidung über den weiteren Ablauf dagegen schrittweise während der Ausführung getroffen. Das LLM erhält dabei die Ergebnisse vorheriger Werkzeugaufrufe und entscheidet auf dieser Grundlage über den nächsten Verarbeitungsschritt.

Der zunehmende Entscheidungsspielraum bedeutet dabei nicht automatisch eine höhere Leistungsfähigkeit. Mit einem größeren Anteil autonomer Entscheidungen steigen zugleich die Anforderungen an die Verarbeitung des bisherigen Zustands, die Auswahl geeigneter Werkzeuge, die Berücksichtigung bereits vorliegender Ergebnisse und die Erkennung des Abschlusses einer Aufgabe. Diese Aspekte sind insbesondere bei mehrstufigen Tool-Aufrufen relevant und bilden einen wesentlichen Bezugspunkt für die anschließende Untersuchung.