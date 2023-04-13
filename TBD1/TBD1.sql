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
SELECT u.curso, o.ano_letivo, tipo, SUM(horas) as hours_planned 
FROM xdsd d JOIN xtiposaula s ON d.id=s.id
JOIN xocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN xucs u ON o.codigo=u.codigo
WHERE u.curso=233 AND o.ano_letivo='2004/2005'
GROUP BY u.curso, o.ano_letivo, s.tipo;

--2.y
SELECT u.curso, o.ano_letivo, tipo, SUM(horas) as hours_planned
FROM ydsd d JOIN ytiposaula s ON d.id=s.id
JOIN yocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN yucs u ON o.codigo=u.codigo
WHERE u.curso=233 AND o.ano_letivo='2004/2005'
GROUP BY u.curso, o.ano_letivo, s.tipo;

--2.y
SELECT u.curso, o.ano_letivo, tipo, SUM(horas) as hours_planned 
FROM zdsd d JOIN ztiposaula s ON d.id=s.id
JOIN zocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN zucs u ON o.codigo=u.codigo
WHERE u.curso=233 AND o.ano_letivo='2004/2005'
GROUP BY u.curso, o.ano_letivo, s.tipo;



--5
--a 
CREATE INDEX tiposaula_idx ON ztiposaula (tipo, ano_letivo);

SELECT u.sigla_uc, o.ano_letivo, o.periodo, s.horas_turno
FROM ztiposaula s JOIN zocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN zucs u ON u.codigo = o.codigo
WHERE s.tipo='OT' AND s.ano_letivo LIKE '%2003%';

--b 
DROP INDEX tiposaula_idx;
CREATE BITMAP INDEX tiposaula_idx ON ztiposaula (tipo, ano_letivo);

SELECT u.sigla_uc, o.ano_letivo, o.periodo, s.horas_turno
FROM ztiposaula s JOIN zocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN zucs u ON u.codigo = o.codigo
WHERE s.tipo='OT' AND s.ano_letivo LIKE '%2003%';
--Bitmap indexes work best when the indexed columns have high cardinality, i.e., when the number of distinct values is large compared to the total number of rows in the table

--6.x
SELECT u.curso
FROM xucs u JOIN xocorrencias o ON u.codigo = o.codigo
JOIN xtiposaula s ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
GROUP BY u.curso HAVING COUNT(DISTINCT s.tipo)>4;
--6.y
SELECT u.curso
FROM yucs u JOIN yocorrencias o ON u.codigo = o.codigo
JOIN ytiposaula s ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
GROUP BY u.curso HAVING COUNT(DISTINCT s.tipo)>4;
--6.z
SELECT u.curso
FROM zucs u JOIN zocorrencias o ON u.codigo = o.codigo
JOIN ztiposaula s ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
GROUP BY u.curso HAVING COUNT(DISTINCT s.tipo)>4;
