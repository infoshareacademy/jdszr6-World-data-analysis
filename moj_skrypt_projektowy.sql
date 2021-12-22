/*
---tylko polska---

create view v1pol as 
SELECT distinct
i.CountryCode, 
i.IndicatorName as wskaznik1,
round(i.Value,2) as rolnictwo, 
i."Year"
from indicators i
where 
i.IndicatorName like 'Employment in agriculture (% of total employment)' 
and 
i.CountryCode like 'pol'
order by i."Year" 
--drop view v1pol

create view v2pol as 
SELECT distinct
i2.CountryCode, 
i2.indicatorName as wskaznik2,
round(i2.value,2) as przemys³,
i2."Year"
from indicators i2
where 
i2.IndicatorName like 'Employment in industry (% of total employment)' 
and 
i2.CountryCode like 'pol' 
order by i2."Year" 
--drop view v2pol

create view v3pol as 
SELECT distinct
i3.CountryCode, 
i3.indicatorName as wskaznik3,
round(i3.value,2) as uslugi,
i3."Year"
from indicators i3
where 
i3.IndicatorName like 'Employment in services (% of total employment)' 
and 
i3.CountryCode like 'pol' 
order by i3."Year" 
--drop view v3pol

select distinct
v1pol.CountryCode,
v1pol."Year",
v1pol.rolnictwo, 
--v2pol.wskaznik2,
v2pol.przemys³,
--v3pol.wskaznik3,
v3pol.uslugi,
v1pol.rolnictwo + v2pol.przemys³ + v3pol.uslugi as calosc
from v1pol
join v2pol
on v1pol."Year" = v2pol."Year"
join v3pol
on v1pol."Year" = v3pol."Year"
*/
--------------------------------------------------------------------------------
/*select 
count (distinct countrycode) 
from Indicators i */

create view v1 as 
SELECT distinct
ROW_NUMBER() over(order by i.CountryCode) as nr,
i.CountryCode, 
i."Year",
--i.IndicatorName as wskaznik1,
round(i.Value,2) as rolnictwo
from indicators i
where 
i.IndicatorName like 'Employment in agriculture (% of total employment)'
order by i.CountryCode, i."Year"
--drop view v1

create view v2 as 
SELECT distinct
i2.CountryCode, 
--i2."Year",
--i2.indicatorName as wskaznik2,
round(i2.value,2) as przemysl,
ROW_NUMBER() over(order by i2.CountryCode) as nr
from indicators i2
where 
i2.IndicatorName like 'Employment in industry (% of total employment)' 
order by i2.CountryCode, i2."Year" 
--drop view v2

create view v3 as 
SELECT distinct
i3.CountryCode,
--i3."Year",
--i3.indicatorName as wskaznik3,
round(i3.value,2) as uslugi,
ROW_NUMBER() over(order by i3.CountryCode)) as nr
from indicators i3
where 
i3.IndicatorName like 'Employment in services (% of total employment)' 
order by i3.CountryCode, i3."Year" 
--drop view v3

select * from v1 where CountryCode like "pol";
select * from v2 where CountryCode like "pol";
select * from v3 where CountryCode like "pol"

---------------- WSKAZNIKI TRENDOW--------------
--wykonaæ dla kazdego indicatora--

create view v11 as
SELECT distinct
ROW_NUMBER() over(order by i.CountryCode) as nr,
i.CountryCode, 
i."Year",
--i.IndicatorName as wskaznik1,
round(i.Value,2) as rolnictwo
from indicators i
where 
i.IndicatorName like 'Employment in agriculture (% of total employment)'
order by i.CountryCode, i."Year"

create view v111 as
select 
*,
lag(rolnictwo) over (partition by countrycode) as wstecz,
round((rolnictwo-(lag(rolnictwo) over (partition by countrycode)))*100/(lag(rolnictwo) over (partition by countrycode)),2) as YOY
from v11

--najwieksze spadki w rolnictwie rok do roku:
select 
countrycode,
"Year",
YOY
FROM
v111
where yoy is not null
order by yoy asc
limit 5 offset 2 --offset pomija tutaj dwa artefakty (-100)
--wykonaæ tak samo dla wzrostów

/* BRUDNOPIS
select
v2.Countrycode,
v2.przemysl,
v3.uslugi 
from v2
left join v3 
on v3.nr =v2.nr 
where v2.countrycode like "pol"

select 
countrycode,
IndicatorName,
"Year",
value,
RANK() over (order by IndicatorName) as czy
from 
Indicators
where 
(CountryCode like "pol"and IndicatorName = 'Employment in agriculture (% of total employment)') 
or
(CountryCode like "pol" and IndicatorName = 'Employment in industry (% of total employment)')
or
(CountryCode like "pol" and IndicatorName = 'Employment in services (% of total employment)')

--3387/3429
-------------------*/

