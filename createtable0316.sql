drop table freshdata;
drop table pddatares;
drop table pddatav14;
drop table pddatav14k;
drop table togetherpd;
drop table pddatagreen45;
drop table pddatagreen45v14;
drop table pddatak;
drop table streetdatares;
drop table streetdatav14;
drop table streetdatav14k;
drop table togetherstreet;
drop table streetdatagreen45;
drop table streetdatagreen45v14;
drop table streetdatak;

.mode csv
.import 1freshdata.csv freshdata

create table pddatares (pd, res);
insert into pddatares (pd, res) select distinct pd, count (eno) from freshdata group by pd;
create table pddatav14 (pd, v14);
insert into pddatav14 (pd, v14) select distinct pd, count (v14) from freshdata where v14 is 'x' group by pd;
create table pddatav14k (pd, v14k);
insert into pddatav14k (pd, v14k) select distinct pd, count (v14) from freshdata where v14 is 'x' and knocked is not '' group by pd;

create table pddatagreen45 (pd, green45);
insert into pddatagreen45 (pd, green45) select distinct pd, count (eno) from freshdata where green >= 4 group by pd;

create table pddatagreen45v14 (pd, green45v14);
insert into pddatagreen45v14 (pd, green45v14) select distinct pd, count (eno) from freshdata where green >= 4 and v14 is 'x' group by pd;

create table pddatak (pd, k);
insert into pddatak (pd, k) select distinct pd, count (eno) from freshdata where knocked is not '' group by pd;

create table togetherpd (pd, res, k, v14, v14k, green45, green45v14, rk, rv14, rv14k, rgreen45, rgreen45v14);

insert into togetherpd (pd, res, k, v14, v14k, green45, green45v14, rk, rv14, rv14k, rgreen45, rgreen45v14) select pddatares.pd, pddatares.res, pddatak.k, pddatav14.v14, pddatav14k.v14k, pddatagreen45.green45, pddatagreen45v14.green45v14, pddatak.k*100/pddatares.res, pddatav14.v14*100/pddatares.res, pddatav14k.v14k*100/pddatares.res, pddatagreen45.green45*100/pddatares.res, pddatagreen45v14.green45v14*100/pddatares.res from pddatares left outer join pddatav14 on pddatares.pd = pddatav14.pd left outer join pddatav14k on pddatares.pd = pddatav14k.pd left outer join pddatagreen45 on pddatares.pd = pddatagreen45.pd left outer join pddatagreen45v14 on pddatares.pd = pddatagreen45v14.pd left outer join pddatak on pddatares.pd = pddatak.pd;

create table streetdatares (street, res, pd);
insert into streetdatares (street, res, pd) select distinct street, count (eno), pd from freshdata group by street;
create table streetdatav14 (street, v14);
insert into streetdatav14 (street, v14) select distinct street, count (v14) from freshdata where v14 is 'x' group by street;
create table streetdatav14k (street, v14k);
insert into streetdatav14k (street, v14k) select distinct street, count (v14) from freshdata where v14 is 'x' and knocked is not '' group by street;

create table streetdatagreen45 (street, green45);
insert into streetdatagreen45 (street, green45) select distinct street, count (eno) from freshdata where green >= 4 group by street;

create table streetdatagreen45v14 (street, green45v14);
insert into streetdatagreen45v14 (street, green45v14) select distinct street, count (eno) from freshdata where green >= 4 and v14 is 'x' group by street;

create table streetdatak (street, k);
insert into streetdatak (street, k) select distinct street, count (eno) from freshdata where knocked is not '' group by street;



create table togetherstreet (pd, street, res, k, v14, v14k, green45, green45v14, rk, rv14, rv14k, rgreen45, rgreen45v14);

insert into togetherstreet (pd, street, res, k, v14, v14k, green45, green45v14, rk, rv14, rv14k, rgreen45, rgreen45v14) select streetdatares.pd, streetdatares.street, streetdatares.res, streetdatak.k, streetdatav14.v14, streetdatav14k.v14k, streetdatagreen45.green45, streetdatagreen45v14.green45v14, streetdatak.k*100/streetdatares.res, streetdatav14.v14*100/streetdatares.res, streetdatav14k.v14k*100/streetdatares.res, streetdatagreen45.green45*100/streetdatares.res, streetdatagreen45v14.green45v14*100/streetdatares.res from streetdatares left outer join streetdatav14 on streetdatares.street = streetdatav14.street left outer join streetdatav14k on streetdatares.street = streetdatav14k.street left outer join streetdatagreen45 on streetdatares.street = streetdatagreen45.street left outer join streetdatagreen45v14 on streetdatares.street = streetdatagreen45v14.street left outer join streetdatak on streetdatares.street = streetdatak.street;


.headers on
.output 1streetdata.csv
select * from togetherstreet;
.output stdout


.headers on
.output 1pddata.csv
select * from togetherpd;
.output stdout



