#import "../globals.typ": *

#context if text.lang == "de" [
    == Weiterführende Arbeiten
    <sec:future_work>
] else [
    == Future Work
    <sec:future_work>
]

== Brainstorming

// cloud Modelle
- Untersuchung weiterer Modellgrößen.
- Vergleich weiterer lokaler LLMs.
- Untersuchung des Einflusses verschiedener Systemprompt-Formulierungen.
- Untersuchung expliziterer Zustandsrepräsentationen.
- Untersuchung einer deterministischen Duplikaterkennung für Tool Calls.
- Untersuchung unterschiedlicher Terminierungsstrategien.
- Vergleich eines vollständig LLM-gesteuerten Ansatzes mit einem hybriden Ansatz.
- Untersuchung des Einflusses des Iterationslimits.
- Untersuchung des Einflusses verschiedener Timeout-Werte.
- Untersuchung des Verhältnisses zwischen Modellgröße, Zuverlässigkeit und Laufzeit.
- Untersuchung des Einflusses der Aufgabenkomplexität auf die benötigte Modellgröße.
- Untersuchung, ob größere Modelle zwar zuverlässiger, aufgrund ihrer höheren Laufzeit aber weniger effizient sind.


- Zuverlässigkeit bei fehlenden Tools oder Nachfragen separat betrachten
