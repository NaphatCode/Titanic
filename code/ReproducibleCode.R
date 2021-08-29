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
#Pie chart
s <- c(342,549 )
labels <- c("Survived (38.38%)", "Not Survived (61.62%)")
pie(x,labels,radius = 1.5,main = "Survival state of 891 passengers")
p <- c(216,184,491)
labels <- c("First-class (24.24%)", "Second-class (20.65%)","Third-class (55.11%)")
pie(p,labels,radius = 1.5,main = "Ticket Class of 891 passengers")
se <- c(314,577 )
labels <- c("Female (35.24%)", "Male (64.76%)")
pie(se,labels,radius = 1.5,main = "Gender of 891 passengers")
e <- c(2,168,77,549 )
labels <- c("Unknown (0.22%)", "Cherbourg (18.86%)"," Queenstown (8.64%)","Southampton (72.28%)")
pie(e,labels,radius=1.5,main = "Embarkation port of 891 passengers")

#Age-Survived
boxplot(df.raw$Age ~ df.raw$Survived,
        main =  "Age Boxplot Comparison between Survivor and Non-survivor  ",
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        )

ggplot(df.raw, aes(x=Age, fill=factor(Survived))) +
  geom_histogram(bins=30)+
  #facet_grid(.~Sex)+
  ggtitle("Age vs Survived")+
  scale_fill_discrete(name="Survived")

#Sex-Survived
ggplot(data=df.raw,aes(Sex, fill = factor(Survived)))+geom_bar(stat = "count", position = "fill") +xlab("Sex") + scale_fill_discrete(name = "Survival Percentage")+ylab("Passenger") + ggtitle("Proportion of Survivor Gender")+scale_y_continuous(labels = function(x) paste0(x*100, "%"))+scale_fill_brewer()

#Parch SibSp Sur
# Scatter plot
Parch <- df.raw$Parch
SibSp <- df.raw$SibSp
z <- df.raw$Survived
plot(Parch, SibSp,
     pch = 19,
     col = factor(z),
     main = "Scatter plot by group of Survivor state")

# Legend
legend("topleft",
       legend = levels(factor(z)),
       pch = 19,
       col = factor(levels(factor(z)))) 

#PClass Embarked Survied
# Scatter plot
Pclass <- df.raw$Pclass
Embarked <- df.raw$Embarked
z <- df.raw$Survived
plot(Pclass, Embarked,
     pch = 19,
     col = factor(z),
     main = "Scatter plot by group of Survivor state (Pclass,Embarked)")

# Legend
legend("topleft",
       legend = levels(factor(z)),
       pch = 19,
       col = factor(levels(factor(z)))) 
