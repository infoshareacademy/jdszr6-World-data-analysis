/*Porównujemy dane dla ZSRR rok do roku (92-2012, sprawdziæ wyniki)*/
--Grupa "zatrudnienie"
--Unemployment, total (% of total labor force)
--Unemployment, female (% of female labor force)
--Unemployment, male (% of male labor force)


--Unemployment, total (% of total labor force)
with dane as (
				select 
				i.CountryName ,
				i."Year" ,
				i.Value,2 ,
				dense_rank() over (partition by i.CountryName order by i."Year") as ranking
				from indicators i
				where i.IndicatorName = 'Unemployment, total (% of total labor force)' and 
				i.CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan') 
				Order by i.CountryName 
			)

select 
CountryName ,
"Year" ,
Value as wartosc_1992,
lead("Year") over (partition by countryName) as rok ,
lead(value) over (partition by countryName) as wartosc_2012 ,
lead(value) over (partition by countryName) - Value as zmiana
from dane
where "Year" = 1992 Or "Year" = 2012



--Unemployment, female (% of female labor force)
with dane as (
				select 
				i.CountryName ,
				i."Year" ,
				i.Value,2 ,
				dense_rank() over (partition by i.CountryName order by i."Year") as ranking
				from indicators i
				where i.IndicatorName = 'Unemployment, female (% of female labor force)' and 
				i.CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan') 
				Order by i.CountryName 
			)

select 
CountryName ,
"Year" ,
Value as wartosc_1992,
lead("Year") over (partition by countryName) as rok ,
lead(value) over (partition by countryName) as wartosc_2012 ,
lead(value) over (partition by countryName) - Value as zmiana
from dane
where "Year" = 1992 Or "Year" = 2012



--Unemployment, male (% of male labor force)
with dane as (
				select 
				i.CountryName ,
				i."Year" ,
				i.Value,2 ,
				dense_rank() over (partition by i.CountryName order by i."Year") as ranking
				from indicators i
				where i.IndicatorName = 'Unemployment, male (% of male labor force)' and 
				i.CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania', 'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan') 
				Order by i.CountryName 
			)

select 
CountryName ,
"Year" ,
Value as wartosc_1992,
lead("Year") over (partition by countryName) as rok ,
lead(value) over (partition by countryName) as wartosc_2012 ,
lead(value) over (partition by countryName) - Value as zmiana
from dane
where "Year" = 1992 Or "Year" = 2012


--srednia dla Polski (lata 1992-2012) 
--Unemployment, total (% of total labor force)

select 
CountryName ,
avg(Value) as sredni_wskaznik 
from Indicators i 
where CountryName = 'Poland' and IndicatorName = 'Unemployment, total (% of total labor force)' and "Year" between 1992 and 2012
group by CountryName

--Unemployment, female (% of female labor force)
select 
CountryName ,
avg(Value) as sredni_wskaznik 
from Indicators i 
where CountryName = 'Poland' and IndicatorName = 'Unemployment, female (% of female labor force)' and "Year" between 1992 and 2012
group by CountryName

--Unemployment, male (% of male labor force)
select 
CountryName ,
avg(Value) as sredni_wskaznik 
from Indicators i 
where CountryName = 'Poland' and IndicatorName = 'Unemployment, male (% of male labor force)' and "Year" between 1992 and 2012
group by CountryName





