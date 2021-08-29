The fall of the unsinkable ship : Titanic EDA
By Naphat Sanguansakpakdee

The night that the RMS Titanic sink under dark cold North Atlantic sea is unarguably one of the most tragic disaster in modern history, with more than 1500 lives lost. If there is anything we could learn from this tragedy, that would be the Edwardian era life-death situation that the sink of titanic allows us to peek into. This is the the rare large collection of dataset that we would explore in this exploratory data analysis.  

## Titanic Dataset Overview

In this first section we will discuss basic information of the dataset, especially the meaning of each variable. . Otherwise, we could “sail” nowhere without a proper introduction to our 12 variables, listed in the following table :

| Variable Name | Meaning   | Possible Value |
|———————|—|—|
| PassengerID | Identification number   | Integer (1- 891) |
| survival      | State of survival | 0 = No, 1 = Yes  |
| pclass        | Ticket class | 1= First , 2= Second, 3 = Third  |
| Name| Passenger name| string  |
| sex           |  Gender | male,female  |
| age           | Passenger Age (year)  |  Decimal (0.42-80)  |
| sibsp         | Count of siblings and spouses on board  | Integer (0-8)  |
| parch         | Count of parents and children on board | Integer (0-6)  |
| fare | Ticket fare| Decimal (0.00-512.33) |
| ticket        | Ticket number | String |
| cabin         | Cabin number | String  |
| embarked      |  Embarkation Port | C = Cherbourg, Q = Queenstown, S = Southampton  |

To elaborate, the training data contain 891 passengers. 

1. Each passenger is identified with PassengerID starting from 1 to 891. 

2. Survival is a binary label for survival state of each passenger. In fact, survival is a subject matter for machine learning prediction challenge. In other word, survival is the output variable. The survived passenger is labeled as “1”, and the deceased one is labeled as “0”. 

3. Pclass is the ticket class of the passenger, in which “1”, “2” and “3” stand for first-class, second-class and third-class ticket respectively.

Interestingly, these labels also refer to socio-economic status (SES) whereas first-class ticket is a proxy for the upper-class. Second-class refers to the middle-class and Third-class ticket represents the lower-class. From historical perspective, this connection shows us that accessibility to Titanic is a direct indicator of wealth during 1912.

4.Name of the passenger is listed as string.

5.Sex indicates biological gender of the passenger, “male” and “female”.

6.Age is of the number of years of each passenger age. The age with nearest hundredth decimal represents the month in age. For instance, 0.42 is an approximation of 5 month old passenger (0.416666.. year). 

7.Sibsp is a number of siblings and spouses, of that passenger, boarding the Titanic. In other word, the siblings and spouses are not counted if they are not on the Titanic ship. "Sibling" includes both biological brother/sister and stepbrother/stepsister. However, "Spouse" defines narrowly husband and wife relationship, excluding mistress and financé. 

8.Parch is a number of parent and child 

9.Fare is the price of the ticket in British pound that passenger purchase. Note that some passenger fare is 0.00  

10.Ticket The ticket number of the passenger
11.Cabin The cabin number of the passenger on the Titanic
12.Embarked The port that the passenger embark on the Titanic

## Quantitative Attribute
Mean and S.D.

## Qualitative
##Skew 




