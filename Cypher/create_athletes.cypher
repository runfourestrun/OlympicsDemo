

// Let's introduce a second CSV file... :/


:param file => 'Athletes.csv';
:param country_name_header => 'NOC';
:param player_name_header => 'Name';
:param discipline_name_header => 'Discipline';
CALL apoc.periodic.iterate (
'CALL apoc.load.csv($file, {header:true}) yield map as row',
'
MERGE (p:Person:Athlete {name:row[$player_name_header]})
MERGE (c:Country {name:row[$country_name_header]})
MERGE (d:Discipline {name:row[$discipline_name_header]})
MERGE (p) - [:REPRESENTS] -> (c)
MERGE (p) - [:PLAYS] -(d)
MERGE (c) - [:PARTICIPATES] -> (d)
'
, {batchSize:500,parallel:true,params: {file:$file,country_name_header:$country_name_header,player_name_header:$player_name_header,discipline_name_header:$discipline_name_header}})

