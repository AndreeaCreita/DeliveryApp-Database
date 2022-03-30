SET SERVEROUTPUT ON;

---creare tabele
---drop table 
drop table oras;
drop table locatie;
drop table angajat;
drop table curier;
drop table clienti;
drop table categorie_magazin;
drop table magazin;
drop table promotie;
drop table oferta_promotie;
drop table categorie_produs;
drop table produs;
drop table stoc;
drop table comanda;
drop table continut_comanda;
drop table feedback_comanda;


--tabele

create table oras (
    oras_id NUMBER(5) not null,
    nume_oras Varchar2(25) not null,
    constraint PK_oras  primary key (oras_id)
);

create table locatie (
    locatie_id              number(5)                   not null,
    strada                  varchar2(60)                not null,
    cod_postal              number(10),
    oras_id                 number(5)                   not null,
    constraint PK_locatie  primary key (locatie_id),
    foreign key(oras_id) references oras(oras_id) on delete cascade
);

create table angajat (
    angajat_id                      number(5)          not null,    
    prenume                     varchar2(35)        not null,
    nume                     varchar2(35)        not null,
    adresa_email                varchar2(35),
    telefon                     number(21)          not null,
    data_angajare                   date            not null,
    salariu                        number(21)          not null,
    constraint PK_angajat  primary key ( angajat_id)
    
       
);

create table curier (                                        --id, rating, ang id, oras id
    curier_id         number(5) not null,
    rating            number(3,2) default 5,
    angajat_id        number(5) not null,
    oras_id           number(5) ,
    constraint PK_curier_id  primary key (curier_id),
    foreign key(angajat_id) references angajat(angajat_id) on delete cascade,
    foreign key(oras_id) references oras(oras_id) on delete cascade
);


create table clienti(                                            --client id, prenume, nume, tel, email, locatie_id
    client_id           number(5)           not null,
    prenume             varchar2(20)        not null,
    nume                varchar2(25)        not null,
    nr_telefon          varchar2(20)        not null,
    adresa_email        varchar2(35),
    locatie_id         number(5),
    constraint PK_client_id  primary key (client_id),
    foreign key(locatie_id) references locatie(locatie_id) on delete cascade

);

create table categorie_magazin (                                   --categorie id, denumire
    categorie_mag_id            number(5)       not null,
    denumire                    varchar2(25)    not null,
    constraint PK_categorie_mag_id  primary key (categorie_mag_id)
);

create table magazin (                                                  --magazin id, nume, categorie_mag_id,locatie_id, rating
    magazin_id          number(5)               not null,
    nume                varchar2(25)            not null,
    categorie_mag_id    number(5)            not null,
    locatie_id          number(5)               not null,
    rating              number(3,2) default 5,
    
    constraint PK_magazin_id  primary key (magazin_id),
    foreign key(locatie_id) references locatie(locatie_id) on delete cascade,
    
    foreign key (categorie_mag_id) references categorie_magazin(categorie_mag_id) on delete cascade
);



 
create table promotie (                                                   --prom id, procent reducere
    promotie_id         number(5)       not null,
    procent_reducere    number(5)       not null,
    constraint promotie_id  primary key (promotie_id)
);

create table oferta_promotie (                                             --prom id, mag id, data inceput, data finalizare
    promotie_id         number(5)           not null references promotie(promotie_id),
    magazin_id          number(5)           not null references magazin(magazin_id),
    data_inceput        date              not null,
    data_finalizare     date              not null,
    constraint data_inceput  primary key (data_inceput)
);



create table categorie_produs (                            --categ id, den, 
    categorie_id        number(5) not null,
    denumire            varchar(25) not null,
    constraint PK_categorie_id  primary key(categorie_id)
);


create table produs (                                 --produs id, nume, pret, categorie_id
    produs_id       number(5)       not null,
    nume            varchar(25)     not null,
    pret            number(5)       ,
    categorie_id    number(5)       ,
    constraint PK_produs_id   primary key(produs_id ),
    foreign key (categorie_id) references categorie_produs(categorie_id) on delete cascade
);


create table stoc (                                    --stoc id, mag id, cantitate
    produs_id       number(5)           not null references produs(produs_id),
    magazin_id      number(5)           not null references magazin(magazin_id),
    cantitate       number(5)
);

create table comanda (                                             --comanda id, comanda data, tip plata, status, locatie id, curier id, mag id, client id
    comanda_id        number(5)                 not null,
    comanda_data      date DEFAULT sysdate      not null,
    tip_plata         varchar(25)               , 
    status            varchar(25)               not null,
    locatie_id       number(5)                  not null,
    curier_id         number(5),
    magazin_id        number(5)                 not null,
    client_id         number(5)                 not null,
    constraint PK_comanda_id    primary key(comanda_id  ),
    foreign key (locatie_id) references locatie(locatie_id) on delete cascade,
    foreign key (curier_id) references curier(curier_id) on delete cascade,
    foreign key (magazin_id) references magazin(magazin_id) on delete cascade,
    foreign key (client_id) references clienti(client_id) on delete cascade
);
create table continut_comanda (                           --comanda_id,produs_id, cantitate
    comanda_id      number(5)           not null references comanda(comanda_id),
    produs_id       number(5)           not null references produs(produs_id),
    cantitate       number(5) not null
);
create table  feedback_comanda(                             --feedback_id, comanda_id, rating_mag, rating_curier
    feedback_id         number(5) not null,
    comanda_id          number(5) not null,
    rating_magazin      number(3,2) default 5,
    rating_curier       number(3,2) default 5,
    constraint PK_feedback_id    primary key(feedback_id  ),
    foreign key (comanda_id) references comanda(comanda_id) on delete cascade
    
);

select * from oras;
select * from locatie;
select * from angajat;
select * from curier;
select * from clienti;
select * from categorie_magazin;
select * from magazin;
select * from promotie;
select * from oferta_promotie;
select * from categorie_produs;
select * from produs;
select * from stoc;
select * from comanda;
select * from continut_comanda;
select * from feedback_comanda;


--inserare in tabele

--oras
insert into oras values(1, 'Bucuresti');
insert into oras values(2, 'Ploiesti');
insert into oras values(3, 'Brasov');
insert into oras values(4, 'Constanta');
insert into oras values(5, 'Galati');
insert into oras values(6, 'Suceava');
insert into oras values(7, 'Cluj');
insert into oras values(8, 'Oradea');

select * from oras;


--locatie
insert into locatie values(1,'Strada George Cosbuc',410001,8); 
insert into locatie values(2,'Strada Avram Iancu', 500001,3); 
insert into locatie values(3,'Strada Olteniei',900001,4);
insert into locatie values(4,'Strada Baraganului',900001,4);
insert into locatie values(5,'Strada Brasov', 400000,7);
insert into locatie values(6,'Strada Ropotului',010001,1); 
insert into locatie values(7,'Strada Izvoare',100078,2); 
insert into locatie values(8,'Strada General Manu',900001,4);

select * from locatie;



--angajat


--id,prenume,nume,mail,tel,data ang, salariu


insert into angajat values(1,'Ana', 'Grigorescu','ana.grigo@yahoo.com',2354365745,to_date('22/03/1999', 'DD/MM/YYYY'),230000);
insert into angajat values(2,'Roxana' ,'Amerinde','roxi.roxi@yahoo.com',123428950,to_date('22/03/1989', 'DD/MM/YYYY'),233444);
insert into angajat values(3,'Christian',' Garry','christian_garry@yahoo.com',5363245367,to_date('22/03/1998', 'DD/MM/YYYY'),456432);
insert into angajat values(4,'Robert',' Pattiosana','rob.pattiosana@gmail.com',3425349786,to_date('22/03/2000', 'DD/MM/YYYY'),342111);
insert into angajat values(5,'Emilia',' Venedi','emilia_venedi@gmail.com',4573645687,to_date('22/03/2011', 'DD/MM/YYYY'),100000);
insert into angajat values(6,'Venti',' Vernindo','Venti_Vent@yahoo.com',6445636667,to_date('22/03/2013', 'DD/MM/YYYY'),200000);
insert into angajat values(7,'Malumi',' Shay','Malumi.Ver@gmail.com',4357564568,to_date('22/03/2019', 'DD/MM/YYYY'),340560);
insert into angajat values(8,'Surimi',' Summer','Summer_surimi@gmail.com',989078896,to_date('22/03/2014', 'DD/MM/YYYY'),340000);
insert into angajat values(9,'Masamoto',' Yukata','Masa_moto@yahoo.com',0086575445,to_date('22/03/2021', 'DD/MM/YYYY'),100000);
select * from angajat;

--curier 
 --id, rating, ang id, oras id


insert into curier values(1,2,3,2);
insert into curier values(2,3.45,3,1);
insert into curier values(3,5,1,4);
insert into curier values(4,6,8,3);
insert into curier values(5,4.4,9,1);
insert into curier values(6,3,5,7);
insert into curier values(7,1,6,5);
insert into curier values(8,4.45,7,1);
insert into curier values(9,4.67,4,6);

select * from curier;



--categorie magazin
  --categorie id, denumire

insert into categorie_magazin values(1,'restaurant');
insert into categorie_magazin values(2,'electrocasnice');
insert into categorie_magazin values(3,'magazin alimente');
insert into categorie_magazin values(4,'macelarie');
insert into categorie_magazin values(5,'piata');
insert into categorie_magazin values(6,'florarie');
insert into categorie_magazin values(7,'pet shop');
select * from categorie_magazin;
--magazin
----magazin id, nume, categorie_mag_id,locatie_id, rating

insert into magazin values(1,'Carrefour', 3, 1,5);                    --mag alimente
insert into magazin values(2,'Altex',2,5,3.6);                         --electro
insert into magazin values(3,'Piata Obor',5,1,4.5);                     --piata
insert into magazin values(4,'Arabella',4,5,3.3);                   --macelarie
insert into magazin values(5,'Nirvana',6,7,4.2);                    --florarie
insert into magazin values(6,'Anavrin',7,8,3.4);                    --pet shop
insert into magazin values(7,'Siren',1,3,5);                        --restaurant
insert into magazin values(8,'Shanon',4, 2, 4.5);                   --macelarie
insert into magazin values(9,'La Nuci',1,7,4);                       --restaurant
insert into magazin values(10,'Chirila',3,2,2.3);                      --mag alim
insert into magazin values(11,'Simp',4,5, 5);                       --macelarie
insert into magazin values(12,'Afrodita', 7,8,3);                   --pet shop
insert into magazin values(13,'La Teo',1,4,4.4);                    --restaurant
insert into magazin values(14,'Chika',2,6,5);                       --electro

select * from magazin;

--prom id, procent reducere
insert into promotie values(1,10);
insert into promotie values(2,20);
insert into promotie values(3,20);
insert into promotie values(4,30);
insert into promotie values(5,40);
insert into promotie values(6,70);
insert into promotie values(7,50);
select * from promotie;
--oferta_promotie
--prom id, mag id, data inceput, data finalizare

insert into oferta_promotie values(1,1,to_date('22/03/2022', 'DD/MM/YYYY'),to_date('22/04/2022', 'DD/MM/YYYY'));
insert into oferta_promotie values(2,2,to_date('12/01/2022', 'DD/MM/YYYY'),to_date('20/03/2022', 'DD/MM/YYYY'));
insert into oferta_promotie values(3,3,to_date('05/07/2022', 'DD/MM/YYYY'),to_date('22/07/2022', 'DD/MM/YYYY'));
insert into oferta_promotie values(4,4,to_date('29/08/2012', 'DD/MM/YYYY'),to_date('05/09/2022', 'DD/MM/YYYY'));
insert into oferta_promotie values(5,5,to_date('13/12/2022', 'DD/MM/YYYY'),to_date('13/10/2022', 'DD/MM/YYYY'));
insert into oferta_promotie values(6,6,to_date('22/09/2012', 'DD/MM/YYYY'),to_date('22/11/2022', 'DD/MM/YYYY'));
insert into oferta_promotie values(7,7,to_date('26/03/2022', 'DD/MM/YYYY'),to_date('22/05/2022', 'DD/MM/YYYY'));


select * from oferta_promotie;
--categorie_produs
--categ id, den
insert into categorie_produs values(1,'electrocasnice');
insert into categorie_produs values(2,'alimente');
insert into categorie_produs values(3,'mezeluri');
insert into categorie_produs values(4, 'lactate');
insert into categorie_produs values(5,'hrana animale');
insert into categorie_produs values(6, 'flori');
insert into categorie_produs values(7, 'carne');
insert into categorie_produs values(8, 'panificatie');
insert into categorie_produs values(9, 'gadget');
insert into categorie_produs values(10, 'laptop');
insert into categorie_produs values(11, 'jucarii animale');
insert into categorie_produs values(12, 'fructe');

select * from categorie_produs;
--produs
--produs id, nume, pret, categorie_id

insert into produs values(1,'trandafir',3, 6);
insert into produs values(2,'lalele',1,6);
insert into produs values(3,'narcisa',2,6);
insert into produs values(4,'ceas health',200,9);
insert into produs values(5,'ananas',6,12);
insert into produs values(6,'sunca',6,3);
insert into produs values(7,'salam',4,3);
insert into produs values(8,'parizer',3,3);
insert into produs values(9,'zgarda',12,12);
insert into produs values(10,'jucarie zgomot',5,12);
insert into produs values(11,'laptop asus',3000,10);
insert into produs values(12,'paine',1,8);
insert into produs values(13,'covrig',2,8);
insert into produs values(14,'pulpe pui',7,7);
insert into produs values(15,'spate porc',7,7);
insert into produs values(16,'pliculete Felix',15,5);
insert into produs values(17,'lapte Mill',7,4);
insert into produs values(18,'Danonino',5,4);
insert into produs values(19,'blender',100,1);
insert into produs values(24,'cereale lapte',10,2);
insert into produs values(20,'clatite cioco',15,2);
insert into produs values(21,'piure cu pui',25,2);
insert into produs values(22,'somon cu orez',30,2);
insert into produs values(23,'creveti',40,2);

select * from produs;

--stoc
 --stoc id, mag id, cantitate
 insert into stoc values(1,13, 2);
 insert into stoc values(2,12, 4);
 insert into stoc values(3,11,10);
 insert into stoc values(4,1,4);
 insert into stoc values(5,2,20);
 insert into stoc values(6,3,4);
 insert into stoc values(7,4,6);
 insert into stoc values(8,9,1);
 insert into stoc values(9,8,1);
 insert into stoc values(10,7,2);
 insert into stoc values(11,6,3);
 insert into stoc values(12,5,40);
 insert into stoc values(13,13,60);
 insert into stoc values(14,12,3);
 insert into stoc values(15,1,3);
 insert into stoc values(16,7,7);
 insert into stoc values(17,7,8);
 insert into stoc values(18,2,4);
 insert into stoc values(19,3,3);
 
 select * from stoc;
 
 
 
--clienti

--client id, prenume, nume, tel, email, locatie_id

insert into clienti values(1,'Alexandru','Larel','0745654687','alex.la@gmail.com',1);
insert into clienti values(2,'Ionel','Serban','0445676545','ionel.serban@yahoo.com',2);
insert into clienti values(3,'Petru','Meabefir','0453453232','meamea@yahoo.com',3);
insert into clienti values(4,'Gigel','Constantinov','0987654356','gigel_gigel@yahoo.com',4);
insert into clienti values(5,'Alexandra','Paul','0987654657','alex_alex@yahoo.com',5);
insert into clienti values(6,'Carmen','Sasha','0876543455','carmen_sasha@yahoo.com',6);
insert into clienti values(7,'Iolanda','Alexandrescu','0687534665','iolanda_io@yahoo.com',7);
insert into clienti values(8,'Simbad','Mufasa','7584658465','simba_ad.gmail.com',8);
insert into clienti values(9,'Yumina','Shitori','4853456198','yumina_shitori@yahoo.com',1);
insert into clienti values(10,'Ilias','Ionie','2342345467','ilias.ionei@gmail.com',1);
insert into clienti values(12,'Chim','Chimchim','0987656765','chimchimie@gmail.com',2);
insert into clienti values(11,'Mihai','Gabriel','0987634565','mihaita@gmail.com',1);
select * from clienti;
 --comanda
 --comanda id, comanda data, tip plata, status, locatie id, curier id, mag id, client id
 
insert into comanda values(1,to_date('22/03/2022', 'DD/MM/YYYY'),'card','finalizat',1,1,1,5);  --restaurant               --
insert into comanda values(2,to_date('01/05/2022', 'DD/MM/YYYY'),'card','finalizat',2,1,8,2); --macelarie
insert into comanda values(3,to_date('30/03/2022', 'DD/MM/YYYY'),'cash','finalizat',3,4,7,3); --restaurent
insert into comanda values(4,to_date('13/12/2022', 'DD/MM/YYYY'),'card','finalizat',2,1,10,3); --mag alim
insert into comanda values(5,to_date('02/09/2022', 'DD/MM/YYYY'),'cash','in progres',4,3,13,4); --rest
insert into comanda values(6,to_date('12/11/2022', 'DD/MM/YYYY'),'card','finalizat',7,3,6,4);   --pet shop
insert into comanda values(7,to_date('22/11/2022', 'DD/MM/YYYY'),'card','in progres',8,3,6,4); --pet shop
insert into comanda values(8,to_date('04/09/2022', 'DD/MM/YYYY'),'card','finalizat',5,6,4,5); --macelarie
insert into comanda values(9,to_date('06/07/2022', 'DD/MM/YYYY'),'card','finalizat',1,null,3,10); --piata
insert into comanda values(10,to_date('29/04/2022', 'DD/MM/YYYY'),'cash','finalizat',3,3,7,3); --rest
insert into comanda values(11,to_date('10/08/2022', 'DD/MM/YYYY'),'cash','finalizat',4,3,13,4); --rest
insert into comanda values(12,to_date('10/10/2022', 'DD/MM/YYYY'),'cash','in progres',7,1,5,7);  --florarie
insert into comanda values(13,to_date('02/02/2022', 'DD/MM/YYYY'),'card','finalizat',6,8,14,6);  --electro
 
 select * from comanda;
 
 
 --continut_comanda
 --comanda_id,produs_id, cantitate
insert into continut_comanda values(1,20,2);
insert into continut_comanda values(2,14,10);
insert into continut_comanda values(3,21,3);
insert into continut_comanda values(4,17,12);
insert into continut_comanda values(5,23,2);
insert into continut_comanda values(6,16,10);
insert into continut_comanda values(7,9,3);
insert into continut_comanda values(8,15,3);
insert into continut_comanda values(9,5,30);
insert into continut_comanda values(10,23,4);
insert into continut_comanda values(11,22,1);
insert into continut_comanda values(12,2,50);
insert into continut_comanda values(13,19,4);
 
 select * from continut_comanda;
 rollback;
 --feedback
  --feedback_id, comanda_id, rating_mag, rating_curier
  

insert into feedback_comanda values(1,13,3,4);
insert into feedback_comanda values(2,12,4,5);
insert into feedback_comanda values(3,11,5,5);
insert into feedback_comanda values(4,10,3,4);
insert into feedback_comanda values(5,9,2,2);
insert into feedback_comanda values(6,8,5,5);
insert into feedback_comanda values(7,7,3,3);
insert into feedback_comanda values(8,6,2,3);
insert into feedback_comanda values(9,5,4,4);
insert into feedback_comanda values(10,4,3,4);
insert into feedback_comanda values(11,3,4,2);
insert into feedback_comanda values(12,2,5,1);
insert into feedback_comanda values(13,1,4,1);

select * from feedback_comanda;






--Ex 10. -> trigger LMD la nivel de comanda
--10.Creati un trigger de tip LMD a nivel de comanda care sa nu permita inserarea
--mai multor promotii decat 10.

select * from promotie;
create or replace trigger prom_trigger
before insert on promotie
declare 
v_nr    int;
begin
    select count(promotie_id) into v_nr from promotie;
    if v_nr > 12 then
        RAISE_APPLICATION_ERROR(-20001,'Limita a fost depasita!');
    end if;
end;

--declansare
begin
    for i in 12..13 loop
        insert into promotie values (i,30);
    end loop;
    delete from promotie where promotie_id like 'abc%';
end;
--stergere trigger
----
DROP TRIGGER prom_trigger;

select * from promotie;


------------------------------------------------------------------------------
--11.-> Trigger LMD pe linie

--11.Creati un trigger LMD pe tabelul de stoc care sa afiseze cate produse sunt disponibile pentru fiecare magazin

--creaza tabel pentru afisare cantitate disponibila
create table stoc_disponibil (
    magazin_id           number(5) not null,
    cant_disponibila     number(5),
    constraint PK_magazin_id2    primary key(magazin_id)
);
drop table stoc_disponibil;
--trigger

create or replace trigger trigger_stoc_disponibil before
    delete or insert or update on stoc for each row

begin

--delete
    if deleting then
        update stoc_disponibil
        set cant_disponibila = cant_disponibila - :old.cantitate
        where magazin_id = :new.magazin_id;
    end if;
    
    
--insert

    if inserting then
        update stoc_disponibil
        set cant_disponibila = cant_disponibila + :new.cantitate
        where magazin_id = :new.magazin_id;
        
        if SQL%notfound then
        INSERT INTO stoc_disponibil (
                magazin_id,
                cant_disponibila
            ) VALUES (
                :new.magazin_id,
                :new.cantitate
            );
        end if;
    end if;
    
--update

    if updating then
        update stoc_disponibil
        set cant_disponibila = cant_disponibila -:old.cantitate
        where magazin_id = :new.magazin_id;
        end if;
        
end;

        select * from stoc_disponibil;


         select * from stoc;
         insert into stoc values(5,13, 2);
         insert into stoc values (19, 3, 33);


        select 
        m.nume,
        s.cant_disponibila
        from stoc_disponibil s
        join magazin m on (s.magazin_id = m.magazin_id)
        order by 2 desc;
        
        
rollback;  
----------------------------------------------------------------------------------------------------------
--Ex 12 -> trigger LDD
---Fie un trigger care sa nu permita efectuarea de comenzi ldd decat pentru userul "andre"
CREATE OR REPLACE TRIGGER trig_LDD_owner
    BEFORE CREATE OR DROP OR ALTER ON SCHEMA
    BEGIN 
        IF USER != UPPER('andre') THEN 
        RAISE_APPLICATION_ERROR(-20025,'Nu ai drepturi pentru comenzi LDD.'); 
    END IF; 
END; 
/ 


CREATE TABLE test1(
    id INT PRIMARY KEY,
    nume VARCHAR(15) NOT NULL
);
drop table test1;
DROP TRIGGER trig_LDD_owner;


----------------------------------------
----------------------------------------

--Ex7. Procedura care afiseaza toate feedbackurile date de un client pentru comenzi
create or replace procedure proc_feedback(v_client clienti.nume%type)
    is
        cursor c is
            select f.rating_magazin , c.comanda_id
            from comanda c, feedback_comanda f, clienti cl
            where f.comanda_id= c.comanda_id and c.client_id = cl.client_id and cl.nume = v_client;
            
        v_nr number := 0;
        
    begin
        for i in c loop 
            v_nr := v_nr+1;
            DBMS_OUTPUT.PUT_LINE('Feedback-ul numarul '||v_nr||' la comanda '||i.comanda_id||' are rating '||i.rating_magazin);
        end loop;
                --close c;
end proc_feedback;
                

begin 
    proc_feedback('Paul');
end;

 select * from clienti;
    select * from comanda;
    select * from feedback_comanda;
    
    
---------------------------------------------------------------------------------------------------------
--Ex8. Cate produse are un magazin dat ca parametru in stoc? 
    
CREATE OR REPLACE FUNCTION prod_mag(nrc NUMBER) RETURN NUMBER
IS
    nr_c_rez NUMBER;
    TYPE tbl_idx IS TABLE OF magazin%ROWTYPE INDEX BY PLS_INTEGER;
    aux tbl_idx;
    NEGATIVE_NUMBER EXCEPTION;
    NO_DATA_FOUND1 EXCEPTION;
    NO_DATA_FOUND2 EXCEPTION;
BEGIN
    IF nrc < 0 THEN       --pt magazin
        RAISE NEGATIVE_NUMBER;
    END IF;
    
    SELECT * BULK COLLECT INTO aux FROM magazin WHERE magazin_id = nrc;
    IF SQL%NOTFOUND THEN
        RAISE NO_DATA_FOUND1;
    END IF;
    
    select count(p.produs_id) into nr_c_rez               --pt produse
    from produs p join stoc s on (s.produs_id = p.produs_id)
    join magazin m on (s.magazin_id = m.magazin_id)
    where m.magazin_id = nrc;
    
    IF nr_c_rez = 0 THEN
        RAISE NO_DATA_FOUND2;
    ELSE
        RETURN nr_c_rez;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND1 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista magazin cu numarul ' || nrc);
        RETURN -1;
    WHEN NO_DATA_FOUND2 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista produse in stoc pentru magazinul cu numarul ' || nrc);
        RETURN -1;
    WHEN NEGATIVE_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE('Nu sunt permise valori negative!');
        RETURN -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('Codul erorii: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE ('Mesajul erorii: ' || SQLERRM);
        RETURN -1;
    
END;
/


DECLARE
    aux NUMBER;
    
BEGIN
    aux := prod_mag(-3);
    IF aux > -1 THEN
        DBMS_OUTPUT.PUT_LINE('Exista ' || aux || ' produse pentru magazinul cu numarul 7 ');
    END IF;
END;
/  
select * from stoc;

----------------------------------------------------------------------------------------------------------------------
--Ex9.Pentru codul unei promotii date, afisati numele magazinului, numele produsului, cantitatea 

create or replace procedure promo1(cod_promotie promotie.promotie_id%type) is
cprocent promotie.procent_reducere%type;
    cursor c1 is
        select m.nume ma, p.nume pr, cantitate ca, promotie_id pr2
        from produs p join stoc s on (p.produs_id =s.produs_id)
                      join magazin m on(s.magazin_id = m.magazin_id)
                      join oferta_promotie o on(m.magazin_id=o.magazin_id)
                      where promotie_id = cod_promotie;
        
     begin
        select procent_reducere
        into cprocent
        from promotie p
        where promotie_id = cod_promotie;
        
        DBMS_OUTPUT.PUT_LINE('Reducerea in procent de ' || cprocent ||' a fost aplicata: ');
        DBMS_OUTPUT.NEW_LINE();
     
        FOR i in c1 LOOP
            DBMS_OUTPUT.PUT_LINE('In magazinul ' || i.ma || ' produsului ' || i.pr || ' aflat in cantitate de ' || i.ca);
        END LOOP;
      
        DBMS_OUTPUT.NEW_LINE();
    EXCEPTION
        when NO_DATA_FOUND then
           RAISE_APPLICATION_ERROR(-20000, 'Reducerea nu exista.');
        when TOO_MANY_ROWS then
           RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe reduceri cu acelasi cod');
        when others then
           RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
           
end promo1;


select * from promotie;
BEGIN
  promo1(8);
END;

--------------------------------------------------------------------------


--6.Afisati comenzile ce au fost efectuate in anul x  ce este dat ca parametru si comenzile paltite cu cardul

--create or replace package pkg1 is
--type tablou_indexat is table of oferta_promotie%rowtype index by binary_integer;
--end;

create or replace procedure pro(
    an in varchar2
    )
    
    as
    type tablou_indexat is table of oferta_promotie%rowtype index by pls_integer;
    detalii_promotie tablou_indexat;
    
    type tablou_imbricat is table of comanda%rowtype;
    detalii_comanda tablou_imbricat := tablou_imbricat();
    nr number(5);
    nr2 number(5);
    v_localizare NUMBER(1):=1;
    
    begin
    
        v_localizare:=1;
        select null into nr
        from oferta_promotie
        where to_char(data_inceput, 'YYYY') <= an and rownum =1;
        DBMS_OUTPUT.PUT_LINE(nr);
        
        SELECT * BULK COLLECT INTO detalii_promotie 
        FROM   oferta_promotie
        WHERE  TO_CHAR(data_inceput, 'YYYY') <= an;
    
        v_localizare :=2;
        select null into nr2
        from comanda
        where tip_plata = 'card' and rownum =1;
        DBMS_OUTPUT.PUT_LINE(nr2);

        SELECT * BULK COLLECT INTO detalii_comanda 
        FROM   comanda
        WHERE  tip_plata = 'card';
    
    
    DBMS_OUTPUT.PUT_LINE('promotie: ');    
    FOR i in detalii_promotie.first..detalii_promotie.last LOOP
            DBMS_OUTPUT.PUT_LINE( 'Promotia '|| detalii_promotie(i).promotie_id||' s-a desfasurat in anul dat');
        END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('comanda: ');    
    FOR i in detalii_comanda.first..detalii_comanda.last LOOP
            DBMS_OUTPUT.PUT_LINE( 'comanda nr. '|| detalii_comanda(i).comanda_id||' a fost platita cu cardul');
        END LOOP;
        
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       RAISE_APPLICATION_ERROR(-20000, 'Nu exista comenzi');
--    WHEN OTHERS THEN
--       RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
when TOO_MANY_ROWS then
           RAISE_APPLICATION_ERROR(-20001, 'comanda select '||v_localizare || ' nu returneaza nimic ' || ' Exista mai multe reduceri cu acelasi cod');
  END pro;
/
        
select * from oferta_promotie;

begin 
pro(2020);
end;
-----------------------------------------------------------------------------------------------------------------

--13
create or replace package proiect_cag as
    procedure pro(an in varchar2);
    procedure proc_feedback(v_client clienti.nume%type);
    function prod_mag(nrc NUMBER) RETURN NUMBER;
    procedure promo(cod_promotie promotie.promotie_id%type);
end proiect_cag;
/

create or replace package body proiect_cag as

--6.Afisati comenzile ce au fost efectuate in anul x  ce este dat ca parametru si comenzile paltite cu cardul

 procedure pro(
    an in varchar2
    )
    
    as
    type tablou_indexat is table of oferta_promotie%rowtype index by pls_integer;
    detalii_promotie tablou_indexat;
    
    type tablou_imbricat is table of comanda%rowtype;
    detalii_comanda tablou_imbricat := tablou_imbricat();
    nr number(5);
    nr2 number(5);
    v_localizare NUMBER(1):=1;
    
    begin
    
        v_localizare:=1;
        select null into nr
        from oferta_promotie
        where to_char(data_inceput, 'YYYY') <= an and rownum =1;
        DBMS_OUTPUT.PUT_LINE(nr);
        
        SELECT * BULK COLLECT INTO detalii_promotie 
        FROM   oferta_promotie
        WHERE  TO_CHAR(data_inceput, 'YYYY') <= an;
    
        v_localizare :=2;
        select null into nr2
        from comanda
        where tip_plata = 'card' and rownum =1;
        DBMS_OUTPUT.PUT_LINE(nr2);

        SELECT * BULK COLLECT INTO detalii_comanda 
        FROM   comanda
        WHERE  tip_plata = 'card';
    
    
    DBMS_OUTPUT.PUT_LINE('promotie: ');    
    FOR i in detalii_promotie.first..detalii_promotie.last LOOP
            DBMS_OUTPUT.PUT_LINE( 'Promotia '|| detalii_promotie(i).promotie_id||' s-a desfasurat in anul dat');
        END LOOP;
    
    DBMS_OUTPUT.PUT_LINE('comanda: ');    
    FOR i in detalii_comanda.first..detalii_comanda.last LOOP
            DBMS_OUTPUT.PUT_LINE( 'comanda nr. '|| detalii_comanda(i).comanda_id||' a fost platita cu cardul');
        END LOOP;
        
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
       RAISE_APPLICATION_ERROR(-20000, 'Nu exista comenzi');

    when TOO_MANY_ROWS then
           RAISE_APPLICATION_ERROR(-20001, 'comanda select '||v_localizare || ' nu returneaza nimic ' || ' Exista mai multe reduceri cu acelasi cod');
  END pro;


--Ex7. Procedura care afiseaza toate feedbackurile date de un client pentru comenzi
procedure proc_feedback(v_client clienti.nume%type)
    is
        cursor c is
            select f.rating_magazin , c.comanda_id
            from comanda c, feedback_comanda f, clienti cl
            where f.comanda_id= c.comanda_id and c.client_id = cl.client_id and cl.nume = v_client;
            
        v_nr number := 0;
        
    begin
        for i in c loop 
            v_nr := v_nr+1;
            DBMS_OUTPUT.PUT_LINE('Feedback-ul numarul '||v_nr||' la comanda '||i.comanda_id||' are rating '||i.rating_magazin);
        end loop;
                --close c;
end proc_feedback;

--Ex8. Cate produse are un magazin dat ca parametru in stoc? 
    
FUNCTION prod_mag(nrc NUMBER) RETURN NUMBER
IS
    nr_c_rez NUMBER;
    TYPE tbl_idx IS TABLE OF magazin%ROWTYPE INDEX BY PLS_INTEGER;
    aux tbl_idx;
    NEGATIVE_NUMBER EXCEPTION;
    NO_DATA_FOUND1 EXCEPTION;
    NO_DATA_FOUND2 EXCEPTION;
BEGIN
    IF nrc < 0 THEN
        RAISE NEGATIVE_NUMBER;
    END IF;
    
    SELECT * BULK COLLECT INTO aux FROM magazin WHERE magazin_id = nrc;
    IF SQL%NOTFOUND THEN
        RAISE NO_DATA_FOUND1;
    END IF;
    
    select count(p.produs_id) into nr_c_rez
    from produs p join stoc s on (s.produs_id = p.produs_id)
    join magazin m on (s.magazin_id = m.magazin_id)
    where m.magazin_id = nrc;
    
    IF nr_c_rez = 0 THEN
        RAISE NO_DATA_FOUND2;
    ELSE
        RETURN nr_c_rez;
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND1 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista magazin cu numarul ' || nrc);
        RETURN -1;
    WHEN NO_DATA_FOUND2 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista produse in stoc pentru magazinul cu numarul ' || nrc);
        RETURN -1;
    WHEN NEGATIVE_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE('Nu sunt permise valori negative!');
        RETURN -1;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('Codul erorii: ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE ('Mesajul erorii: ' || SQLERRM);
        RETURN -1;
    
END;


--Ex9.Pentru codul unei promotii date, afisati numele magazinului, numele produsului, cantitatea si mai vedem

 procedure promo(cod_promotie promotie.promotie_id%type) is
cprocent promotie.procent_reducere%type;
    cursor c1 is
        select m.nume ma, p.nume pr, cantitate ca, promotie_id pr2
        from produs p join stoc s on (p.produs_id =s.produs_id)
                      join magazin m on(s.magazin_id = m.magazin_id)
                      join oferta_promotie o on(m.magazin_id=o.magazin_id)
                      where promotie_id = cod_promotie;
        
     begin
        select procent_reducere
        into cprocent
        from promotie p
        where promotie_id = cod_promotie;
        
        DBMS_OUTPUT.PUT_LINE('Reducerea in procent de ' || cprocent ||' a fost aplicat: ');
        DBMS_OUTPUT.NEW_LINE();
     
        FOR i in c1 LOOP
            DBMS_OUTPUT.PUT_LINE('In magazinul ' || i.ma || ' produsului ' || i.pr || ' aflat in cantitate de ' || i.ca);
        END LOOP;
      
        DBMS_OUTPUT.NEW_LINE();
    EXCEPTION
        when NO_DATA_FOUND then
           RAISE_APPLICATION_ERROR(-20000, 'Reducerea nu exista.');
        when TOO_MANY_ROWS then
           RAISE_APPLICATION_ERROR(-20001, 'Exista mai multe reduceri cu acelasi cod');
        when others then
           RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
           
end promo;

end proiect_cag;
--------------------------------------

--ex6
execute proiect_cag.pro(2020);
--ex7
execute proiect_cag.proc_feedback('Paul');

--ex9
execute proiect_cag.promo(4);

--ex8
DECLARE
    aux NUMBER;
    
BEGIN
    aux := proiect_cag.prod_mag(7);
    IF aux > -1 THEN
        DBMS_OUTPUT.PUT_LINE('Exista ' || aux || ' produse pentru magazinul cu numarul 7 ');
    END IF;
END;
/  

