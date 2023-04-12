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



--5
--a create b tree index TODO
SELECT u.sigla_uc, o.ano_letivo, o.periodo, s.horas_turno
FROM ztiposaula s JOIN zocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN zucs u ON u.codigo = o.codigo
WHERE s.tipo='OT' AND s.ano_letivo LIKE '%2003%';
--b drop b tree index and create bitmap index TODO
SELECT u.sigla_uc, o.ano_letivo, o.periodo, s.horas_turno
FROM ztiposaula s JOIN zocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN zucs u ON u.codigo = o.codigo
WHERE s.tipo='OT' AND s.ano_letivo LIKE '%2003%';


--6.x
SELECT u.curso
FROM xucs u JOIN xocorrencias o ON u.codigo = o.codigo
JOIN xtiposaula s ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
WHERE s.tipo != 'T' OR s.tipo != 'P' OR s.tipo != 'L' OR s.tipo != 'TP' OR s.tipo != 'OT'
GROUP BY u.curso HAVING COUNT(DISTINCT s.tipo)>4;
--6.y
SELECT u.curso
FROM yucs u JOIN yocorrencias o ON u.codigo = o.codigo
JOIN ytiposaula s ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
WHERE s.tipo != 'T' OR s.tipo != 'P' OR s.tipo != 'L' OR s.tipo != 'TP' OR s.tipo != 'OT'
GROUP BY u.curso HAVING COUNT(DISTINCT s.tipo)>4;
--6.z
SELECT u.curso
FROM zucs u JOIN zocorrencias o ON u.codigo = o.codigo
JOIN ztiposaula s ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
WHERE s.tipo != 'T' OR s.tipo != 'P' OR s.tipo != 'L' OR s.tipo != 'TP' OR s.tipo != 'OT'
GROUP BY u.curso HAVING COUNT(DISTINCT s.tipo)>4;
