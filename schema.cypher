-- ========================================
-- Modelo de Grafos: Serviço de Streaming
-- Entidades: User, Movie, Series, Genre, Actor, Director
-- ========================================

-- Constraints (garantem integridade)
CREATE CONSTRAINT user_id IF NOT EXISTS FOR (u:User) REQUIRE u.id IS UNIQUE;
CREATE CONSTRAINT movie_id IF NOT EXISTS FOR (m:Movie) REQUIRE m.id IS UNIQUE;
CREATE CONSTRAINT series_id IF NOT EXISTS FOR (s:Series) REQUIRE s.id IS UNIQUE;
CREATE CONSTRAINT genre_name IF NOT EXISTS FOR (g:Genre) REQUIRE g.name IS UNIQUE;

-- Índices (otimizam consultas)
CREATE INDEX user_email_idx IF NOT EXISTS FOR (u:User) ON (u.email);
CREATE INDEX content_year_idx IF NOT EXISTS FOR (c:Movie|Series) ON (c.year);

-- ======================
-- DADOS DE EXEMPLO
-- ======================

// Usuários
CREATE (:User {id: 'u001', name: 'Ana Silva', email: 'ana@email.com', created_at: datetime('2024-01-15')});
CREATE (:User {id: 'u002', name: 'Carlos Mendes', email: 'carlos@email.com', created_at: datetime('2024-02-20')});

// Gêneros
CREATE (:Genre {name: 'Ação'});
CREATE (:Genre {name: 'Drama'});
CREATE (:Genre {name: 'Ficção Científica'});

// Filmes
CREATE (:Movie {id: 'm001', title: 'Interestelar', year: 2014, duration: 169, rating: 8.6});
CREATE (:Movie {id: 'm002', title: 'Mad Max: Estrada da Fúria', year: 2015, duration: 120, rating: 8.1});

// Séries
CREATE (:Series {id: 's001', title: 'Dark', year: 2017, seasons: 3});

// Atores e Diretores
CREATE (:Actor {name: 'Matthew McConaughey', birth_year: 1969});
CREATE (:Director {name: 'Christopher Nolan', nationality: 'UK'});

-- Relacionamentos
MATCH (u:User {id: 'u001'}), (m:Movie {id: 'm001'})
CREATE (u)-[:WATCHED {rating: 9.5, watched_at: datetime('2024-03-10')}]->(m);

MATCH (m:Movie {id: 'm001'}), (g:Genre {name: 'Ficção Científica'})
CREATE (m)-[:BELONGS_TO]->(g);

MATCH (a:Actor {name: 'Matthew McConaughey'}), (m:Movie {id: 'm001'})
CREATE (a)-[:ACTED_IN {role: 'Cooper'}]->(m);

MATCH (d:Director {name: 'Christopher Nolan'}), (m:Movie {id: 'm001'})
CREATE (d)-[:DIRECTED]->(m);
