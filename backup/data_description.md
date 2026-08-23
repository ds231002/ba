# Daten

## Basic

| Abkürzung | EN | DE | Einheit | Granularität | Formel | Notiz
| - | - | - | - | - | - | -
| PF | Participation Factor | Teilnahmefaktor | | d || Faktor zwischen 0 und 1 in der Praxis nur aktueller Wert, tageweise Speicherung simulieren weil sonst viel nicht nachvollziebar? In der Praxis werden Resultate als Zeitreihen gespeichert. Könnte ich vermeiden wenn ich jeden Tag den selben Teilnahmefaktor als Zeitreihe ausgebe
| MC | Measured Consumption | Gemessener Verbrauch | kWh | 15 min || gesamte Energiegeimeinschaft sum(MC)
| MG | Measured Generation | Gemessene Erzeugung | kWh | 15 min || gesamte Energiegemeinschaft sum(MG)
| CPC | Current Power Consumption | Aktueller Verbrauch | kW ||| nur aktueller Wert
| CPG | Current Power Generation | Aktuelle Erzeugung | kW ||| nur aktueller Wert
| ASH | Astronomical Sun Hours | Astronomische Sonnenstunden | h | h
| ESDAP-1H-AT | EPEX Spot Day-ahead Price 1H AT || ct/kWh | h || awattar.at/tariffs/hourly

## Calculated

| Abkürzung | EN | DE | Einheit | Granularität | Formel | Notiz
| - | - | - | - | - | - | -
| CP | Community Potential | Gemeinschaftsanteil | kWh | 15 min | sum(MC) x PF | zugewiesen
| CC | Community Coverage | Eigenabdeckung | kWh | 15 min | MC solange nicht über CP | genutzt
| SG | Surplus Generation | Restüberschuss | kWh | 15 min | MG - MC | darf nicht negativ sein!
| WMC | Weighted Consumption | Gemessener Verbrauch gemäß Teilnahmefaktor | kWh | 15 min | WMCi​(t)=MCi​(t)⋅PFi​(t)
| WMG | Weighted Generation | Gemessene Erzeugung gemäß Teilnahmefaktor | kWh | 15 min | WMGi​(t)=MGi​(t)⋅PFi​(t)
| WSG | Weighted Surplus Generation | Restürberschuss gemäß Teilnahmefaktor | kWh | 15 min | SG x PF