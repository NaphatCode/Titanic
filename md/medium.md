# The fall of the unsinkable ship : Titanic EDA

**By Naphat Sanguansakpakdee**

The night that the RMS Titanic sink under dark cold North Atlantic sea is unarguably one of the most tragic disaster in modern history, with more than 1500 lives lost. If there is anything we could learn from this tragedy, that would be the Edwardian era life-death situation that the sink of Titanic allows us to peek into. This is the the rare large collection of dataset that we would explore in this exploratory data analysis.  

>Disclaimer : This EDA is written as a "study note" upon assumption that the reader is a beginner in R just like this author. Thus several basic topic such as dataframe is mentioned elaborately. - Naphat   

## Titanic Dataset Overview

In this first section we will discuss basic information of the dataset, especially the meaning of each variable. Otherwise, we could “sail” nowhere without a proper introduction to our 12 variables, listed in the following table :


| Variable Name |        Meaning        |                 Possible Value                 |
|:-------------:|:---------------------:|:----------------------------------------------:|
| PassengerID   | Identification number | Integer (1- 891)                               |
| survived      | State of survival     | 0 = No, 1 = Yes                                |
| pclass        | Ticket class          | 1= First , 2= Second, 3 = Third                |
| Name          | Passenger name        | String                                         |
| sex           | Gender                | male,female                                    |
| age           | Passenger Age (year)  | Decimal (0.42-80)                              |
| sibsp         | #siblings and spouses | Integer (0-8)                                  |
| parch         | #parents and children | Integer (0-6)                                  |
| fare          | Ticket fare           | Decimal (0.00-512.33)                          |
| ticket        | Ticket number         | String                                         |
| cabin         | Cabin number          | String                                         |
| embarked      | Embarkation Port      | C = Cherbourg, Q = Queenstown, S = Southampton |


  
To elaborate, the training data contains 891 passengers. 

  1.  Each passenger is identified with **PassengerID** starting from 1 to 891. 

  2.  **Survived** is a binary label for **survival state** of each passenger from the accident. In fact, survival is a subject matter for machine learning prediction challenge. In other word, survival is the output variable. The survived passenger is labeled as “1”, and the deceased one is labeled as “0”. 

  3.  **Pclass** is the ticket class of the passenger, in which “1”, “2” and “3” stand for first-class, second-class and third-class ticket respectively. Interestingly, these labels also refer to socio-economic status (SES) whereas first-class ticket is a proxy for the upper-class. Second-class refers to the middle-class and Third-class ticket represents the lower-class. From historical perspective, this connection shows us that accessibility to Titanic is a direct indicator of wealth during 1912.

  4.  **Name** of the passenger is listed as string.

  5.  **Sex** indicates **biological gender** of the passenger, “male” and “female”.

  6.  **Age** is of the number of years of **each passenger age**. The age with nearest hundredth decimal represents the month in   age. For instance, 0.42 is an approximation of 5 month old passenger (0.416666.. year). 

  7.  **Sibsp** is a number of **siblings and spouses, of that passenger, boarding the Titanic**. In other word, the siblings and spouses are not counted if they are not on the Titanic ship. "Sibling" includes both biological brother/sister andstepbrother/stepsister. However, "Spouse" defines narrowly husband and wife relationship, excluding mistress and financé. 

  8.  **Parch** is a number of **passenger's parent and child boarding the ship**. Heed that guardian with non-relative relationship such as nanny is not counted. Therefore the children travelling with the nanny is recorded with parch=0.

  9.  **Fare** is the **price of the ticket** in British pound that passenger purchase. Note that some passenger fare is 0.00, meaning that the passenger did not pay for the ticket.   

  10. **Ticket** is the combination of letter and number printed on ticket of the passenger.

  11. **Cabin** is the **cabin number** assigned to the passenger on the Titanic. 

  12. **Embarked** is the **embarkation port** of the passenger consisting of three locations, which are Cherbourg, Queenstown and Southampton.
  
  We can reaffirm the dimension (the size) of our dataframe by
following command

```

nrow(df.raw)
ncol(df.row)
dim(df.row)
length(df.row)

```

The output will look like this 

![dimension](<img width="309" alt="dimension" src="https://user-images.githubusercontent.com/65748521/131267094-2e0cb824-b895-4dd8-a51c-f4c403d766e8.png">)


## Quantitative Attribute
Now that we could recognize our variable, let's make a firm handshake with them. 

We start by importing our training data, and then kindly ask Rstudio to summarize the data with command "summary()" 


```

df.raw = read.csv("~/development/Titanic/data/train.csv")
summary(df.raw)

```

At this point our 891 rows, 12 columns of Titanic training data is "stored" as object in global environment. As the original file comes with file extension ".csv", our object is stored as a dataframe. Dataframe can be practically considered as a table format for R.

I named this dataframe as df.raw, which later on we will call this object by this name in other commands. 

"summary" will display some useful statistical value of each column as shown below 

<p align="center">
<img width="400" alt="summary"  src="https://user-images.githubusercontent.com/65748521/131241040-9d0219e0-e509-4e9b-a309-c4993a5e2e39.png">
</p>

These summary is useful but not in the most organized format for presentation. 
Therefore let's use similar command to generate statistical value instead

tbl_summary() is a command from **library gtsummary** 
that can summarize the result in a beautiful grid.

We need to install package by this command in the console first.

```
install.packages("gtsummary")
```
After a few second the packages should be automatically downloaded and successfully installed.

Next step is intializing the library 
We call for first six rows of df.raw by command head().    

```

library(gtsummary)
head(df.raw)

```

This output belowed is a quick display in case we need to peek back into our dataframe.

<img width="1082" alt="head" src="https://user-images.githubusercontent.com/65748521/131267115-ed64477d-5357-44c7-b456-c2cd4c9a77cc.png">

From this output, together with the overview of each variable definition, only some variables are **quantitative**.
In other word, they are numbers that can be calculate statistically without losing real-world meaning.

The four quantitative variables in Titanic dataset are 
  - **Age**
  - **Sibsp**
  - **Parch**
  - **Fare**

Let's extract these four columns/variables from df.raw into new dataframe named "df.quan".

```
df.quan <- df.raw %>% select(Age,SibSp,Parch,Fare)

```

This separation allow us handle the parameters in tbl_summary() easier.
To generate summary table, run these following command lines. 

```
df.quan %>% 
  tbl_summary(
    type = list(SibSp ~ 'continuous',Parch ~ 'continuous'),
    statistic = list(all_continuous()~"{mean} ({sd})"),
    digits = list(all_continuous()~c(2,2))
  )
```
The output from tbl_summary() is customizable by these parameters 

> type= list(SibSp~'continuous',Parch~'continuous')

**type** tells R that we consider SibSp and Parch as continuous variable.
tbl_summary() recognizes these two variable as qualitative/discrete variable by default.
In fact, we will discuss this point very soon

>statistic = list(all_continuous()~"{mean} ({sd})"),

**statistic** specifies the statistical value that we want R to compute.
**all_continuous()** refers to all continuous variable in dataframe df.quan,
which R will compute for **Mean** and **Standard deviation** as specified with **{mean} ({sd})**. 

>digits = list(all_continuous()~c(2,2))

**digits** tells R how many decimal places are expected for each statistical value. 
If this paramter is omitted, the default setting of tbl_summary() will estimated the calculation to integer.
This lead to Parch's mean = 0 in an initial try.

All these customization result this table output

(![quan plot](https://user-images.githubusercontent.com/65748521/131267165-24b3c7de-0d56-4a9f-89ea-4c63dad24865.png)


Three observation can be remarked 

1.**Age** mean is 29.70 years with S.D. = 14.53. This means that the average age of 891 passenger fall within young adulthood range. Age is the second most spread out quantitative variables. This finding associates with the context of data. RMS Titanic's maiden vayage had two responsibilities. First priority is transport passenger back and forth the North Atlantic. The second is to carry mail and substantial cargo from Europe to North America. Therefore, the ship carried both the wealth and the immigrant from Great Britain, Ireland and Scandinavia. The immigrants starting new life at new continental should be among young adulthood range. 

2.The average of **SibSp** and **Parch** are 0.52 and 0.38 respectively. It is obvious that number of people could not be a decimal. However, by specifying these two variable as continuous to calculate the mean, it is evident that the passenger rarely brought their relatives together with them. The low S.D. for SibSp and Parch, 1.10 and 0.81 respectively, supports this observation. The reason that SibSp has a slightly higher average and S.D., estimated as 1 by default setting, resonate with the reasoning that a couple would aboard the ship together.

3.**Fare** displays 32.20 British pounds for average with highest S.D. among four quantitative variables (49.69). This finding associates the rigid separation of ticket classes, that cause the fare ticket to fluctuate among 891 passengers.

Another useful figure that can visualize quantitative data is a box plot. Recall that summary() could display min, max, Q1, Q2 and Q3 as well, but not in graphical presentation.

The command lines for boxplot is 

```

boxplot(df.quan,
        main = "Box Plot of Quantitative Variables ",
        col = "orange", #color of the plot 
        border = "brown", #border color
        horizontal = TRUE, #direction of the plot
        notch = TRUE
)

```

(![boxplot quan](https://user-images.githubusercontent.com/65748521/131267176-ee24bc75-68f9-4074-b9ad-31af13df2b6d.png)

From box plot, **Fare** is drastically manipulated by an outliner that exceed 500 British pounds.
For future work in machine learning pipeline, this problem will need to be handled.
Handling an outliner might be out of scope of EDA, but visualizing data with box plot allow us 
to stress the impact of the maximum in variable **Fare**, more than classical output from summary() could 
show by its numerical presentation.  

This section inspires a further analysis to find potential predictor for survival :

1. Relationship between age-survival.

2. Relationship between Parch-SibSp-survival

, which will be explored through graphical method in later section.

## Qualitative Attributes

Before we investigate correlation between quantitative variables and survival of passenger further, let's 
take a good look at our **qualitative variables**.

The 4 qualitative variables in Titanic dataset that we can investigate by statistics are 
-**Survived** : 0 = No, 1=Yes
-**Pclass**   : 1 = First-class, 2 = Second-class, 3 = Third-class
-**Sex**      : male,female
-**Embarked** : C = Cherbourg, Q = Queenstown, S = Southampton

One might notice that PassengerID, Name, Ticket and Cabin are not included.
These variables are all personal information without pattern/repetition.

Cabin and Ticket might possibly contain information of the location of the passenger room.
However, **Pclass** contains same information in much more rigid manner, because the location of the passenger room is already assigned by the ticket class.

tbl_summary() is still a useful tool. we just need to alter our command a little bit

```

#separate four variables into new dataframe
df.qual <- df.raw %>% select(Survived,Pclass,Sex,Embarked)
#summarize into a table
df.qual %>% 
  tbl_summary(
    digits = list(all_categorical()~c(2,2))
  )
  
```
tbl_summary() counts a frequency of each value of qualitative variables, and compute the percentage by default setting. Thus we don't need to specify anything**statistics** parameter.

>    digits = list(all_categorical()~c(0,2))

We refer all qualitative variables in df.qual with **all_categorical()**. This command line will increase decimal places of percentage for more precise calculation. 

The output looks like this 

![qual table](![qual table](https://user-images.githubusercontent.com/65748521/131267181-68582273-72e0-493b-b133-f1978c401d35.png)

Initial observation by this numerical presentation tell us that :

1. Only 38.38% of 891 passengers survived from the incident, considered as about one third of all 891 passengers.
2. The majority of passenger held third-class ticket (55.11%). 
3. Male passenger (65.34%) are almost twice of female passenger (35.24%).
4. Most of the passenger embark on the ship at Southampton (72.28%), followed by Cherbourg (18.86%) and Queenstown (8.64%). Embarkation of two passenger is unknown

This information could be more useful with more visual presentation.

```
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
```

We utilize pie() to create pie chart for each categorical variable.
Pie chart is the optimal way to illustrate proportion of data within the same variables across the sample. Another perk of pie() is that the parameter is very straightforward. The output looks like this.

Represented in pie chart, the binary value of survival and gender of the passenger are distributed in a very similar proportion. This inspire us to find relationship between Survived-Sex. 



![surpie](https://user-images.githubusercontent.com/65748521/131267198-88332a67-667d-46fb-9413-fcc876a30c72.png)

![empie](https://user-images.githubusercontent.com/65748521/131267209-4ae5ccc0-9369-4fbe-97aa-d34153c66a39.png)
![sexpie](https://user-images.githubusercontent.com/65748521/131267218-1d0becb9-2599-42c1-ba1b-2dc33adb19ea.png)
![pclasspie](https://user-images.githubusercontent.com/65748521/131267221-67723937-b707-4d90-8a37-8e548132b505.png)


## Analysis for Potential Predictor

In this section, we dissect our data further to accomplish the objective of exploratory data analysis.
We start looking for correlation between each variable and **Survived** (Survival state). 
Our objection is the potential survival predictor for survival. The finding from this section could 
be used to reasonably select an attribute in machine learning, or even feature engineering.

Recall that there are some inspiration from prior section that now we will jump right in

### 1. Relationship between Age-Survived.

Investigating Age-Survived means that we are looking for connection between these two variable.
Some age might have more survivor. To visualize, we could use grouped boxplot. We can boxplot the age of those who survive the disaster, compared with those who did not.

The command for grouped boxplot are
```
boxplot(df.raw$Age ~ df.raw$Survived,
        main =  "Age Boxplot Comparison between Survivor and Non-survivor  ",
        col = "orange",
        border = "brown",
        horizontal = TRUE,
        notch = TRUE
        )

```

The output looks like this

![ageboxsur](https://user-images.githubusercontent.com/65748521/131267231-69ae69e2-260c-44c0-93b3-28cb8b6c1e0f.png)

From the grouped boxplot, age does not show a high potential relationship. 
Good predictor should have a distinct difference among two groups.
In this case, mean of survivor age and non-survivor is almost identical.

However let's not jump to conclusion and observe histogram of Age-Survived

```

ggplot(df.raw, aes(x=Age, fill=factor(Survived))) +
  geom_histogram(bins=30)+
  ggtitle("Age vs Survived")+
  scale_fill_discrete(name="Survived")
  
```
![agesurhist](https://user-images.githubusercontent.com/65748521/131267249-d70fe1ed-8431-4ae3-906f-c0dac84f5723.png)

On the contrary, this histogram show useful information for prediction.



### 2. Relationship between Parch-SibSp-Survived

For three categorical variables relationship, let's use scatter plot by group.

```
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
```

The Scatter plot by group looks like this

![scat sib par](https://user-images.githubusercontent.com/65748521/131267280-9ce2eb2d-a727-4b2c-962b-3e9d0286f064.png)




### 3. Relationship between Sex-Survived

We'll choose percentage barplot to compare gender of survivor and non-survivor. The command lines are as followed.

```

ggplot(data=df.raw,aes(Sex, fill = factor(Survived)))+geom_bar(stat = "count", position = "fill") +xlab("Sex") + scale_fill_discrete(name = "Survival Percentage")+ylab("Passenger") + ggtitle("Proportion of Survivor Gender")+scale_y_continuous(labels = function(x) paste0(x*100, "%"))+scale_fill_brewer()

```

![gendersur](https://user-images.githubusercontent.com/65748521/131267301-c2c3e75f-42cd-4198-82d0-4571827cba78.png)
![age sur hist](https://user-images.githubusercontent.com/65748521/131267306-c6cd2a34-49ba-4ec9-93b6-61416e984b6b.png)


