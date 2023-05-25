insert into Distrito(codigo, nome, regiao, participacao)
    select d.codigo, d.nome, d.regiao, Participacao_t(p.inscritos, p.votantes, p.abstencoes, p.brancos, p.nulos)
    from GTD11.distritos d join GTD11.participacoes p on d.codigo = p.distrito;


insert into Partido(sigla, designacao)
    select p.sigla, p.designacao
    from GTD11.partidos p;
    
    
insert into Lista(distrito, partido, mandatos)
    select ref(d), ref(p), l.mandatos
    from Distrito d
    join GTD11.listas l on d.codigo = l.distrito
    join Partido p on p.sigla = l.partido;
    
insert into Concelho(nome, codigo, distrito)
    select c.nome, c.codigo, ref(d)
    from GTD11.concelhos c
    join Distrito d on d.codigo = c.distrito; 

insert into Freguesia(codigo, nome, concelho)
    select f.codigo, f.nome, ref(c)
    from GTD11.freguesias f
    join Concelho c on c.codigo=f.concelho;
    
insert into Votacao(freguesia, partido, votos)
    select ref(f), ref(p), v.votos
    from Freguesia f
    join GTD11.votacoes v on v.freguesia = f.codigo
    join Partido p on v.partido = p.sigla;
    
    
update Distrito d
    set d.listas = cast(multiset(select ref(l) from Lista l where l.distrito.codigo = d.codigo) as Lista_tab_t),
    d.concelhos = cast(multiset(select ref(c) from Concelho c where c.distrito.codigo = d.codigo) as Concelho_tab_t);
    
update Partido p
     set p.listas = cast(multiset(select ref(l) from Lista l where l.partido.sigla = p.sigla) as Lista_tab_t),
     p.votacoes = cast(multiset(select ref(v) from Votacao v where v.partido.sigla = p.sigla) as Votacao_tab_t);
     
update Concelho c
     set c.freguesias = cast(multiset(select ref(f) from Freguesia f where f.concelho.codigo = c.codigo) as Freguesia_tab_t);

update Freguesia f
     set f.votacoes = cast(multiset(select ref(v) from Votacao v where v.freguesia.codigo = f.codigo) as Votacao_tab_t);