library(choroplethr)
library(choroplethrMaps)
library(readxl)
library(tidyverse)
library(tree)
library(class)

#choropleth maps
df <- read_excel('food.xls')

#table with rows with data not split by race
total = df %>% filter(race_eth_code == 9)
total = total[-1,]
write.csv(total,'total.csv')

#df with fips and cost
cost = total[,c('county_fips','cost_yr')]
cost = na.omit(cost)
colnames(cost) = c('region','value')
cost = cost[-which(duplicated(cost$region)), ]
cost$region = sub('.', '', cost$region)
cost$region = as.integer(cost$region)

county_choropleth(cost, 
                  title  = "Annual Cost of Food by County 2006-2010", 
                  legend = "Cost($)",
                  state_zoom = 'california')

afford = total[,c('county_fips','affordability_ratio')]
afford = na.omit(afford)
colnames(afford) = c('region','value')
afford = afford[-which(duplicated(afford$region)), ]
afford$region = sub('.', '', afford$region)
afford$region = as.integer(afford$region)

county_choropleth(afford, 
                  title  = "Affordability Ratio by County 2006-2010", 
                  legend = "Affordability Ratio",
                  state_zoom = 'california')

fam = total[,c('county_fips','ave_fam_size')]
fam = na.omit(fam)
colnames(fam) = c('region','value')
fam = fam[-which(duplicated(fam$region)), ]
fam$region = sub('.', '', fam$region)
fam$region = as.integer(fam$region)

county_choropleth(fam, 
                  title  = "Average Family Size by County 2006-2010", 
                  legend = "Average Family Size Ratio",
                  state_zoom = 'california')


dec = total[,c('county_fips','food_afford_decile')]
dec = na.omit(dec)
colnames(dec) = c('region','value')
dec = dec[-which(duplicated(dec$region)), ]
dec$region = sub('.', '', dec$region)
dec$region = as.integer(dec$region)

county_choropleth(dec, 
                  title  = "Food Affordability Decile by County 2006-2010", 
                  legend = "Food Affordability Decile",
                  state_zoom = 'california',
                  num_colors = 9)


#classification tree to determine affordability ratio
tree.region = tree(region_code~cost_yr+median_income+ave_fam_size,df)
tree.region
plot(tree.region)
text(tree.region,pretty = 0)

tree.afford = tree(median_income~region_code+ave_fam_size+cost_yr,df)
tree.afford
plot(tree.afford)
text(tree.afford,pretty = 0)

