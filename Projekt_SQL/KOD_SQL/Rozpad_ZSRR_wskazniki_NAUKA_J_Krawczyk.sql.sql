/*
infoShare Academy
JDSZR6
projekt 1 - SQL
grupa: World-Data-Analysis
"Rozpad ZSRR"
wskazniki "Nauka"
Jonasz Krawczyk
*/

---------------- GLOWNY FILTR ----------------
CREATE VIEW v_primary_view AS
SELECT
	i.CountryName,
	i.IndicatorName,
	i."Year",
	ROUND(i.Value,3) AS wskaznik
FROM
	Indicators i
WHERE
	i.CountryName IN ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
	AND
	i.IndicatorName IN ('Researchers in R&D (per million people)', 'Technicians in R&D (per million people)', 'Patent applications, residents', 'Scientific and technical journal articles', 'Adult literacy rate, population 15+ years, both sexes (%)', 'Expenditure on education AS % of total government expenditure (%)', 'Research and development expenditure (% of GDP)')
	AND
	i."Year" > 1992
--DROP VIEW v_primary_view

/*celowo zostawiam tutaj widok; stosowanie podzapytania czy CTE mogloby bardzo zaciemnic obraz 
tego co jest istotne w dalszej czesci skryptu poniewaz z w/w "glownego filtra" korzystam wielokrotnie,
w wielu miejscach. na dodatek (po doprecyzowaniu celu projektu) filtr juz nie ulega zmianie dlatego
duzo wygodniej jest mi zapisac "FROM v_primary_view AS vp" zamiast wszedzie u¿ywaæ np.:

WITH main_filter AS
(
SELECT
	i.CountryName,
	i.IndicatorName,
	i."Year" ,
	ROUND(i.Value,3) AS wskaznik
FROM
	Indicators i
WHERE
	i.CountryName IN ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
	AND
	i.IndicatorName IN ('Researchers in R&D (per million people)', 'Technicians in R&D (per million people)', 'Patent applications, residents', 'Scientific and technical journal articles', 'Adult literacy rate, population 15+ years, both sexes (%)', 'Expenditure on education as % of total government expenditure (%)', 'Research and development expenditure (% of GDP)')
	AND
	i."Year" > 1992
)
SELECT
	(...)
FROM
	main_filter

Takze stosowanie tabeli tymczasowej wymagaloby powrot w to miejsce za kazdym razem,
gdy otwieram projekt. Nie ma to wiekszego sensu przy danych historycznych 
(z zalozenia niezmiennych) i do tego sprzed wielu lat.
*/
---------------- 1. Researchers in R&D (per million people) ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Researchers in R&D (per million people)"
ORDER BY
	"Year"
--danych jest malo; nie brac do funkcji rankujacej - nie nadaja sie.
--b) ilosc wystapien danego panstwa w bazie danych: (dla potwierdzenia czy wszystkie kraje sa wliczone)
SELECT
	DISTINCT 
	CountryName,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
ORDER BY
	CountryName
--moge wyznaczyc podstawowe statystyki, do podania w ramach ciekawostki
--wskazac srednia, maksymalna i minimalna wartosc w ramach ciekawostki
--a) wsrod grupy bez Polski
--MAX
SELECT
	CountryName,
	"Year",
	ROUND(MAX(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
UNION
--MIN
SELECT
	CountryName,
	"Year",
	ROUND(MIN(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
UNION
--AVG (bez Polski)
SELECT
	'grupa_bez_polski' AS CountryName,
	NULL AS "Year",
	ROUND(AVG(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
	AND 
	vp.CountryName IN NOT 'Poland'
--b)w Polsce
--MAX
SELECT
	'Polska_max' AS CountryName,
	"Year",
	ROUND(MAX(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
	AND 
	vp.CountryName IS 'Poland'
UNION
--MIN
SELECT
	'Polska_min' AS CountryName,
	"Year",
	ROUND(MIN(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
	AND vp.CountryName IS 'Poland'
UNION
--AVG (dla Polski)
SELECT
	'avg_Polski' AS CountryName,
	NULL AS "Year",
	ROUND(AVG(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Researchers in R&D (per million people)"
	AND 
	vp.CountryName IS 'Poland'
---------------- 2. Technicians in R&D (per million people) ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Technicians in R&D (per million people)"
--sytuacja jest podobna do wskaznika Researchers, tzn. danych jest malo; nie brac do funkcji rankujacej.
--b) ilosc wystapien danego panstwa w bazie danych: (dla potwierdzenia czy wszystkie kraje sa wliczone)
SELECT
	DISTINCT 
	CountryName,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
ORDER BY
	CountryName
--moge wyznaczyc podstawowe statystyki, do podania w ramach ciekawostki
--wskazac srednia, maksymalna i minimalna wartosc w ramach ciekawostki
--a) wsrod grupy bez Polski
--MAX
SELECT
	CountryName,
	"Year",
	ROUND(MAX(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
UNION
--MIN
SELECT
	CountryName,
	"Year",
	ROUND(MIN(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
UNION
--AVG (bez Polski)
SELECT
	'grupa_bez_polski' AS CountryName,
	NULL AS "Year",
	ROUND(AVG(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
	AND vp.CountryName IS NOT 'Poland'
--b)w Polsce
--MAX
SELECT
	'Polska_max' AS CountryName,
	"Year",
	ROUND(MAX(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
	AND vp.CountryName IS 'Poland'
UNION
--MIN
SELECT
	'Polska_min' AS CountryName,
	"Year",
	ROUND(MIN(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
	AND vp.CountryName IS 'Poland'
UNION
--AVG (dla Polski)
SELECT
	'avg_Polski' AS CountryName,
	NULL AS "Year",
	ROUND(AVG(wskaznik)) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Technicians in R&D (per million people)"
	AND 
	vp.CountryName IS 'Poland'
---------------- 3. Patent applications, residents ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Patent applications, residents"
	--AND CountryName = 'Azerbaijan'
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT
	DISTINCT 
	CountryName,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Patent applications, residents"
ORDER BY
	CountryName
--brakuje paru poczatkowych danych i paru od konca. 
--przeniose w te miejsca najblizsze dane dla danego kraju 
--pierwszy okres (1994) ogolnie
CREATE VIEW v_patent_applications_1994 AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Patent applications, residents"
	AND vp.year = 1994
UNION
--aby wliczyc Azerbaijan z 95go
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Patent applications, residents"
	AND 
	vp.year = 1995
	AND 
	vp.CountryName = 'Azerbaijan'
UNION
--aby wliczyc Turkmenistan z 96go
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Patent applications, residents"
	AND 
	vp.year = 1996
	AND 
	vp.CountryName = 'Turkmenistan'
ORDER BY
	CountryName
--DROP VIEW v_patent_applications_1994

/* wliczenie za pomoca widokow
--pierwszy okres (1995) Azerbaijan
CREATE VIEW v_patent_applications_1995_Azerbaijan AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM 
	v_primary_view AS vp
WHERE 
	vp.IndicatorName = "Patent applications, residents" 
	AND 
	vp.year = 1995 
	AND 
	vp.CountryName = 'Azerbaijan'
--SELECT * FROM v_patent_applications_1995_Azerbaijan

--pierwszy okres (1996) Turkmenistan
CREATE VIEW v_patent_applications_1996_Turkmenistan AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM 
	v_primary_view AS vp
WHERE 
	vp.IndicatorName = "Patent applications, residents" 
	AND 
	vp.year = 1996 
	AND 
	vp.CountryName = 'Turkmenistan'
--SELECT * FROM v_patent_applications_1996_Turkmenistan
*/
--drugi okres (2013)
CREATE VIEW v_patent_applications_2013 AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Patent applications, residents"
	AND vp.year = 2013
UNION
--aby wliczyc Turkmenistan z 99go
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Patent applications, residents"
	AND vp.year = 1999
	AND vp.CountryName = 'Turkmenistan'
ORDER BY
	CountryName
--DROP VIEW v_patent_applications_2013 

/*
--drugi okres (1999) Turkmenistan
CREATE VIEW v_patent_applications_1999_Turkmenistan AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM 
	v_primary_view AS vp
WHERE 
	vp.IndicatorName = "Patent applications, residents" 
	AND 
	vp.year = 1999 
	AND 
	vp.CountryName = 'Turkmenistan'
--SELECT * FROM v_patent_applications_1999_Turkmenistan*/
--ranking grupy bez Polski
SELECT
	pa13.CountryName,
	pa94.wskaznik AS wskaznik_1994,
	pa13.wskaznik AS wskaznik_2013,
	CASE
		WHEN pa13.wskaznik > pa94.wskaznik
		THEN ROUND(pa13.wskaznik / pa94.wskaznik,3)
		ELSE ROUND((pa13.wskaznik / pa94.wskaznik)-2,3)
	END AS zmiana_wskaznika,
	RANK () OVER (ORDER BY (ROUND(pa13.wskaznik / pa94.wskaznik-1,4))) AS punktacja
FROM
	v_patent_applications_1994 pa94
JOIN v_patent_applications_2013 pa13
ON
	pa94.CountryName = pa13.CountryName
WHERE
	pa13.CountryName IS NOT 'Poland'
ORDER BY
	zmiana_wskaznika desc
--wskaznik dla Polski
SELECT
	pa13.CountryName,
	pa94.wskaznik AS wskaznik_1994,
	pa13.wskaznik AS wskaznik_2013,
	ROUND(pa13.wskaznik / pa94.wskaznik,3) AS zmiana_wskaznika
FROM
	v_patent_applications_1994 pa94
JOIN v_patent_applications_2013 pa13
ON
	pa94.CountryName = pa13.CountryName
WHERE
	pa13.CountryName IS 'Poland'
---------------- 4. Scientific and technical journal articles ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Scientific and technical journal articles"
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT
	DISTINCT 
	CountryName ,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Scientific and technical journal articles"
ORDER BY
	CountryName
--z danymi wszystko w porzadku. tymrazem jednak zamiast zapisu wartosci z granicznych lat do widoku,
--zastosuje tabele tymczasowe. W zasadzie glownie dla wzbogacenia skryptu; przy danych historycznych
--ktore (teoretycznie) nie powinny sie zmieniac, stosowanie widoku wydaje sie bezpieczne 
--pierwszy okres (1993)
CREATE TEMP TABLE t_scientific_articles_1993 AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Scientific and technical journal articles"
	AND 
	vp.year = 1993
ORDER BY
	CountryName
--drop table t_scientific_articles_1993

--drugi okres (2011)
CREATE TEMP TABLE t_scientific_articles_2011 AS
SELECT
	vp.CountryName ,
	vp.IndicatorName ,
	vp."Year" ,
	ROUND(vp.wskaznik) AS wskaznik
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Scientific and technical journal articles"
	AND 
	vp.year = 2011
ORDER BY
	CountryName
--drop table t_scientific_articles_2011 

	--ranking grupy bez Polski
SELECT
	sa11.CountryName,
	sa93.wskaznik AS wskaznik_1993,
	sa11.wskaznik AS wskaznik_2011,
	CASE
		WHEN sa11.wskaznik > sa93.wskaznik
		THEN ROUND(sa11.wskaznik / sa93.wskaznik,3)
		ELSE ROUND((sa11.wskaznik / sa93.wskaznik)-2,3)
	END AS zmiana_wskaznika,
	RANK () OVER (
	ORDER BY (ROUND(sa11.wskaznik / sa93.wskaznik-1,
	4))) AS punktacja
FROM
	t_scientific_articles_1993 sa93
JOIN t_scientific_articles_2011 sa11
ON
	sa93.CountryName = sa11.CountryName
WHERE
	sa11.CountryName IS NOT 'Poland'
ORDER BY
	zmiana_wskaznika DESC
	--wskaznik dla Polski
SELECT
	sa11.CountryName,
	sa93.wskaznik AS wskaznik_1993,
	sa11.wskaznik AS wskaznik_2011,
	ROUND(sa11.wskaznik / sa93.wskaznik-1,3) AS zmiana_wskaznika
FROM
	t_scientific_articles_1993 sa93
JOIN t_scientific_articles_2011 sa11
ON
	sa93.CountryName = sa11.CountryName
WHERE
	sa11.CountryName IS 'Poland'

---------------- 5. Adult literacy rate, population 15+ years, both sexes (%) ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)"
--danych jest malo; nie brac do funkcji rankujacej.
--dane sa nudne a wartosci bardzo bliskie siebie, malo ktory dorosly jest obecnie niepismienny
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT
	DISTINCT 
	CountryName ,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)"
ORDER BY
	CountryName
--wskazac srednia i minimalna wartosc dla kazdego kraju w ramach ciekawostki
--wsrod grupy
--MIN
SELECT
	CountryName,
	"Year",
	MIN(wskaznik) OVER (PARTITION BY CountryName) AS minimum_kraju
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)"
GROUP BY
	countryName
--AVG (bez Polski)
SELECT
	AVG(wskaznik) AS srednia_grupy
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)"
	AND 
	vp.CountryName IS NOT 'Poland'
--AVG (dla Polski)
SELECT
	AVG(wskaznik) AS srednia_polski
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)"
	AND 
	vp.CountryName = 'Poland'
	
---------------- 6. Research and development expenditure (% of GDP) ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Research and development expenditure (% of GDP)"
--srednia ilosc danych; nie wiadomo czy brac do funkcji rankujacej czy raczej sobie darowac. 
--sprawdzam co dalej:
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT
	DISTINCT 
	CountryName ,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
ORDER BY
	CountryName
--brakuje 2 krajow calkiem (Turkmenistan, Uzbekistan) trzeba by sobie 'jakos' radzic.
--c) ile unionow/widokow bedzie potrzebne:
--c.1) kiedy dany kraj pojawia sie po raz pierwszy? (odpowiedz: 1996, 1997, 1998, 2001)
SELECT
	DISTINCT
	CountryName,
	FIRST_VALUE("Year") OVER (PARTITION BY CountryName ORDER BY "Year") AS pierwsze_wyst
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
--c.2) kiedy dany kraj pojawia sie po raz ostatni? (odpowiedz: 2011, 2013, 2014)
SELECT
	DISTINCT
	CountryName,
	LAST_VALUE ("Year") OVER (PARTITION BY CountryName) AS ostatnie_wyst
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
--Razem 7 unionow/widokow do zrobienia i potencjalnie 2 kraje wyjete z rankingu. 
--Decyzja po przebadaniu danych: tak jak w przypaku wskaznika 1 i 2 (tam wystepowalo tylko 9 krajow).
--Zbadam tylko ekstrema i srednia. 
--Tym razem jednak nie zastosuje funkcji ROUND z uwagi na charakter danych. 
--Tak wiêc:
--wsrod grupy
--MAX
SELECT
	CountryName,
	"Year",
	MAX(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
UNION
--MIN
SELECT
	CountryName,
	"Year",
	MIN(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
UNION
--AVG (bez Polski)
SELECT
	'grupa_bez_polski' AS CountryName,
	NULL AS "Year",
	AVG(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
	AND 
	vp.CountryName IS NOT 'Poland'
--b)w Polsce
--MAX
SELECT
	'Polska_max' AS CountryName,
	"Year",
	MAX(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
	AND 
	vp.CountryName IS 'Poland'
UNION
--MIN
SELECT
	'Polska_min' AS CountryName,
	"Year",
	MIN(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
	AND 
	vp.CountryName IS 'Poland'
UNION
--AVG (dla Polski)
SELECT
	'avg_Polski' AS CountryName,
	NULL AS "Year",
	AVG(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Research and development expenditure (% of GDP)"
	AND 
	vp.CountryName IS 'Poland'
	
---------------- 7. Expenditure on education as % of total government expenditure (%) ----------------
--ocena danych
--a) przegl¹d:
SELECT
	*
FROM
	v_primary_view
WHERE
	IndicatorName = "Expenditure on education as % of total government expenditure (%)"
--srednia ilosc danych; nie wiadomo czy brac do funkcji rankujacej. sprawdzam co dalej:
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT
	DISTINCT 
	CountryName ,
	COUNT(CountryName) OVER (PARTITION BY CountryName) AS ilosc_powtorzen
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
ORDER BY
	CountryName
--znowu brakuje 2 krajow calkiem (Lithuania, Uzbekistan) trzeba by sobie 'jakos' radzic.
--c) ile unionow/widokow bedzie potrzebne:
--c.1) kiedy dany kraj pojawia sie po raz pierwszy? (odpowiedz: 1997, 1998, 1999, 2000, 2002, 2005, 2012)
SELECT
	DISTINCT
	CountryName,
	FIRST_VALUE ("Year") OVER (PARTITION BY CountryName ORDER BY "Year") AS pierwsze_wyst
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
--c.2) kiedy dany kraj pojawia sie po raz ostatni? (odpowiedz: 2009, 2011, 2012, 2013)
SELECT
	DISTINCT
	CountryName,
	LAST_VALUE ("Year") OVER (PARTITION BY CountryName) AS ostatnie_wyst
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
--razem 11 unionow/widokow do zrobienia i potencjalnie 2 kraje wyjete z rankingu 
--decyzja po przebadaniu danych: tak jak w przypaku wskaznika 1 i 2 (tam wystepowalo tylko 9 krajow)
--zbadam tylko ekstrema i srednia. usuwam tez funkce ROUND bo dane po przecinku sa tutaj wazne. 
--tak wiêc:
--wsrod grupy
--MAX
SELECT
	CountryName,
	"Year",
	MAX(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
UNION
--MIN
SELECT
	CountryName,
	"Year",
	MIN(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
UNION
--AVG (bez Polski)
SELECT
	'grupa_bez_polski' AS CountryName,
	NULL AS "Year",
	AVG(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
	AND 
	vp.CountryName IS NOT 'Poland'
	--b)w Polsce
	--MAX
SELECT
	'Polska_max' AS CountryName,
	"Year",
	MAX(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
	AND 
	vp.CountryName IS 'Poland'
UNION
--MIN
SELECT
	'Polska_min' AS CountryName,
	"Year",
	MIN(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
	AND 
	vp.CountryName IS 'Poland'
UNION
--AVG (dla Polski)
SELECT
	'avg_Polski' AS CountryName,
	NULL AS "Year",
	AVG(wskaznik) AS 'max/min/avg'
FROM
	v_primary_view AS vp
WHERE
	vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
	AND 
	vp.CountryName IS 'Poland'
	
	---------------- THE END ----------------