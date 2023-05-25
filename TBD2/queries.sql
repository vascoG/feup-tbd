--query a
select p.sigla, p.designacao, p.mandatos_total() as "Mandatos"
from Partido p order by value(p) DESC;

--query c
select c.nome, c.partido_mais_votos().sigla as "Partido com mais votos"
from Concelho c order by c.nome;

--query e
select sigla, round(((p.mandatos_total()/mandatos_nacionais)-(p.votos_total()/votos_nacionais))*100,2) as "Diferença entre mandatos e votos (%)"
from Partido p, (select sum(l.mandatos) mandatos_nacionais from Lista l), (select sum(d.participacao.votantes) votos_nacionais from Distrito d) order by "Diferença entre mandatos e votos (%)" DESC;

--query g1 - What were the top 10 lists with more mandates? Order them by mandates
select l.distrito.nome, l.partido.sigla, mandatos
from Lista l
order by value(l) DESC
fetch first 10 rows only;