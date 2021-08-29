#Naphat Sanguansakpakdee 
#6437931 M.S. MedBif Siriraj

#import dataset as a dataframe named 'df.raw'
df.raw = read.csv("~/development/Titanic/data/train.csv")

#summarize the dataframe by column
summary(df.raw) 

#reaffirm the dimension
nrow(df.raw)
ncol(df.raw)
dim(df.raw)
length(df.raw)

# install.packages("gtsummary")
library(gtsummary)
head(df.raw)
tbl_summary(df.raw)

# subset of columns
df.quan <- df.raw %>% select(Age,SibSp,Parch,Fare)
df.quan %>% 
  tbl_summary(
    type = list(SibSp ~ 'continuous',Parch ~ 'continuous'),
    statistic = list(all_continuous()~"{mean} ({sd})"),
    digits = list(all_continuous()~c(2,2))
  )
