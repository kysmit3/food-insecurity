#import libraries
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np

#read in data
df = pd.read_excel('food.xls')

#data manipulation/subsetting
race = df[['race_eth_name','affordability_ratio']]
racecost = df[['race_eth_name','cost_yr']]
racemed = df[['race_eth_name','median_income']]
racefam = df[['race_eth_name','ave_fam_size']]

#group by race and remove total column to look by race
racemean = race.groupby(['race_eth_name']).mean()
racemean = racemean.drop('Total').reset_index()

medmean = racemed.groupby(['race_eth_name']).mean()
medmean = medmean.drop('Total').reset_index()

fammean = racefam.groupby(['race_eth_name']).mean()
fammean = fammean.drop('Total').reset_index()

#Food affordability in CA by race
r = sns.barplot(racemean['race_eth_name'],racemean['affordability_ratio'],palette = "husl")
r.set_xlabel('Race')
r.set_ylabel('Affordability Ratio')
r.set_title('Food Affordability in California by Race 2006-2010')

#median income by race
m = sns.barplot(medmean['race_eth_name'],medmean['median_income'],palette = "husl")
m.set_xlabel('Race')
m.set_ylabel('Median Income')
m.set_title('Median Income in California by Race 2006-2010')

#all race without the total column
nottotal = df.loc[df['race_eth_code']!= 9]

#scatter plot of cost by income
g = sns.scatterplot(nottotal['cost_yr'],nottotal['median_income'], hue = nottotal['race_eth_name'],palette = "Set2")
plt.legend(title = 'Race')
sns.color_palette("Set2")
g.set_title('Annual Food Cost by Annual Median Income by Race in CA 2006-2010')
g.set_xlabel('Annual Cost ($)')
g.set_ylabel('Median Income ($)')
plt.show()