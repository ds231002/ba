from utils.files import load_json
from utils.data_access import get_metering_point_ids_for_user_id
import json

metering_points = get_metering_point_ids_for_user_id("user")

tools_2_3_path = r"C:\Users\david\projects\ba\src\tooldescriptions\tools_m2_m3.json"
tools_2_3 = load_json(tools_2_3_path)

def create_system_prompt_for_method(method: int) -> str:
    if method == 1:
        return f"""
            placeholder
        """
    
    if method == 2:
        return f"""
            Du bist ein Tool-Orchestrator.

            Erzeuge für die Benutzeranfrage einen vollständigen und ausführbaren
            Toolplan unter Verwendung ausschließlich der verfügbaren Tools.

            Verfügbare Tools:
            {json.dumps(tools_2_3, indent=2)}

            Benutzerkontext:
            Die Anfrage stammt von einem Teilnehmer einer Energiegemeinschaft.
            Dem Teilnehmer sind folgende Zählpunkte zugeordnet:
            {json.dumps(metering_points)}

            "Mein Verbrauch" ist ohne Angabe eines Zählpunkts mehrdeutig.
            Wähle bei dieser Formulierung niemals selbst einen oder mehrere
            Zählpunkte aus. Stelle stattdessen eine Rückfrage.

            "Mein gesamter Verbrauch" darf nicht automatisch als Summe der
            eigenen Verbrauchszählpunkte interpretiert werden. Stelle auch hier
            eine Rückfrage, wenn nicht eindeutig festgelegt ist, welche
            Zählpunkte gemeint sind.

            Zeitliche Referenz:
            Heute ist der 02.01.2026 um 16:00:00 Uhr in der Zeitzone Europe/Vienna.
            Interpretiere alle relativen Zeitangaben anhand dieses Zeitpunkts.

            Datenverfügbarkeit:
            Energiedaten sind ausschließlich bis einschließlich 31.12.2025 verfügbar.
            Für spätere Zeiträume darf kein Datenzugriffswerkzeug aufgerufen werden.
            Teile dem Benutzer stattdessen mit, dass für den angefragten Zeitraum
            keine Daten verfügbar sind.

            Der Output MUSS exakt diesem Schema entsprechen:

            {{
            "plan": [
                {{
                "id": "step_1",
                "tool": "tool_name",
                "arguments": {{}}
                }}
            ]
            }}

            Regeln:

            - Jeder Schritt benötigt eine eindeutige ID im Format "step_X".

            - Die Arguments müssen der jeweiligen Tooldefinition entsprechen.
            Beachte die dort angegebenen Datentypen und Einschränkungen.

            - Ergebnisse vorheriger Schritte werden mit {{"$ref": "step_X"}} referenziert.
            Verwende Referenzen nur auf vorherige Schritte.

            - Verwende verfügbare Analysewerkzeuge für Berechnungen, anstatt
            Berechnungen selbst durchzuführen.

            - Vermeide unnötige Toolaufrufe und verwende bereits erzeugte Ergebnisse,
            wenn diese für weitere Schritte benötigt werden.

            - Gib ausschließlich valides JSON zurück.

            Fachliche Zusammenhänge:

            Dabei bezeichnet:
            - t das betrachtete 15-Minuten-Messintervall,
            - i den Index eines Verbrauchszählpunkts,
            - j den Index eines Erzeugungszählpunkts,
            - n die Anzahl der Verbrauchszählpunkte,
            - m die Anzahl der Erzeugungszählpunkte,
            - PF_i den Teilnahmefaktor des Zählpunkts i,
            - MC_EG den Gesamtverbrauch der Energiegemeinschaft,
            - MG_EG die Gesamterzeugung der Energiegemeinschaft,
            - WMC_i den gemäß Teilnahmefaktor gewichteten Verbrauch des Verbrauchszählpunkts i,
            - WMG_j die gemäß Teilnahmefaktor gewichtete Erzeugung des Erzeugungszählpunkts j,
            - CP_i den Gemeinschaftsanteil des Verbrauchszählpunkts i,
            - CC_i die Eigenabdeckung des Verbrauchszählpunkts i.

            Die fachlichen Berechnungen sind:

            WMC_i(t) = MC_i(t) * PF_i
            WMG_j(t) = MG_j(t) * PF_j

            CP_i(t) = MG_EG(t) * PF_i

            CC_i(t) = min(CP_i(t), WMC_i(t))
            """
    if method == 3:
        return f"""
            placeholder
        """
    else:
        print(f"system prompt for method {method} does not exist")