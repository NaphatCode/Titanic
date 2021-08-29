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
# mean and sd in table
df.quan %>% 
  tbl_summary(
    type = list(SibSp ~ 'continuous',Parch ~ 'continuous'),
    statistic = list(all_continuous()~"{mean} ({sd})"),
    digits = list(all_continuous()~c(2,2))
  )

#boxplot
boxplot(df.quan,
        main = "Box Plot of Quantitative Variables ",
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE
)

#separate four variables into new dataframe
df.qual <- df.raw %>% select(Survived,Pclass,Sex,Embarked)
#summarize into a table
df.qual %>% 
  tbl_summary(
    digits = list(all_categorical()~c(0,2)),
    
  )

df.qual$Survived<-ifelse(df.qual$Survived==2,0,1)
df.qual

# Create data for the graph.
s <- c(342,549 )
labels <- c("Survived (38.38%)", "Not Survived (61.62%)")
# Plot the chart.
pie(x,labels,radius = 1.5,main = "Survival state of 891 passengers")

p <- c(216,184,491)
labels <- c("First-class (24.24%)", "Second-class (20.65%)","Third-class (55.11%)")
pie(p,labels,radius = 1.5,main = "Ticket Class of 891 passengers")

# sex pie plot
se <- c(314,577 )
labels <- c("Female (35.24%)", "Male (64.76%)")
pie(se,labels,radius = 1.5,main = "Gender of 891 passengers")

e <- c(2,168,77,549 )
labels <- c("Unknown (0.22%)", "Cherbourg (18.86%)"," Queenstown (8.64%)","Southampton (72.28%)")
pie(e,labels,radius=1.5,main = "Embarkation port of 891 passengers")