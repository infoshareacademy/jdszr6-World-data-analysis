--World Development Indicators - Najlepsi z najlepszych i najgorsi z najgorszych - czyli
--pa�stwa/regiony kt�re w danych dziedzinach w nied�ugim czasie sta�y si� potentatami lub
--popad�y w ruin�


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


--WA�NE KOMENTARZE:
--nale�y zastosowa� prawid�owe komentarze (zmieni� te komentarze, kt�re nie s� poprawne)
--nale�y zmodyfikowa� pierwsze zadanie, zrobi� je nie por�wnuj�c dw�ch lat do siebie tylko wyci�gaj�c �redni� 5cioletni�
--nale�y zmodyfikowa� nazwy kolumn gdzie wyliczony jest wska�nik (tytu�ami zrobi� nazwy wska�nik�w + doda� �rednnia)
--punkt numer 7 nale�y przenie�� do punktu numer 3


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

--TOP 10 NAJGORSZYCH PA�STW GDP per capita 
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

--TOP 10 NAJLEPSZYCH PA�STW GDP per capita 
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
--TOP 10 PA�STW Z NAJWI�KSZYM PRZYROSTEM GDP ZA 5 LAT (20)
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GDP per capita growth (annual %)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wskaznik_2010_2014 desc
limit 10

--TOP 10 PA�STW, KT�RYCH GDP SKURCZY�O SI� ZA OSTATNIE 5 LAT
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
--TOP 10 PA�STW Z NAJWI�KSZYM PRZYROSTEM GNI ZA 5 LAT (20)
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wskaznik_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita growth (annual %)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wskaznik_2010_2014 desc
limit 10

--TOP 10 PA�STW, KT�RYCH GNI SKURCZY�O SI� ZA OSTATNIE 5 LAT
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
--TOP 10 pa�stw, kt�re wydaj� najwi�cej pieni�dzy na osob� �rednio w latach 2010-2014
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure per capita (current US$)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP 10 pa�stw, kt�re wydaj� najmniej pieni�dzy na osob� �rednio w latach 2010-2014
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
--TOP10 pa�stw z najwi�kszym wzrostem wydatk�w na prywatn� opiek� medyczn�
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pa�stw z najmniejszym wzrostem wydatk�w na prywatn� opiek� medyczn�
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
--TOP10 pa�stw, kt�re maj� najwi�kszy udzia� wydatk�w na publiczn� s�u�b� zdrowia wzgl�dem GDP
select 
CountryName ,
round(AVG(wskaznik),2) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Health expenditure, private (% of GDP)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pa�stw, kt�re maj� najmniejszy udzia� wydatk�w na publiczn� s�u�b� zdrowia wzgl�dem GDP
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
--TOP10 pa�stw, kt�re zanotowa�y najwy�szy wska�nik za ostatnie 5 lat
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "GNI per capita, Atlas method (current US$)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pa�stw, kt�re zanotowa�y najni�szy wska�nik za ostatnie 5 lat
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
--TOP10 pa�stw w kt�rych jest najwy�sze zatrudnienie w rolnictwie
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in agriculture (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pa�stw w kt�rych jest najni�sze zatrudnienie w rolnictwie
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
--TOP10 pa�stw w kt�ych jest najwy�sze zatrudnienie w przemy�le
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in industry (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pa�stw w kt�ych jest najni�sze zatrudnienie w przemy�le
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
--TOP10 pa�stw w kt�rych zatrudnienie w us�ugach jest najwy�sze
select 
CountryName ,
round(AVG(wskaznik)) as sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 
from v_primary_view vpv 
where IndicatorName = "Employment in services (% of total employment)" and "Year" between 2010 and 2014
GROUP by CountryName 
order by sredni_wydatek_na_sluzbe_zdrowia_na_osobe_2010_2014 desc
limit 10

--TOP10 pa�stw w kt�rych zatrudnienie w us�ugach jest najni�sze
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










