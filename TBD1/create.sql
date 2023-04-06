DROP TABLE xdocentes;
DROP TABLE ydocentes;
DROP TABLE zdocentes;

DROP TABLE xdsd;
DROP TABLE ydsd;
DROP TABLE zdsd;

DROP TABLE xtiposala;
DROP TABLE ytiposala;
DROP TABLE ztiposala;

DROP TABLE xocorrencias;
DROP TABLE yocorrencias;
DROP TABLE zocorrencias;

DROP TABLE xucs;
DROP TABLE yucs;
DROP TABLE zucs;

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