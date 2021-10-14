// This doesn't work...


MATCH (a:Athlete) - [r1:REPRESENTS] -> (co1:Country) - [p1:PARTICIPATES] -> (d1:Discipline)
MATCH (c:Couch) - [r2:REPRESENTS] -> (co2:Country) - [p2:PARTICIPATES] -> (d2:Discipline)
MERGE (c) - [:INSTRUCTS] -> (a)