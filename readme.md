
# Olympics Demo  

## Introduction

First attempt at creating a Neo4j Graph from multiple, disparate/disjointed data sources (in this case multiple csv files with common fields). 


* Logic is all written in Cypher (/Cypher) 
* Orchestrated externally via apache airflow 

## Source Files: 

s3://neo4j-alexanderfournier/Demos/Olympics/


## Issues:

* Python script (util/xmlConverter) to convert xslx is broken. Actually more of a pain than I had considered changing the encoding to be. Abandoned & manually converted
*  The data model doesn't seem to be right... 
*  The data was loaded improperly and isn't consistent/correct (see screenshot below)

![](images/somethingwrong.png)






## Business Questions Looking to Answer: 

* Who Coaches for a Particular Sport and A Particular Country?
* Countries Participating in the Most Sports, With the highest medal counts?
* Are there any coaches that are also atheletes?


## Data Model
#### Issues:
* There seems like there are a lot of circular relationships - not sure if that is best practice...

![Data Model](images/Olympics_Data_Model.png)


## Alternative Data Models



### Alternative 1: 

#### Issues:
* Logically doesn't really make a ton of sense... what do you do with country
![Data Model](images/Olympics-2.png)


### Alternative 2:

#### Issues:
* This might be better. I'm trying to create an 'intermediate node' or 'hyperedge'. Don't think I'm implementing correctly though...

![Data Model2](images/Olympics-3.png)


