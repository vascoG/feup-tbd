SET TIMING ON;
--1.x
SELECT xucs.codigo, xucs.designacao, xocorrencias.ano_letivo, xocorrencias.inscritos,xtiposaula.tipo,xtiposaula.turnos FROM xucs 
JOIN xocorrencias ON xucs.codigo=xocorrencias.codigo
JOIN xtiposaula ON xocorrencias.ano_letivo=xtiposaula.ano_letivo AND xocorrencias.periodo= xtiposaula.periodo AND xocorrencias.codigo=xtiposaula.codigo
WHERE curso='275' AND designacao='Bases de Dados';

--1.y

SELECT yucs.codigo, yucs.designacao, yocorrencias.ano_letivo, yocorrencias.inscritos,ytiposaula.tipo,ytiposaula.turnos FROM yucs 
JOIN yocorrencias ON yucs.codigo=yocorrencias.codigo
JOIN ytiposaula ON yocorrencias.ano_letivo=ytiposaula.ano_letivo AND yocorrencias.periodo= ytiposaula.periodo AND yocorrencias.codigo=ytiposaula.codigo
WHERE curso='275' AND designacao='Bases de Dados';


--2.X
SELECT xucs.curso,xocorrencias.ano_letivo,xtiposaula.tipo,xdsd.horas FROM xucs
JOIN xocorrencias ON xucs.codigo=xocorrencias.codigo
JOIN xtiposaula ON xocorrencias.ano_letivo=xtiposaula.ano_letivo AND xocorrencias.periodo= xtiposaula.periodo AND xocorrencias.codigo=xtiposaula.codigo
JOIN xdsd ON xdsd.id=xtiposaula.id
WHERE xucs.curso='233' AND xocorrencias.ano_letivo='2004/2005';

--2.y

SELECT yucs.curso,yocorrencias.ano_letivo,ytiposaula.tipo,ydsd.horas FROM yucs
JOIN yocorrencias ON yucs.codigo=yocorrencias.codigo
JOIN ytiposaula ON yocorrencias.ano_letivo=ytiposaula.ano_letivo AND yocorrencias.periodo= ytiposaula.periodo AND yocorrencias.codigo=ytiposaula.codigo
JOIN ydsd ON ydsd.id=ytiposaula.id
WHERE yucs.curso='233' AND yocorrencias.ano_letivo='2004/2005';

