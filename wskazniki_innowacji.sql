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

--1. Research and development expenditure (% of GDP)------------------------------
select *
from Indicators i 
where IndicatorName = "Research and development expenditure (% of GDP)"
--Research and development expenditure (% of GDP) 2009 (FIRST PERIOD)
create view v_RD_expenditure_2009 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" and vp.year = 2009
order by CountryName
--Research and development expenditure (% of GDP) 2013 (SECOND PERIOD)
create view v_RD_expenditure_2013 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Research and development expenditure (% of GDP)" and vp.year = 2013
order by CountryName
--TOP 10 NAJGORSZYCH PAÑSTW Research and development expenditure (% of GDP)
select
rde09.CountryName ,
rde09.wskaznik as wskaznik_2009,
rde13.wskaznik as wskaznik_2013,
round(rde13.wskaznik / rde09.wskaznik-1,2) as spadek_wskaznika
from v_RD_expenditure_2009 rde09
join v_RD_expenditure_2013 rde13
on rde09.CountryCode = rde13.CountryCode
order by spadek_wskaznika asc
Limit 10 offset 21 --offset usuwa spadek NULL, czyli przypadki gdzie wskaznik_2009 = 0

--TOP 10 NAJLEPSZYCH PAÑSTW Research and development expenditure (% of GDP)
select
rde09.CountryName ,
rde09.wskaznik as wskaznik_2009 ,
rde13.wskaznik as wskaznik_2013 ,
round(rde13.wskaznik / rde09.wskaznik-1,2) as wzrost_wskaznika
from v_RD_expenditure_2009 rde09
join v_RD_expenditure_2013 rde13
on rde09.CountryCode = rde13.CountryCode
order by wzrost_wskaznika desc
Limit 10
--REGIONY
select
rde09.region ,
round(AVG(rde09.wskaznik)) as wskaznik_2009 ,
round(AVG(rde13.wskaznik)) as wskaznik_2013 ,
round((AVG(rde13.wskaznik)) / (AVG(rde09.wskaznik))-1,2) as spadek_wzrost
from v_RD_expenditure_2009 rde09
join v_RD_expenditure_2013 rde13
on rde09.CountryCode = rde13.CountryCode
group by rde13.region
order by spadek_wzrost

--2. Researchers in R&D (per million people)------------------------------
select *
from Indicators i 
where IndicatorName = "Researchers in R&D (per million people)"
--Researchers in R&D (per million people) 2009 (FIRST PERIOD)
create view v_Researchers_in_RD_2009 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" and vp.year = 2009
order by CountryName
--Researchers in R&D (per million people) 2013 (SECOND PERIOD)
create view v_Researchers_in_RD_2013 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Researchers in R&D (per million people)" and vp.year = 2013
order by CountryName
--TOP 10 NAJGORSZYCH PAÑSTW Researchers in R&D (per million people)
select
rrd09.CountryName ,
rrd09.wskaznik as wskaznik_2009,
rrd13.wskaznik as wskaznik_2013,
round(rrd13.wskaznik / rrd09.wskaznik-1,2) as spadek_wskaznika
from v_Researchers_in_RD_2009 rrd09
join v_Researchers_in_RD_2013 rrd13
on rrd09.CountryCode = rrd13.CountryCode
order by spadek_wskaznika asc
Limit 10
--TOP 10 NAJLEPSZYCH PAÑSTW Researchers in R&D (per million people)
select
rrd09.CountryName ,
rrd09.wskaznik as wskaznik_2009 ,
rrd13.wskaznik as wskaznik_2013 ,
round(rrd13.wskaznik / rrd09.wskaznik-1,2) as wzrost_wskaznika
from v_Researchers_in_RD_2009 rrd09
join v_Researchers_in_RD_2013 rrd13
on rrd09.CountryCode = rrd13.CountryCode
order by wzrost_wskaznika desc
Limit 10
--REGIONY
select
rrd09.region ,
round(AVG(rrd09.wskaznik)) as wskaznik_2009 ,
round(AVG(rrd13.wskaznik)) as wskaznik_2013 ,
round((AVG(rrd13.wskaznik)) / (AVG(rrd09.wskaznik))-1,2) as spadek_wzrost
from v_Researchers_in_RD_2009 rrd09
join v_Researchers_in_RD_2013 rrd13
on rrd09.CountryCode = rrd13.CountryCode
group by rrd13.region
order by spadek_wzrost

--3. Technicians in R&D (per million people)------------------------------
select *
from Indicators i 
where IndicatorName = "Technicians in R&D (per million people)"
--Technicians in R&D (per million people) 2009 (FIRST PERIOD)
create view v_Technicians_in_RD_2009 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" and vp.year = 2009
order by CountryName
--Technicians in R&D (per million people) 2013 (SECOND PERIOD)
create view v_Technicians_in_RD_2013 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Technicians in R&D (per million people)" and vp.year = 2013
order by CountryName
--TOP 10 NAJGORSZYCH PAÑSTW Technicians in R&D (per million people)
select
trd09.CountryName ,
trd09.wskaznik as wskaznik_2009,
trd13.wskaznik as wskaznik_2013,
round(trd13.wskaznik / trd09.wskaznik-1,2) as spadek_wskaznika
from v_Technicians_in_RD_2009 trd09
join v_Technicians_in_RD_2013 trd13
on trd09.CountryCode = trd13.CountryCode
order by spadek_wskaznika asc
Limit 10
--TOP 10 NAJLEPSZYCH PAÑSTW Technicians in R&D (per million people)
select
trd09.CountryName ,
trd09.wskaznik as wskaznik_2009 ,
trd13.wskaznik as wskaznik_2013 ,
round(trd13.wskaznik / trd09.wskaznik-1,2) as wzrost_wskaznika
from v_Technicians_in_RD_2009 trd09
join v_Technicians_in_RD_2013 trd13
on trd09.CountryCode = trd13.CountryCode
order by wzrost_wskaznika desc
Limit 10
--REGIONY
select
trd09.region ,
round(AVG(trd09.wskaznik)) as wskaznik_2009 ,
round(AVG(trd13.wskaznik)) as wskaznik_2013 ,
round((AVG(trd13.wskaznik)) / (AVG(trd09.wskaznik))-1,2) as spadek_wzrost
from v_Technicians_in_RD_2009 trd09
join v_Technicians_in_RD_2013 trd13
on trd09.CountryCode = trd13.CountryCode
group by trd13.region
order by spadek_wzrost

--4. Patent applications, residents------------------------------
select *
from Indicators i 
where IndicatorName = "Patent applications, residents"
--Patent applications, residents 2009 (FIRST PERIOD)
create view v_patent_applications_2009 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 2009
order by CountryName
--Patent applications, residents 2013 (SECOND PERIOD)
create view v_patent_applications_2013 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Patent applications, residents" and vp.year = 2013
order by CountryName
--TOP 10 NAJGORSZYCH PAÑSTW Patent applications, residents
select
pa09.CountryName ,
pa09.wskaznik as wskaznik_2009,
pa13.wskaznik as wskaznik_2013,
round(pa13.wskaznik / pa09.wskaznik-1,2) as spadek_wskaznika
from v_patent_applications_2009 pa09
join v_patent_applications_2013 pa13
on pa09.CountryCode = pa13.CountryCode
order by spadek_wskaznika asc
Limit 10
--TOP 10 NAJLEPSZYCH PAÑSTW Patent applications, residents
select
pa09.CountryName ,
pa09.wskaznik as wskaznik_2009 ,
pa13.wskaznik as wskaznik_2013 ,
round(pa13.wskaznik / pa09.wskaznik-1,2) as wzrost_wskaznika
from v_patent_applications_2009 pa09
join v_patent_applications_2013 pa13
on pa09.CountryCode = pa13.CountryCode
order by wzrost_wskaznika desc
Limit 10
--REGIONY
select
pa09.region ,
round(AVG(pa09.wskaznik)) as wskaznik_2009 ,
round(AVG(pa13.wskaznik)) as wskaznik_2013 ,
round((AVG(pa13.wskaznik)) / (AVG(pa09.wskaznik))-1,2) as spadek_wzrost
from v_patent_applications_2009 pa09
join v_patent_applications_2013 pa13
on pa09.CountryCode = pa13.CountryCode
group by pa13.region
order by spadek_wzrost

--5. Scientific and technical journal articles------------------------------
select *
from Indicators i 
where IndicatorName = "Scientific and technical journal articles"
--Scientific and technical journal articles 2007 (FIRST PERIOD)
create view v_scientific_articles_2007 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Scientific and technical journal articles" and vp.year = 2007
order by CountryName
--Scientific and technical journal articles 2011 (SECOND PERIOD)
create view v_scientific_articles_2011 as
select
vp.region ,
vp.CountryName ,
vp.CountryCode ,
vp.IndicatorName ,
vp."Year" ,
round(vp.wskaznik) as wskaznik
from v_primary_view as vp
where vp.IndicatorName = "Scientific and technical journal articles" and vp.year = 2011
order by CountryName
--TOP 10 NAJGORSZYCH PAÑSTW Scientific and technical journal articles
select
sa07.CountryName ,
sa07.wskaznik as wskaznik_2007,
sa11.wskaznik as wskaznik_2011,
round(sa11.wskaznik / sa07.wskaznik-1,2) as spadek_wskaznika
from v_scientific_articles_2007 sa07
join v_scientific_articles_2011 sa11
on sa07.CountryCode = sa11.CountryCode
order by spadek_wskaznika asc
Limit 10 offset 10 --offest usuwa 10 panstw ktore w ogolenie mialy artykukol naukowych w 2007
--TOP 10 NAJLEPSZYCH PAÑSTW Scientific and technical journal articles
select
sa07.CountryName ,
sa07.wskaznik as wskaznik_2007 ,
sa11.wskaznik as wskaznik_2011 ,
round(sa11.wskaznik / sa07.wskaznik-1,2) as wzrost_wskaznika
from v_scientific_articles_2007 sa07
join v_scientific_articles_2011 sa11
on sa07.CountryCode = sa11.CountryCode
order by wzrost_wskaznika desc
Limit 10
--REGIONY
select
sa07.region ,
round(AVG(sa07.wskaznik)) as wskaznik_2007 ,
round(AVG(sa11.wskaznik)) as wskaznik_2011 ,
round((AVG(sa11.wskaznik)) / (AVG(sa07.wskaznik))-1,2) as spadek_wzrost
from v_scientific_articles_2007 sa07
join v_scientific_articles_2011 sa11
on sa07.CountryCode = sa11.CountryCode
group by sa11.region
order by spadek_wzrost