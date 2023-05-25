--query a
select p.sigla, p.designacao, p.mandatos_total() as mandatos
from Partido p;