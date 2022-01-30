
SELECT count(*), IndicatorName FROM Indicators i where IndicatorName like ('%import%') group by IndicatorName 

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('Fuel exports (% of merchandise exports)') and year = '1992'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('Fuel exports (% of merchandise exports)') and year = '2012'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('High-technology exports (% of manufactured exports)') and year = '1992'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('High-technology exports (% of manufactured exports)') and year = '2012'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('Imports of goods and services (current US$)') and year = '1992'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('Imports of goods and services (current US$)') and year = '2012'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('Exports of goods and services (current US$)') and year = '1992'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

select
	CountryName
	,round(value) wartosc
from Indicators i 
where IndicatorName in('Exports of goods and services (current US$)') and year = '2012'
and CountryName in ('Armenia', 'Azerbaijan', 'Belarus', 'Estonia', 'Georgia', 'Kazakhstan', 'Kyrgyz Republic', 'Latvia', 'Lithuania',
'Moldova', 'Poland', 'Tajikistan', 'Turkmenistan', 'Ukraine', 'Uzbekistan')
order by round(value) desc

