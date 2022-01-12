--World Development Indicators - Najlepsi z najlepszych i najgorsi z najgorszych - czyli
--pañstwa/regiony które w danych dziedzinach w nied³ugim czasie sta³y siê potentatami lub
--popad³y w ruinê


--1. GDP per capita (current US$) 						done
--2. GDP per capita growth (annual %)					done
--3. GNI per capita growth (annual %)					done
--4. Health expenditure per capita (current US$)		done
--5. Health expenditure, private (% of GDP)				done
--6. Health expenditure, public (% of GDP)				done
--7. GNI per capita, Atlas method (current US$)			done
--8. Employment in agriculture (% of total employment)	done
--9. Employment in industry (% of total employment)		done
--10. Employment in services (% of total employment)	done


--WA¯NE KOMENTARZE:
--nale¿y zastosowaæ prawid³owe komentarze (zmieniæ te komentarze, które nie s¹ poprawne)
--nale¿y zmodyfikowaæ pierwsze zadanie, zrobiæ je nie porównuj¹c dwóch lat do siebie tylko wyci¹gaj¹c œredni¹ 5cioletni¹
--nale¿y zmodyfikowaæ nazwy kolumn gdzie wyliczony jest wskaŸnik (tytu³ami zrobiæ nazwy wskaŸników + dodaæ œrednnia)
--punkt numer 7 nale¿y przenieœæ do punktu numer 3


--1. GDP per capita (current US$)--------------------------------------------------------------------------------------
--MOTHER QUERY (VIEW)
create view v_primary_view as
select 
c.Region ,
i.CountryName ,
i.CountryCode ,
i.IndicatorName ,
i."Year" ,
round(i.Value) as wskaznik
from Indicators i 
join Country c 
on i.CountryCode = c.CountryCode 
where c.Region <> ""


--GDP per capita (current US$) 2009 (FIRST PERIOD)
create view v_GDP_per_capita_2010 as
select 
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp 
where vp.IndicatorName = "GDP per capita (current US$)" and vp.year = 2010 
order by CountryName 

--GDP per capita (current US$) 2009 (SECOND PERIOD)
create view v_GDP_per_capita_2014 as
select 
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp 
where vp.IndicatorName = "GDP per capita (current US$)" and vp.year = 2014
order by CountryName 

--TOP 10 NAJGORSZYCH PAÑSTW GDP per capita 
select 
gdp10t.CountryName ,
gdp10t.wskaznik as wskaznik_2010 ,
gdp14t.wskaznik as wskaznik_2014 ,
round(gdp14t.wskaznik / gdp10t.wskaznik-1,2) as spadek_wskaznika
from v_GDP_per_capita_2010 gdp10t
join v_GDP_per_capita_2014 gdp14t
on gdp10t.CountryCode = gdp14t.CountryCode
order by spadek_wskaznika asc
Limit 10

--TOP 10 NAJLEPSZYCH PAÑSTW GDP per capita 
select 
gdp10t.CountryName ,
gdp10t.wskaznik as wskaznik_2010 ,
gdp14t.wskaznik as wskaznik_2014 ,
round(gdp14t.wskaznik / gdp10t.wskaznik-1,2) as wzrost_wskaznika
from v_GDP_per_capita_2010 gdp10t
join v_GDP_per_capita_2014 gdp14t
on gdp10t.CountryCode = gdp14t.CountryCode
order by wzrost_wskaznika desc
Limit 10

--REGIONY
select 
gdp10t.region ,
round(AVG(gdp10t.wskaznik)) as wskaznik_2010 ,
round(AVG(gdp14t.wskaznik)) as wskaznik_2014 ,
round((AVG(gdp14t.wskaznik)) / (AVG(gdp10t.wskaznik))-1,2) as spadek_wzrost
from v_GDP_per_capita_2010 gdp10t
join v_GDP_per_capita_2014 gdp14t
on gdp10t.CountryCode = gdp14t.CountryCode
group by gdp10t.region
order by spadek_wzrost

--2. GDP per capita growth (annual %)--------------------------------------------------------------------
--TOP 10 PAÑSTW Z NAJWIÊKSZYM PRZYROSTEM GDP ZA 5 LAT (20)
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GDP per capita growth (annual %)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wskaznik_2010_2014 desc
limit 10

--TOP 10 PAÑSTW, KTÓRYCH GDP SKURCZY£O SIÊ ZA OSTATNIE 5 LAT
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GDP per capita growth (annual %)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wskaznik_2010_2014 asc
limit 10

--REGIONY AD2
select
Region ,
round(avg(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GDP per capita growth (annual %)" and "Year" between 2010 and 2014
group by Region 
order by sredni_wskaznik_2010_2014 asc 


--3. GNI per capita growth (annual %)---------------------------------------------------------------------
--TOP 10 PAÑSTW Z NAJWIÊKSZYM PRZYROSTEM GNI ZA 5 LAT (20)
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita growth (annual %)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wskaznik_2010_2014 desc
limit 10

--TOP 10 PAÑSTW, KTÓRYCH GNI SKURCZY£O SIÊ ZA OSTATNIE 5 LAT
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita growth (annual %)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wskaznik_2010_2014 asc
limit 10

--REGIONY AD3
select
Region ,
round(avg(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita growth (annual %)" and "Year" between 2010 and 2014
group by Region 
order by sredni_wskaznik_2010_2014 asc 

--4. Health expenditure per capita (current US$)---------------------------------------------
--TOP 10 pañstw, które wydaj¹ najwiêcej pieniêdzy na osobê œrednio w latach 2010-2014
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure per capita (current US$)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP 10 pañstw, które wydaj¹ najmniej pieniêdzy na osobê œrednio w latach 2010-2014
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure per capita (current US$)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10

--REGIONY AD4
select 
Region ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure per capita (current US$)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10


--5. Health expenditure, private (% of GDP)---------------------------------------------------------
--TOP10 pañstw z najwiêkszym wzrostem wydatków na prywatn¹ opiekê medyczn¹
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pañstw z najmniejszym wzrostem wydatków na prywatn¹ opiekê medyczn¹
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--REGIONY AD5
select 
Region ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10


--6. Health expenditure, public (% of GDP)---------------------------------------------------------
--TOP10 pañstw, które maj¹ najwiêkszy udzia³ wydatków na publiczn¹ s³u¿bê zdrowia wzglêdem GDP
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pañstw, które maj¹ najmniejszy udzia³ wydatków na publiczn¹ s³u¿bê zdrowia wzglêdem GDP
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10

--REGIONY AD6
select 
Region ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10


--7. GNI per capita, Atlas method (current US$)---------------------------------------------------
--TOP10 pañstw, które zanotowa³y najwy¿szy wskaŸnik za ostatnie 5 lat
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita, Atlas method (current US$)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pañstw, które zanotowa³y najni¿szy wskaŸnik za ostatnie 5 lat
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita, Atlas method (current US$)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10

--REDIONY AD7
select 
Region ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita, Atlas method (current US$)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10


--8. Employment in agriculture (% of total employment)----------------------------------------------
--TOP10 pañstw w których jest najwy¿sze zatrudnienie w rolnictwie
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in agriculture (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pañstw w których jest najni¿sze zatrudnienie w rolnictwie
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in agriculture (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10

--REGIONY AD8
select 
Region ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in agriculture (% of total employment)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10


--9. Employment in industry (% of total employment)--------------------------------------------------------
--TOP10 pañstw w któych jest najwy¿sze zatrudnienie w przemyœle
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in industry (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pañstw w któych jest najni¿sze zatrudnienie w przemyœle
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in industry (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10

--REGIONY AD9
select 
Region ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in industry (% of total employment)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10


--10. Employment in services (% of total employment)----------------------------------------------------
--TOP10 pañstw w których zatrudnienie w us³ugach jest najwy¿sze
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in services (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pañstw w których zatrudnienie w us³ugach jest najni¿sze
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in services (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10

--REGIONY AD10
select 
Region ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in services (% of total employment)" and "Year" between 2010 and 2014
GROUP by Region 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 asc
limit 10










