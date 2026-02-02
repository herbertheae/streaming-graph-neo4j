-- ========================================
-- Consultas de Negócio: Recomendações
-- ========================================

-- 1. Recomendação por gênero (usuários que curtiram X também gostaram de Y)
MATCH (u:User {name: 'Ana Silva'})-[:WATCHED {rating: r}]->(m:Movie)-[:BELONGS_TO]->(g:Genre),
      (rec:Movie)-[:BELONGS_TO]->(g)
WHERE r >= 8.0 AND NOT (u)-[:WATCHED]->(rec)
RETURN rec.title AS recomendacao, g.name AS genero, rec.rating
ORDER BY rec.rating DESC
LIMIT 3;

-- 2. Atores em comum entre filmes assistidos
MATCH (u:User {name: 'Ana Silva'})-[:WATCHED]->(m1:Movie),
      (u)-[:WATCHED]->(m2:Movie),
      (m1)<-[:ACTED_IN]-(a:Actor)-[:ACTED_IN]->(m2)
WHERE m1 <> m2
RETURN DISTINCT a.name AS ator_em_comum, m1.title AS filme1, m2.title AS filme2;

-- 3. Recomendação por diretor + gênero
MATCH (u:User {name: 'Ana Silva'})-[:WATCHED]->(m:Movie)-[:BELONGS_TO]->(g:Genre),
      (m)<-[:DIRECTED]-(d:Director),
      (rec:Movie)-[:DIRECTED]->(d)-[:BELONGS_TO]->(g)
WHERE NOT (u)-[:WATCHED]->(rec)
RETURN rec.title AS recomendacao, d.name AS diretor, g.name AS genero
LIMIT 2;
