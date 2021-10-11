LOAD CSV WITH HEADERS FROM 'file:///Athletes.csv' AS row
CREATE (p:Person:Athlete {name:row.Name})
CREATE (c:Country {name:row.NOC})
CREATE (s:Sport {name:row.Discipline})

//Just using LOAD CSV Clause
LOAD CSV WITH HEADERS from 'file:///Coaches.csv' AS row',
CREATE (p:Person:Coach {name:row.Name})
MERGE(c:Country {name:row.NOC})
MERGE(s:Sport {name:row.Discipline})




//Trying to use APOC to speed up loading via Batch Processing