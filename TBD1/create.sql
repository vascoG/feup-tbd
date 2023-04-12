--DROP TABLE xdocentes;
--DROP TABLE ydocentes;
--DROP TABLE zdocentes;
--
--DROP TABLE xdsd;
--DROP TABLE ydsd;
--DROP TABLE zdsd;
--
--DROP TABLE xtiposaula;
--DROP TABLE ytiposaula;
--DROP TABLE ztiposaula;
--
--DROP TABLE xocorrencias;
--DROP TABLE yocorrencias;
--DROP TABLE zocorrencias;
--
--DROP TABLE xucs;
--DROP TABLE yucs;
--DROP TABLE zucs;

CREATE TABLE xdocentes AS SELECT * FROM GTD10.xdocentes;
CREATE TABLE ydocentes AS SELECT * FROM GTD10.xdocentes;
CREATE TABLE zdocentes AS SELECT * FROM GTD10.xdocentes;

CREATE TABLE xdsd AS SELECT * FROM GTD10.xdsd;
CREATE TABLE ydsd AS SELECT * FROM GTD10.xdsd;
CREATE TABLE zdsd AS SELECT * FROM GTD10.xdsd;

CREATE TABLE xtiposaula AS SELECT * FROM GTD10.xtiposaula;
CREATE TABLE ytiposaula AS SELECT * FROM GTD10.xtiposaula;
CREATE TABLE ztiposaula AS SELECT * FROM GTD10.xtiposaula;

CREATE TABLE xocorrencias AS SELECT * FROM GTD10.xocorrencias;
CREATE TABLE yocorrencias AS SELECT * FROM GTD10.xocorrencias;
CREATE TABLE zocorrencias AS SELECT * FROM GTD10.xocorrencias;

CREATE TABLE xucs AS SELECT * FROM GTD10.xucs;
CREATE TABLE yucs AS SELECT * FROM GTD10.xucs;
CREATE TABLE zucs AS SELECT * FROM GTD10.xucs;

ALTER TABLE ydocentes ADD CONSTRAINT ydocentes_pk PRIMARY KEY (nr);
ALTER TABLE zdocentes ADD CONSTRAINT zdocentes_pk PRIMARY KEY (nr);

ALTER TABLE yucs ADD CONSTRAINT yucs_pk PRIMARY KEY (codigo);
ALTER TABLE zucs ADD CONSTRAINT zucs_pk PRIMARY KEY (codigo);

ALTER TABLE yocorrencias ADD CONSTRAINT yocorrencias_pk PRIMARY KEY (codigo, ano_letivo, periodo);
ALTER TABLE yocorrencias ADD CONSTRAINT yocorrencias_fk FOREIGN KEY(codigo) REFERENCES yucs(codigo);
ALTER TABLE zocorrencias ADD CONSTRAINT zocorrencias_pk PRIMARY KEY (codigo, ano_letivo, periodo);
ALTER TABLE zocorrencias ADD CONSTRAINT zocorrencias_fk FOREIGN KEY(codigo) REFERENCES zucs(codigo);

ALTER TABLE ytiposaula ADD CONSTRAINT ytiposaula_pk PRIMARY KEY(id);
ALTER TABLE ytiposaula ADD CONSTRAINT ytiposaula_fk FOREIGN KEY (ano_letivo, periodo, codigo) REFERENCES yocorrencias(ano_letivo, periodo, codigo);
ALTER TABLE ztiposaula ADD CONSTRAINT ztiposaula_pk PRIMARY KEY(id);
ALTER TABLE ztiposaula ADD CONSTRAINT ztiposaula_fk FOREIGN KEY (ano_letivo, periodo, codigo) REFERENCES zocorrencias(ano_letivo, periodo, codigo);

ALTER TABLE ydsd ADD CONSTRAINT ydsd_pk PRIMARY KEY (nr,id);
ALTER TABLE ydsd ADD CONSTRAINT ydsd_fk1 FOREIGN KEY (nr) REFERENCES ydocentes(nr);
ALTER TABLE ydsd ADD CONSTRAINT ydsd_fk2 FOREIGN KEY (id) REFERENCES ytiposaula(id);
ALTER TABLE zdsd ADD CONSTRAINT zdsd_pk PRIMARY KEY (nr,id);
ALTER TABLE zdsd ADD CONSTRAINT zdsd_fk1 FOREIGN KEY (nr) REFERENCES zdocentes(nr);
ALTER TABLE zdsd ADD CONSTRAINT zdsd_fk2 FOREIGN KEY (id) REFERENCES ztiposaula(id);