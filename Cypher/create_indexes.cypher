// Not sure if this is best practice ... What do I do for indexing multi label nodes?
CREATE INDEX athlete_name_idx FOR (p:Person) on (p.name)