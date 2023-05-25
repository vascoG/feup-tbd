--create types and tables
create or replace type Participacao_t as object(
    inscritos number(10),
    votantes number(10),
    abstencoes number(10),
    brancos number (10),
    nulos number (10));
/

create or replace type Area_t as object(
    codigo number(6),
    nome varchar(250),
    not instantiable member function votos_partido (sigla varchar2) return number,
    not instantiable member function votos_total return number)not instantiable not final;
/

create or replace type Distrito_t under Area_t(
    regiao varchar(1),
    participacao Participacao_t,
    overriding member function votos_partido (sigla varchar2) return number,
    overriding member function votos_total return number);
/
    
create or replace type Concelho_t under Area_t(
    distrito ref Distrito_t,
    overriding member function votos_partido (sigla varchar2) return number,
    overriding member function votos_total return number);
/

create or replace type Concelho_tab_t as table of ref Concelho_t;
/
    
create or replace type Freguesia_t under Area_t(
    concelho ref Concelho_t,
    overriding member function votos_partido (sigla varchar2) return number,
    overriding member function votos_total return number);
/

create or replace type Freguesia_tab_t as table of ref Freguesia_t;
/

create or replace type Partido_t as object(
    sigla varchar2(10),
    designacao varchar2(100));
/
    
create or replace type Lista_t as object(
    mandatos number(3),
    distrito ref Distrito_t,
    partido ref Partido_t);
/

create or replace type Lista_tab_t as table of ref Lista_t;
/

create or replace type Votacao_t as object(
    votos number(10),
    partido ref Partido_t,
    freguesia ref Freguesia_t);
/

create or replace type Votacao_tab_t as table of ref Votacao_t;
/

alter type Distrito_t add attribute (listas Lista_tab_t, concelhos Concelho_tab_t) cascade;
/

alter type Concelho_t add attribute (freguesias Freguesia_tab_t) cascade;
/

alter type Freguesia_t add attribute (votacoes Votacao_tab_t) cascade;
/

alter type Partido_t add attribute (listas Lista_tab_t, votacoes Votacao_tab_t) cascade;
/

create table Distrito of Distrito_t
    nested table listas store as listas_distrito_tab
    nested table concelhos store as concelhos_tab;
/

create table Concelho of Concelho_t
    nested table freguesia store as freguesia_tab;
/

create table Freguesia of Freguesia_t
    nested table votacoes store as votacoes_freguesia_tab;
/

create table Partido of Partido_t
    nested table listas store as listas_partido_tab
    nested table votacoes store as votacoes_partido_tab;
/

create table Lista of Lista_t;
/

create table Votacao of Votacao_t;
/

    