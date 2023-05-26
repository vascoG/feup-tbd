--query b
select d.nome, p.sigla, d.votos_partido(p.sigla) as votos
from Distrito d, Partido p
order by p.sigla,d.nome;
--query d

select d.nome
from Distrito d
where d.integro() = 0;

--f
select p.sigla
from Partido p
where p.sigla
not in (
    select p.sigla
    from Partido p, Distrito d
    where d.mandatos_partido(p.sigla)=0
);

    
    