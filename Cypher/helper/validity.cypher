// Checking graph to see if the data model is valid


// Find Coaches with Country and Sport Anchors
MATCH (d:Discipline{name:'Hockey'}) <- [:COACHES] - (c:Coach) - [:REPRESENTS] -> (co:Country{name:'Germany'}) WITH d.name as Sport, collect(c.name) as Coaches, co.name as Country RETURN Sport,Country,Coaches


// This Blows up...
// Find Athletes,Coaches given Country and Sport Anchors

MATCH (a:Athlete) - [:PLAYS] -> (d:Discipline{name:'Hockey'}) <- [:COACHES] - (c:Coach) - [:REPRESENTS] -> (co:Country{name:'Germany'})
WITH d.name as Sport, collect(c.name) as Coaches,collect(a) as Athletes, co.name as Country RETURN Sport,Country,Coaches,Athletes




