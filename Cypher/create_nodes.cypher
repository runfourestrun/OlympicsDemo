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

:param header => 'NOC';
:param file => 'Coaches.csv';
CALL apoc.load.csv($file, {header:true}) yield map as row
MERGE (c:Country {name:row[$header]})



//Trying to use APOC to speed up loading via Batch Processing
// This works!!

:param header => 'NOC';
:param file => 'Coaches.csv';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row', 'MERGE (c:Country {name:row[$header]})', {batchSize:500,parrallel:true,params: {file:$file,header:$header}})


//Now Let's Merge in the Coach Nodes


:param header => 'Name';
:param file => 'Coaches.csv';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row', 'MERGE (c:Person:Coach {name:row[$header]})', {batchSize:500,parrallel:true,params: {file:$file,header:$header}})




//Now we need to create relationships... the hard part...













// Let's create


//Why doesn't this work....
//https://stackoverflow.com/questions/60575729/how-to-pass-multiple-parameters-to-the-neo4j-browser
//:param [{file,header}] => {'Coaches.csv' as file,'NOC' as header}

