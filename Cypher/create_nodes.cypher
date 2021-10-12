// Just using LOAD CSV Built-In Function

LOAD CSV WITH HEADERS FROM 'file:///Athletes.csv' AS row
CREATE (p:Person:Athlete {name:row.Name})
CREATE (c:Country {name:row.NOC})
CREATE (s:Sport {name:row.Discipline})

//Just using LOAD CSV Built-In Function

LOAD CSV WITH HEADERS from 'file:///Coaches.csv' AS row',
CREATE (p:Person:Coach {name:row.Name})
MERGE(c:Country {name:row.NOC})
MERGE(s:Sport {name:row.Discipline})


//This works for just load_csv

CALL apoc.load.csv('file:///Coaches.csv', {header:true}) yield map as row return row


// parameterized apoc.load.csv query

:params {file:'Coaches.csv'};
CALL apoc.load.csv($file, {header:true}) yield map as row return row


// Combine paramaterized apoc.load.csv with MERGE statement
// file parameter
//This is the last query that seems to work..
// note the :params vs param

:params {file:'Coaches.csv'};
CALL apoc.load.csv($file, {header:true}) yield map as row
MERGE (c:Country {name:row['NOC']})



//Two distinct parameters - For some reason it only works with the
//Alternative Param Syntax --- that does not work!!!!
:param {header:'NOC'};
:param {file:'Coaches.csv'};
/#################

:param file => 'Coaches.csv';
:param header => 'NOC';
CALL apoc.load.csv($file, {header:true}) yield map as row
MERGE (c:Country {name:row[$header]})



//Trying to use APOC to speed up loading via Batch Processing

// Country Nodes

:param file => 'Coaches.csv';
:param header => 'NOC';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row', 'MERGE (c:Country {name:row[$header]})', {batchSize:500,parrallel:true,params: {file:$file,header:$header}})


//Coach Nodes
// this works

:param file => 'Coaches.csv';
:param header => 'Name';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row',
'MERGE (c:Person:Coach {name:row[$header]})', {batchSize:500,parrallel:true,params: {file:$file,header:$header}})




//Coach & Country Nodes

:param file => 'Coaches.csv';
:param country_name_header => 'NOC';
:param coach_name_header => 'Name';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row',
'MERGE (c:Country {name:row[$country_name_header]})  MERGE (p:Person:Coach {name:row[$coach_name_header]})', {batchSize:500,parrallel:true,params: {file:$file,country_name_header:$country_name_header,coach_name_header:$coach_name_header}})



// Coach,Country Nodes & :REPRESENTS Relationship
:param file => 'Coaches.csv';
:param country_name_header => 'NOC';
:param coach_name_header => 'Name';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row',
'MERGE (c:Country {name:row[$country_name_header]})  MERGE (p:Person:Coach {name:row[$coach_name_header]})
 MERGE (p) - [:REPRESENTS] -> (c)

'
, {batchSize:500,parallel:true,params: {file:$file,country_name_header:$country_name_header,coach_name_header:$coach_name_header}})



// Coach,Country,Discipline Labels/Nodes & :PARTICIPATES, :COACHES, :REPRESENTS Relationships
// I Think this is accurate...
// Helper Queries:
// MATCH p1 = (p:Person{name:'MONTICO Loredana'}) - [:REPRESENTS] -> (c:Country) - [:PARTICIPATES] -> (d) RETURN p1
//


:param file => 'Coaches.csv';
:param country_name_header => 'NOC';
:param coach_name_header => 'Name';
:param discipline_name_header => 'Discipline';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row',
'
 MERGE (c:Country {name:row[$country_name_header]})
 MERGE (p:Person:Coach {name:row[$coach_name_header]})
 MERGE (d:Discipline {name:row[$discipline_name_header]})
 MERGE (p) - [:COACHES] -> (d)
 MERGE (c) - [:PARTICIPATES] -> (d)
 MERGE (p) - [:REPRESENTS] -> (c)
'
, {batchSize:500,parallel:true,params: {file:$file,country_name_header:$country_name_header,coach_name_header:$coach_name_header,discipline_name_header:$discipline_name_header}})



// Let's introduce a second CSV file... :/


:param file => 'Athletes.csv';
:param country_name_header => 'NOC';
:param player_name_header => 'Name';
:param discipline_name_header => 'Discipline';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row',
'
MERGE (p:Person:Athlete {name:row[$player_name_header]})





'
, {batchSize:500,parallel:true,params: {file:$file,country_name_header:$country_name_header,coach_name_header:$coach_name_header,discipline_name_header:$discipline_name_header}})




//Why doesn't this work....
//https://stackoverflow.com/questions/60575729/how-to-pass-multiple-parameters-to-the-neo4j-browser
//:param [{file,header}] => {'Coaches.csv' as file,'NOC' as header}








