

drop table pdknocknext;
create table pdknocknext (pd);

insert into pdknocknext (pd) select pd from togetherpd order by rk limit 1;

drop table streetknocknext1;
create table streetknocknext1 (pd, street, rk, rv14, rgreen45);

insert into streetknocknext1 (pd, street, rk, rv14, rgreen45) select pdknocknext.pd, togetherstreet.street, togetherstreet.rk, togetherstreet.rv14, togetherstreet.rgreen45 from togetherstreet inner join pdknocknext on pdknocknext.pd = togetherstreet.pd;
 
drop table streetknocknext2;
create table streetknocknext2 (pd, street, rk, rv14, rgreen45);

insert into streetknocknext2 (pd, street, rk, rv14, rgreen45) select pd, street, rk, rv14, rgreen45 from streetknocknext1 order by rk limit 40;

drop table streetknocknext3;
create table streetknocknext3 (pd, street, rk, rv14, rgreen45);

insert into streetknocknext3 (pd, street, rk, rv14, rgreen45) select pd, street, rk, rv14, rgreen45 from streetknocknext1 order by rv14 desc limit 30;

drop table streetknocknext;
create table streetknocknext (pd, street, rk, rv14, rgreen45);

insert into streetknocknext (pd, street, rk, rv14, rgreen45) select pd, street, rk, rv14, rgreen45 from streetknocknext1 order by rgreen45 desc limit 20;

drop table knockdraft;

create table knockdraft (
  "pd" TEXT,
  "eno" TEXT,
  "firstname" TEXT,
  "surname" TEXT,
  "fulladdress" TEXT,
  "street" TEXT,
  "address_1" TEXT,
  "address_2" TEXT,
  "address_3" TEXT,
  "address_4" TEXT,
  "address_5" TEXT,
  "address_6" TEXT,
  "address_7" TEXT,
  "priorres" TEXT,
  "v12" TEXT,
  "v14" TEXT,
  "green" TEXT,
  "intent" TEXT,
  "surveyn" TEXT,
  "yearmovedin" TEXT,
  "knocked" TEXT,
  "other1" TEXT,
  "other2" TEXT
);

insert into knockdraft (pd, eno, firstname, surname, fulladdress, street, address_1, address_2, address_3, address_4, address_5, address_6, address_7, priorres, v12, v14, green, intent, surveyn, yearmovedin, knocked, other1, other2) select streetknocknext.pd, freshdata.eno, freshdata.firstname, freshdata.surname, freshdata.fulladdress, streetknocknext.street, freshdata.address_1, freshdata.address_2, freshdata.address_3, freshdata.address_4, freshdata.address_5, freshdata.address_6, freshdata.address_7, freshdata.priorres, freshdata.v12, freshdata.v14, freshdata.green, freshdata.intent, freshdata.surveyn, freshdata.yearmovedin, freshdata.knocked, freshdata.other1, freshdata.other2 from freshdata inner join streetknocknext on streetknocknext.street = freshdata.street;

drop table knock;
create table knock (
  "firstname" TEXT,
  "surname" TEXT,
  "fulladdress" TEXT,
  "street" TEXT,
  "address_1" TEXT,
  "priorres" TEXT,
  "v12" TEXT,
  "v14" TEXT,
  "green" TEXT,
  "intent" TEXT,
  "surveyn" TEXT,
  "yearmovedin" TEXT,
  "knocked" TEXT,
  "other1" TEXT,
  "other2" TEXT
);

insert into knock (firstname, surname, fulladdress, street, address_1, priorres, v12, v14, green, intent, surveyn, yearmovedin, knocked, other1, other2) select firstname, surname, fulladdress, street, address_1, priorres, v12, v14, green, intent, surveyn, yearmovedin, knocked, other1, other2 from knockdraft order by street;

.output 1knockdraft.csv
select * from knockdraft;
.output stdout

.output 1knock.csv
select * from knock;
.output stdout



