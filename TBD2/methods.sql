alter type Area_t add member function partido_mais_votos return ref Partido_t cascade;

create or replace type body Area_t as
    
    member function partido_mais_votos return ref Partido_t is
    r ref partido_t;
    begin
        select ref(p1) into r from partido p1 where
            not exists (select * from partido p2 
                where (p1.sigla != p2.sigla and self.votos_partido(p1.sigla) < self.votos_partido(p2.sigla)));
        return r;
    end partido_mais_votos;
    
end;
/

alter type Distrito_t add member function integro return number cascade;

create or replace type body Distrito_t as 

    overriding member function votos_partido(sigla varchar2) return number is
    r number;
    begin
        select nvl(sum(value(v).votos),0) into r
        from table(self.concelhos) c, table(value(c).freguesias) f, table(value(f).votacoes) v
        where value(v).partido.sigla = sigla;
        return r;
    end votos_partido;

    overriding member function votos_total return number is
    r number;
    begin
        select sum(value(v).votos) into r
        from table(self.concelhos) c, table(value(c).freguesias) f, table(value(f).votacoes) v;
        return r;
    end votos_total;
    
    member function integro return number is
    r number;
    begin
        if (self.votos_total() + self.participacao.brancos + self.participacao.nulos + self.participacao.abstencoes) = self.participacao.inscritos then
            r:=1;
        else
            r:=0;
        end if;
        return r;
    end integro;
    
end;
/

create or replace type body Concelho_t as 
    
    overriding member function votos_partido(sigla varchar2) return number is
    r number;
    begin
        select nvl(sum(value(v).votos),0) into r
        from table(self.freguesias) f, table(value(f).votacoes) v
        where value(v).partido.sigla = sigla;
        return r;
    end votos_partido;
    
    overriding member function votos_total return number is
    r number;
    begin
        select sum(value(v).votos) into r
        from table(self.freguesias) f, table(value(f).votacoes) v;
        return r;
    end votos_total;
    
end;
/

create or replace type body Freguesia_t as 
    
    overriding member function votos_partido(sigla varchar2) return number is
    r number;
    begin
        select nvl(sum(value(v).votos),0) into r
        from table(self.votacoes) v
        where value(v).partido.sigla = sigla;
        return r;
    end votos_partido;
    
    overriding member function votos_total return number is
    r number;
    begin
        select sum(value(v).votos) into r
        from table(self.votacoes) v;
        return r;
    end votos_total;
    
end;
/

alter type Partido_t add map member function mandatos_total return number cascade;
alter type Partido_t add member function votos_total return number cascade;

create or replace type body Partido_t as 

    map member function mandatos_total return number is
    r number;
    begin
        select nvl(sum(value(l).mandatos),0) into r from table(self.listas) l;
        return r;
    end mandatos_total;
    
    member function votos_total return number is
    r number;
    begin
        select nvl(sum(value(v).votos),0) into r from table(self.votacoes) v;
        return r;
    end votos_total;
end;