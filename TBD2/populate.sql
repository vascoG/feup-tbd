insert into Distrito(codigo, nome, regiao, participacao)
    select d.codigo, d.nome, d.regiao, Participacao_t(p.inscritos, p.votantes, p.abstencoes, p.brancos, p.nulos)
    from GTD11.distritos d join GTD11.participacoes p on d.codigo = p.distrito;



insert into Partido(sigla, designacao)
    select p.sigla, p.designacao
    from GTD11.partidos p;