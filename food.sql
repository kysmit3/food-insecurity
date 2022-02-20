SELECT race_eth_name, ROUND(AVG(median_income),2) FROM afford
GROUP BY race_eth_name;

SELECT region_name, ROUND(AVG(cost_yr),0) FROM afford
GROUP BY region_name;

SELECT county_name, ROUND(AVG(affordability_ratio),4) FROM afford
GROUP BY county_name
ORDER BY AVG(affordability_ratio) ASC
FETCH NEXT 5 ROWS ONLY;