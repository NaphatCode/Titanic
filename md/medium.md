The fall of the unsinkable ship : Titanic EDA
By Naphat Sanguansakpakdee

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

**table 1 : variable definition**

  
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

## Quantitative Attribute
Now that we could recognize our variable, let's make a firm handshake with them. 

We start by importing our training data, and then kindly ask Rstudio to summarize the data with command "summary()" 


```df.raw = read.csv("~/development/Titanic/data/train.csv")
summary(df.raw)
```

At this point our 891 rows, 12 columns of Titanic training data is "stored" as object in global environment. As the original file comes with file extension ".csv", our object is stored as a dataframe. Dataframe can be practically considered as a table format for R.

I named this dataframe as df.raw, which later on we will call this object by this name in other commands. 

"summary" will display some useful statistical value of each column as shown below 

<p align="center">
<img width="400" alt="summary"  src="https://user-images.githubusercontent.com/65748521/131241040-9d0219e0-e509-4e9b-a309-c4993a5e2e39.png">
</p>

We can reaffirm the dimension (the size) of our dataframe by
following command

nrow(df.raw)


## Qualitative
##Skew 




