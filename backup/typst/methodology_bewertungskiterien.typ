== Bewertungskriterien

#figure(
  table(
    columns: (auto, 1fr),
    align: (left, left),

    table.header([*Kriterium*], [*Bedeutung*]),

    // Korrektheit
    [Toolauswahlkorrektheit], [Wurden die korrekten Tools ausgewählt?],
    [Argumentkorrektheit], [Wurden die Argumente korrekt übergeben?\ Trifft nicht zu, wenn Toolauswahl falsch ist.],
    [Korrektheit], [Sind Toolauswahl und Argumente korrekt?],

    // Effizienz
    [Toolauswahleffizienz], [Wurden ausschließlich notwendige Toolaufrufe ausgewählt?\ Trifft nicht zu, wenn Toolauswahl falsch ist.],
    [Argumenteffizienz], [Wurden nur die notwendigen Argumente übergeben? Zum Beispiel zu langer Zeitraum abgefragt oder zu viele Ergebnisse für die Anwortgenerierung übergeben die nicht notwendig gewesen wären.],
    [Effizienz], [Sind Toolauswahl und Argumente effizient?],

    // Error
    [Fehlerrate], [Timeout = 2min, Strukturfehler, andere Fehler],

    // Ressourcen
    [Laufzeit], [ausschließlich LLM-Laufzeit: Toolausführung, Speicherung usw. exkludiert],
    [Tokens], [Gesamter Tokenverbrauch inklusive Input- und Outputtoken]

  ),
  caption: [Bewertungskriterien],
) <tab:evaluation_criteria>

- Jede Orchestrierungsmethode hat die Möglichkeit kein Tool auszuwählen was auch teilweise die korrekt Toolauswahl darstellt @liuWTUEVALWhetherorNotTool2025.
- Der mehrfache Durchlauf der selben Aufgabe kann vor allem bei kleineren Modellen zu unterschiedlichen Ergebnissen führen. Das messe ich hier aber nicht. Stattdessen werden einige ähnliche Aufgaben erstellt wobei sich die Inkonsistenz über mehrere Aufgaben verteilt und so direkten Einfluss auf die Erfolgsrate hat.
- Bei Fehlerrate ist mit andere Fehler alles gemeint. Ich habe alles in ein try except gepackt und wenn irgendetwas passiert wird das dort als Fehler ausgegeben. Strukturfehler ist wenn das llm etwas erzeugt das nicht der vorgegebenen Struktur entspricht und somit für meine folgenden Schritte nicht auslesbar ist. Zum Beispiel die Umwandlung von str in json und der entsprechende Zugriff darauf.

Tool wird benötigt, aber gar nicht aufgerufen
- weder korrekt noch effizient
- Wenn das LLM den korrekten Toolaufruf ableiten können sollte aber nachfragt und nach Bestätigung fragt wird das als korrekt aber nicht effizient gewertet

falsches Tool wird aufgerufen
- weder korrekt noch effizient

richtiges Tool mit falschem Parameter
- korrekt aber nicht effizient

Tool zweimal aufgerufen
- korrekt aber nicht effizient sofern es das richtige war

unnötiges Tool zwischen zwei notwendigen Tools
- korrekt aber nicht effizient

notwendige Tools in falscher Reihenfolge
- sofern Abhängigkeiten bestehen die von der Reihenfolge abhängen wird es als falsch und nicht effizient bewertet

Tool liefert korrektes Ergebnis, aber Modell interpretiert es falsch
- Wenn alle richtigen Ergebnisse aus den Tools zur Antwortgenerierung übergeben wurden wird das als korrekt gewertet. Wird etwas fehlinterpretiert und das führt dazu dass zwar alle korrekten Tools aufgerufen wurden aber deren notwendige Ergebnisse werden nicht übermittelt wird das als falsch gewertet

Toolaufruf schlägt technisch fehl
- das steht dann theoretisch in error und würde nochmal ausgeführt werden. Gescheiterte Toolaufrufe sind praktisch irrelevant. Wenn ein Fehler aufgetreten ist habe ich nach dem Fehler gesucht und ihn behoben und den Durchlauf nochmal gestartet, weil für den Fehlerhaften Toolaufruf nicht das llm verantwortlich ist sofern alles richtig übergeben wurde. Führen fehlerhafte Argumente zu einem Toolfehler wird das sehr wohl als Fehler gewertet.

Modell bricht ohne Antwort ab
- nicht korrekt und ineffizient

Modell fragt den Nutzer nach einer Information
- sofern die Rückfrage berechtigt aber nicht notwendig ist korrekt aber nicht effizient
- sofern die Rückfrage notwendig ist weil das llm sonst spekulieren müsste korrekt und effizient und sogar gewünscht

Modell verwendet kein Tool, obwohl keines benötigt wird
- gewünschtes verhalten, korrekt und effizient
- das llm hat die Möglichkeit kein Tool zu nutzen und stattdessen eine Rückfrage zu stellen oder zu schreiben dass die für die Anfrage keine passenden Tools zur Verfügung stehen