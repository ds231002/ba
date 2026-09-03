#import "../globals.typ": *

#context if text.lang == "de" [
    == Weiterführende Arbeiten
    <sec:future_work>
] else [
    == Future Work
    <sec:future_work>
]

Aufbauend auf den Ergebnissen bieten sich mehrere Ansätze für weiterführende Untersuchungen an. Dazu zählen die Evaluation weiterer Modelle und Modellgrößen sowie eine systematische Variation der Systemprompts. Darüber hinaus sollte untersucht werden, wie unterschiedliche Zustandsrepräsentationen, Terminierungsstrategien, Iterationsgrenzen und Timeout-Werte die Korrektheit und den Ressourcenbedarf beeinflussen.

Besonders interessant ist ein direkter Vergleich zwischen vollständig LLM-gesteuerter und hybrider Orchestrierung. Dabei könnte untersucht werden, ob sich der zusätzliche Entscheidungsspielraum autonomer Verfahren mit deterministischen Kontrollmechanismen kombinieren lässt. Insbesondere die Erkennung redundanter Toolaufrufe, die Begrenzung der Iterationsanzahl und die Behandlung von Timeouts bieten hierfür konkrete Ansatzpunkte.

Weiterführend wäre außerdem eine gezielte Untersuchung der Kombination aus Aufgabentyp und Orchestrierungsmethode sinnvoll. Dadurch könnte geprüft werden, ob höhere Autonomie bei bestimmten komplexen Aufgaben tatsächlich einen Vorteil gegenüber stärker deterministischen Verfahren bietet. Ebenso könnte untersucht werden, in welchem Verhältnis die durch höhere Autonomie entstehende Flexibilität zu den damit verbundenen zusätzlichen Ressourcenanforderungen und Fehlerquellen steht.