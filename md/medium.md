# The fall of the unsinkable ship : Titanic EDA

**By Naphat Sanguansakpakdee**

The night that the RMS Titanic sink under dark cold North Atlantic sea is unarguably one of the most tragic disaster in modern history, with more than 1500 lives lost. If there is anything we could learn from this tragedy, that would be the Edwardian era life-death situation that the sink of titanic allows us to peek into. This is the the rare large collection of dataset that we would explore in this exploratory data analysis.  

Disclaimer : This EDA is written as a "study note" upon assumption that the reader is a beginner in R just like this author. Thus several basic topic such as dataframe is mentioned elaborately. - Naphat   

## Titanic Dataset Overview

In this first section we will discuss basic information of the dataset, especially the meaning of each variable. Otherwise, we could “sail” nowhere without a proper introduction to our 12 variables, listed in the following table :


| Variable Name |        Meaning        |                 Possible Value                 |
|:-------------:|:---------------------:|:----------------------------------------------:|
| PassengerID   | Identification number | Integer (1- 891)                               |
| survival      | State of survival     | 0 = No, 1 = Yes                                |
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

  2.  **Survival** is a binary label for **survival state** of each passenger from the accident. In fact, survival is a subject matter for machine learning prediction challenge. In other word, survival is the output variable. The survived passenger is labeled as “1”, and the deceased one is labeled as “0”. 

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

![dimension]()

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

![head()]()

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

![quan plot()]() 

Three observation can be remarked 

1.**Age** mean is 29.70 years with S.D. = 14.53. This means that the average age of 891 passenger fall within young adulthood range. Age is the second most spread out quantitative variables. This finding associates with the context of data. RMS Titanic's maiden vayage had two responsibilities. First priority is transport passenger back and forth. The second is to carry mail and substantial cargo from Europe to North America. Therefore, the ship carried both the wealth and the immigrant from Great Britain, Ireland and Scandinavia. The immigrants starting new life at new continental should be among young adulthood range. 

2.The average of **SibSp** and **Parch** are 0.52 and 0.38 respectively. It is obvious that number of people could not be a decimal. However, by specifying these two variable as continuous to calculate the mean, it is evident that the passenger rarely brought their relatives together with them. The low S.D. for SibSp and Parch, 1.10 and 0.81 respectively, supports this observation. The reason that SibSp has a slightly higher average and S.D., estimated as 1 by default setting, resonate with the  


## Qualitative
## Skew 




