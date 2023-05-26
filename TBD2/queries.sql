--query a
select p.sigla, p.designacao, p.mandatos_total() as Mandatos
from Partido p order by Mandatos DESC;

--query b
select d.nome, p.sigla, d.votos_partido(p.sigla) as votos
from Distrito d, Partido p
order by p.sigla,d.nome;

--query c
select c.nome, c.partido_mais_votos().sigla as "Partido com mais votos"
from Concelho c order by c.nome;

--query d

select d.nome
from Distrito d
where d.integro() = 0;

--query e
select sigla, round(((p.mandatos_total()/mandatos_nacionais)-(p.votos_total()/votos_nacionais))*100,2) as "Diferen�a entre mandatos e votos (%)"
from Partido p, (select sum(l.mandatos) mandatos_nacionais from Lista l), (select sum(d.participacao.votantes) votos_nacionais from Distrito d) order by "Diferen�a entre mandatos e votos (%)" DESC;

--query f
select p.sigla
from Partido p
where p.sigla
not in (
    select p.sigla
    from Partido p, Distrito d
    where d.mandatos_partido(p.sigla)=0
);

--query g1 - What were the top 10 lists with more mandates?
select l.distrito.nome, l.partido.sigla, mandatos
from Lista l
order by value(l) DESC
fetch first 10 rows only;

--query g2 - Indicate the winning party on each district.
select d.nome, d.partido_mais_votos().sigla as "Partido com mais votos"
from Distrito d order by d.nome;    