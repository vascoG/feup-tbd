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

--1.z

SELECT zucs.codigo, zucs.designacao, zocorrencias.ano_letivo, zocorrencias.inscritos,ztiposaula.tipo,ztiposaula.turnos FROM zucs 
JOIN zocorrencias ON zucs.codigo=zocorrencias.codigo
JOIN ztiposaula ON zocorrencias.ano_letivo=ztiposaula.ano_letivo AND zocorrencias.periodo= ztiposaula.periodo AND zocorrencias.codigo=ztiposaula.codigo
WHERE curso='275' AND designacao='Bases de Dados';

--2.x
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

--2.z
SELECT u.curso, o.ano_letivo, tipo, SUM(horas) as hours_planned 
FROM zdsd d JOIN ztiposaula s ON d.id=s.id
JOIN zocorrencias o ON o.codigo=s.codigo AND o.ano_letivo=s.ano_letivo AND o.periodo=s.periodo
JOIN zucs u ON o.codigo=u.codigo
WHERE u.curso=233 AND o.ano_letivo='2004/2005'
GROUP BY u.curso, o.ano_letivo, s.tipo;


--3
--ax
SELECT o.codigo, o.periodo
FROM xocorrencias o 
WHERE o.ano_letivo='2003/2004'
AND (o.codigo, o.periodo) NOT IN 
(SELECT t.codigo, t.periodo FROM xtiposaula t WHERE t.ano_letivo='2003/2004');

--ay
SELECT o.codigo, o.periodo
FROM yocorrencias o 
WHERE o.ano_letivo='2003/2004'
AND (o.codigo, o.periodo) NOT IN 
(SELECT t.codigo, t.periodo FROM xtiposaula t WHERE t.ano_letivo='2003/2004');
--az
SELECT o.codigo, o.periodo
FROM zocorrencias o 
WHERE o.ano_letivo='2003/2004'
AND (o.codigo, o.periodo) NOT IN 
(SELECT t.codigo, t.periodo FROM xtiposaula t WHERE t.ano_letivo='2003/2004');


--bx

SELECT o.codigo
FROM xocorrencias o
FULL OUTER JOIN xtiposaula t ON o.ano_letivo=t.ano_letivo AND o.periodo= t.periodo AND o.codigo=t.codigo
WHERE o.ano_letivo='2003/2004'
AND t.id IS NULL;

--by
SELECT o.codigo
FROM yocorrencias o
FULL OUTER JOIN ytiposaula t ON o.ano_letivo=t.ano_letivo AND o.periodo= t.periodo AND o.codigo=t.codigo
WHERE o.ano_letivo='2003/2004'
AND t.id IS NULL;

--bz
SELECT o.codigo
FROM zocorrencias o
FULL OUTER JOIN ztiposaula t ON o.ano_letivo=t.ano_letivo AND o.periodo= t.periodo AND o.codigo=t.codigo
WHERE o.ano_letivo='2003/2004'
AND t.id IS NULL;


--4x

CREATE OR REPLACE VIEW somax AS
SELECT d.nome, d.nr, ds.fator, t.tipo, SUM(ds.horas) horasT
FROM xdsd ds
JOIN xdocentes d ON d.nr=ds.nr
JOIN xtiposaula t ON t.id=ds.id
WHERE t.ano_letivo='2003/2004'
GROUP BY t.tipo, d.nr,d.nome,ds.fator;

select nr número, nome, tipo, horasT*fator horasxfator, horasT horas FROM somax WHERE (tipo, horasT) IN (
SELECT tipo, max(horasT) maximo FROM somax group by tipo);

--4y
CREATE OR REPLACE VIEW somay AS
SELECT d.nome, d.nr, ds.fator, t.tipo, SUM(ds.horas) horasT
FROM ydsd ds
JOIN ydocentes d ON d.nr=ds.nr
JOIN ytiposaula t ON t.id=ds.id
WHERE t.ano_letivo='2003/2004'
GROUP BY t.tipo, d.nr,d.nome,ds.fator;

select nr número, nome, tipo, horasT*fator horasxfator, horasT horas FROM somay WHERE (tipo, horasT) IN (
SELECT tipo, max(horasT) maximo FROM somay group by tipo);

--4z

CREATE OR REPLACE VIEW somaz AS
SELECT d.nome, d.nr, ds.fator, t.tipo, SUM(ds.horas) horasT
FROM zdsd ds
JOIN zdocentes d ON d.nr=ds.nr
JOIN ztiposaula t ON t.id=ds.id
WHERE t.ano_letivo='2003/2004'
GROUP BY t.tipo, d.nr,d.nome,ds.fator;

select nr número, nome, tipo, horasT*fator horasxfator, horasT horas FROM somaz WHERE (tipo, horasT) IN (
SELECT tipo, max(horasT) maximo FROM somaz group by tipo) ;


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
