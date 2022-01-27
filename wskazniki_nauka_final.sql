---------------- GLOWNY FILTR ----------------
create view v_primary_view as
select
i.CountryName,
i.IndicatorName,
i."Year" ,
round(i.Value,3) as wskaznik
from Indicators i
where 
i.CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova','Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
AND
i.IndicatorName in ('Researchers in R&D (per million people)', 'Technicians in R&D (per million people)', 'Patent applications, residents', 'Scientific and technical journal articles', 'Adult literacy rate, population 15+ years, both sexes (%)', 'Expenditure on education as % of total government expenditure (%)', 'Research and development expenditure (% of GDP)')
AND
i."Year" > 1992
--drop view v_primary_view

/*celowo zostawiam tutaj widok; stosowanie podzapytania czy CTE mogloby bardzo zaciemnic obraz 
tego co jest istotne w dalszej czesci skryptu poniewaz z w/w "glownego filtra" korzystam wielokrotnie,
w wielu miejscach. na dodatek (po doprecyzowaniu celu projektu) filtr juz nie ulega zmianie dlatego
duzo wygodniej jest mi zapisac "from v_primary_view as vp" zamiast wszedzie u¿ywaæ np.

WITH main_filter as
(
select
i.CountryName,
i.IndicatorName,
i."Year" ,
round(i.Value,3) as wskaznik
from Indicators i
where 
i.CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova','Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
AND
i.IndicatorName in ('Researchers in R&D (per million people)', 'Technicians in R&D (per million people)', 'Patent applications, residents', 'Scientific and technical journal articles', 'Adult literacy rate, population 15+ years, both sexes (%)', 'Expenditure on education as % of total government expenditure (%)', 'Research and development expenditure (% of GDP)')
AND
i."Year" > 1992
)
select (...) from main_filter

Takze stosowanie tabeli tymczasowej wymagaloby powrot w to miejsce za kazdym razem,
gdy otwieram projekt.Nie ma to wiekszego sensu przy danych historycznych 
(z zalozenia niezmiennych) i do tego sprzed wielu lat.
*/

---------------- 1. Researchers in R&D (per million people) ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Researchers in R&D (per million people)"
order by "Year" 
--danych jest malo; nie brac do funkcji rankujacej - nie nadaja sie.
--b) ilosc wystapien danego panstwa w bazie danych: (dla potwierdzenia czy wszystkie kraje sa wliczone)
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" 
order by CountryName
--moge wyznaczyc podstawowe statystyki, do podania w ramach ciekawostki
--wskazac srednia, maksymalna i minimalna wartosc w ramach ciekawostki
--a) wsrod grupy bez Polski
--MAX
SELECT 
CountryName, "Year", round(max(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)"
union
--MIN
SELECT 
CountryName, "Year",round(min(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" 
union
--AVG (bez Polski)
SELECT 
'grupa_bez_polski' as CountryName,NULL as "Year", round(AVG(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" and vp.CountryName is not 'Poland'
--b)w Polsce
--MAX
SELECT 
'Polska_max' as CountryName, "Year", round(max(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" and vp.CountryName is 'Poland'
union
--MIN
SELECT 
'Polska_min' as CountryName, "Year",round(min(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" and vp.CountryName is 'Poland'
union
--AVG (dla Polski)
SELECT 
'avg_Polski' as CountryName, NULL as "Year", round(AVG(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" and vp.CountryName is 'Poland'

---------------- 2. Technicians in R&D (per million people) ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Technicians in R&D (per million people)"
--sytuacja jest podobna do wskaznika Researchers, tzn. danych jest malo; nie brac do funkcji rankujacej.
--b) ilosc wystapien danego panstwa w bazie danych: (dla potwierdzenia czy wszystkie kraje sa wliczone)
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" 
order by CountryName
--moge wyznaczyc podstawowe statystyki, do podania w ramach ciekawostki
--wskazac srednia, maksymalna i minimalna wartosc w ramach ciekawostki
--a) wsrod grupy bez Polski
--MAX
SELECT 
CountryName, "Year", round(max(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)"
union
--MIN
SELECT 
CountryName, "Year",round(min(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" 
union
--AVG (bez Polski)
SELECT 
'grupa_bez_polski' as CountryName,NULL as "Year", round(AVG(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" and vp.CountryName is not 'Poland'
--b)w Polsce
--MAX
SELECT 
'Polska_max' as CountryName, "Year", round(max(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" and vp.CountryName is 'Poland'
union
--MIN
SELECT 
'Polska_min' as CountryName, "Year",round(min(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" and vp.CountryName is 'Poland'
union
--AVG (dla Polski)
SELECT 
'avg_Polski' as CountryName, NULL as "Year", round(AVG(wskaznik)) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" and vp.CountryName is 'Poland'

---------------- 3. Patent applications, residents ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Patent applications, residents" --and CountryName = 'Azerbaijan'

--b) ilosc wystapien danego panstwa w bazie danych:
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" 
order by CountryName
--brakuje paru poczatkowych danych i paru od konca. 
--przeniose w te miejsca najblizsze dane dla danego kraju 
--pierwszy okres (1994) ogolnie
create view v_patent_applications_1994 as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1994
UNION --aby wliczyc Azerbaijan z 95go
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1995 and vp.CountryName = 'Azerbaijan'
UNION --aby wliczyc Turkmenistan z 96go
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1996 and vp.CountryName = 'Turkmenistan'
order by CountryName
--drop view v_patent_applications_1994

/*--pierwszy okres (1995) Azerbaijan
create view v_patent_applications_1995_Azerbaijan as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1995 and vp.CountryName = 'Azerbaijan'
--select * from v_patent_applications_1995_Azerbaijan

--pierwszy okres (1996) Turkmenistan
create view v_patent_applications_1996_Turkmenistan as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1996 and vp.CountryName = 'Turkmenistan'
--select * from v_patent_applications_1996_Turkmenistan
*/

--drugi okres (2013)
create view v_patent_applications_2013 as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 2013
UNION --aby wliczyc Turkmenistan z 99go
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1999 and vp.CountryName = 'Turkmenistan'
order by CountryName
--drop view v_patent_applications_2013 

/*
--drugi okres (1999) Turkmenistan
create view v_patent_applications_1999_Turkmenistan as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 1999 and vp.CountryName = 'Turkmenistan'
--select * from v_patent_applications_1999_Turkmenistan*/

--ranking grupy bez Polski
select
pa13.CountryName,
pa94.wskaznik as wskaznik_1994,
pa13.wskaznik as wskaznik_2013,
CASE 
when pa13.wskaznik > pa94.wskaznik
then round(pa13.wskaznik / pa94.wskaznik,3)
else round((pa13.wskaznik / pa94.wskaznik)-2,3) 
end as zmiana_wskaznika,
rank () over (order by (round(pa13.wskaznik / pa94.wskaznik-1,4))) as punktacja
from v_patent_applications_1994 pa94
join v_patent_applications_2013 pa13
on pa94.CountryName = pa13.CountryName
where pa13.CountryName is not 'Poland'
order by zmiana_wskaznika desc

--wskaznik dla Polski
select
pa13.CountryName,
pa94.wskaznik as wskaznik_1994,
pa13.wskaznik as wskaznik_2013,
round(pa13.wskaznik / pa94.wskaznik,3) as zmiana_wskaznika
from v_patent_applications_1994 pa94
join v_patent_applications_2013 pa13
on pa94.CountryName = pa13.CountryName
where pa13.CountryName is 'Poland'

---------------- 4. Scientific and technical journal articles ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Scientific and technical journal articles"

--b) ilosc wystapien danego panstwa w bazie danych:
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Scientific and technical journal articles" 
order by CountryName

--z danymi wszystko w porzadku. tymrazem jednak zamiast zapisu wartosci z granicznych lat do widoku,
--zastosuje tabele tymczasowe. w zasadzie glownie dla wzbogacenia skryptu; przy danych historycznych
--ktore (teoretycznie) nie powinny sie zmieniac, stosowanie widoku wydaje sie bezpieczne 
--pierwszy okres (1993)
create temp table t_scientific_articles_1993 as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Scientific and technical journal articles" and vp.year = 1993
order by CountryName
--drop table t_scientific_articles_1993

--drugi okres (2011)
create temp table t_scientific_articles_2011 as
select
vp.CountryName ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Scientific and technical journal articles" and vp.year = 2011
order by CountryName
--drop table t_scientific_articles_2011 

--ranking grupy bez Polski
select
sa11.CountryName,
sa93.wskaznik as wskaznik_1993,
sa11.wskaznik as wskaznik_2011,
CASE 
when sa11.wskaznik > sa93.wskaznik
then round(sa11.wskaznik / sa93.wskaznik,3)
else round((sa11.wskaznik / sa93.wskaznik)-2,3) 
end as zmiana_wskaznika,
rank () over (order by (round(sa11.wskaznik / sa93.wskaznik-1,4))) as punktacja
from t_scientific_articles_1993 sa93
join t_scientific_articles_2011 sa11
on sa93.CountryName = sa11.CountryName
where sa11.CountryName is not 'Poland'
order by zmiana_wskaznika desc

--wskaznik dla Polski
select
sa11.CountryName,
sa93.wskaznik as wskaznik_1993,
sa11.wskaznik as wskaznik_2011,
round(sa11.wskaznik / sa93.wskaznik-1,3) as zmiana_wskaznika
from t_scientific_articles_1993 sa93
join t_scientific_articles_2011 sa11
on sa93.CountryName = sa11.CountryName
where sa11.CountryName is 'Poland'

---------------- 5. Adult literacy rate, population 15+ years, both sexes (%) ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)"
--danych jest malo; nie brac do funkcji rankujacej.
--dane sa nudne a wartosci bardzo bliskie siebie, malo ktory dorosly jest obecnie niepismienny
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)" 
order by CountryName
--wskazac srednia i minimalna wartosc dla kazdego kraju w ramach ciekawostki
--wsrod grupy
--MIN
SELECT 
CountryName, "Year", min(wskaznik) over (partition by CountryName) as minimum_kraju
from v_primary_view as vp
where vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)" 
group by countryName
--AVG (bez Polski)
SELECT 
AVG(wskaznik) as srednia_grupy
from v_primary_view as vp
where vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)" and vp.CountryName is not 'Poland'
--AVG (dla Polski)
SELECT 
AVG(wskaznik) as srednia_polski
from v_primary_view as vp
where vp.IndicatorName = "Adult literacy rate, population 15+ years, both sexes (%)" and vp.CountryName = 'Poland'

---------------- 6. Research and development expenditure (% of GDP) ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Research and development expenditure (% of GDP)"
--srednia ilosc danych; nie wiadomo czy brac do funkcji rankujacej czy sobie darowac. 
--sprawdzam co dalej:
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" 
order by CountryName
--brakuje 2 krajow calkiem (Turkmenistan, Uzbekistan) trzeba by sobie 'jakos' radzic.
--c) ile unionow/widokow bedzie potrzebne:
--c.1) kiedy dany kraj pojawia sie po raz pierwszy? (odpowiedz: 1996, 1997, 1998, 2001)
select distinct
CountryName, 
first_value ("Year") over (partition by CountryName order by "Year") as pierwsze_wyst
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" 
--c.2) kiedy dany kraj pojawia sie po raz ostatni? (odpowiedz: 2011, 2013, 2014)
select distinct
CountryName, 
last_value ("Year") over (partition by CountryName) as ostatnie_wyst
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" 
--razem 7 unionow/widokow do zrobienia i potencjalnie 2 kraje wyjete z rankingu 
--decyzja po przebadaniu danych: tak jak w przypaku wskaznika 1 i 2 (tam wystepowalo tylko 9 krajow)
--zbadam tylko ekstrema i srednia. tym razem jednak nie zastosuje funkcji round. tak wiêc:

--wsrod grupy
--MAX
SELECT 
CountryName, "Year", max(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)"
union
--MIN
SELECT 
CountryName, "Year", min(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" 
union
--AVG (bez Polski)
SELECT 
'grupa_bez_polski' as CountryName,NULL as "Year", AVG(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" and vp.CountryName is not 'Poland'
--b)w Polsce
--MAX
SELECT 
'Polska_max' as CountryName, "Year", max(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" and vp.CountryName is 'Poland'
union
--MIN
SELECT 
'Polska_min' as CountryName, "Year", min(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" and vp.CountryName is 'Poland'
union
--AVG (dla Polski)
SELECT 
'avg_Polski' as CountryName, NULL as "Year", AVG(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" and vp.CountryName is 'Poland'

---------------- 7. Expenditure on education as % of total government expenditure (%) ----------------
--ocena danych
--a) przegl¹d:
select *
from v_primary_view 
where IndicatorName = "Expenditure on education as % of total government expenditure (%)"
--srednia ilosc danych; nie wiadomo czy brac do funkcji rankujacej. sprawdzam co dalej:
--b) ilosc wystapien danego panstwa w bazie danych:
SELECT DISTINCT 
CountryName ,
count(CountryName) over (partition by CountryName) as ilosc_powtorzen
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" 
order by CountryName
--znowu brakuje 2 krajow calkiem (Lithuania, Uzbekistan) trzeba by sobie 'jakos' radzic.
--c) ile unionow/widokow bedzie potrzebne:
--c.1) kiedy dany kraj pojawia sie po raz pierwszy? (odpowiedz: 1997, 1998, 1999, 2000, 2002, 2005, 2012)
select distinct
CountryName, 
first_value ("Year") over (partition by CountryName order by "Year") as pierwsze_wyst
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" 
--c.2) kiedy dany kraj pojawia sie po raz ostatni? (odpowiedz: 2009, 2011, 2012, 2013)
select distinct
CountryName, 
last_value ("Year") over (partition by CountryName) as ostatnie_wyst
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" 
--razem 11 unionow/widokow do zrobienia i potencjalnie 2 kraje wyjete z rankingu 
--decyzja po przebadaniu danych: tak jak w przypaku wskaznika 1 i 2 (tam wystepowalo tylko 9 krajow)
--zbadam tylko ekstrema i srednia. usuwam tez funkce round bo dane po przecinku sa tutaj wazne. 
--tak wiêc:

--wsrod grupy
--MAX
SELECT 
CountryName, "Year", max(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)"
union
--MIN
SELECT 
CountryName, "Year", min(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" 
union
--AVG (bez Polski)
SELECT 
'grupa_bez_polski' as CountryName,NULL as "Year", AVG(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" and vp.CountryName is not 'Poland'
--b)w Polsce
--MAX
SELECT 
'Polska_max' as CountryName, "Year", max(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" and vp.CountryName is 'Poland'
union
--MIN
SELECT 
'Polska_min' as CountryName, "Year", min(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" and vp.CountryName is 'Poland'
union
--AVG (dla Polski)
SELECT 
'avg_Polski' as CountryName, NULL as "Year", AVG(wskaznik) as 'max/min/avg'
from v_primary_view as vp
where vp.IndicatorName = "Expenditure on education as % of total government expenditure (%)" and vp.CountryName is 'Poland'

---------------- THE END ----------------