drop table freshdata1;
CREATE TABLE freshdata1(
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
  "other2" TEXT,
  "partymember" TEXT
);

.mode csv
drop table old;
.import old.csv old
alter table old add column v12;
alter table old add column v14;
alter table old add column green;
alter table old add column intent;
alter table old add column surveyn;
alter table old add column knocked;
alter table old add column other1;
alter table old add column other2;
alter table old add column yearmovedin;
alter table old add column priorres;
alter table old add column partymember;
alter table members add column partymember;
alter table members add column street;
update old set priorres = 'yes'; 

drop table councilupdated;
.import uptodateregister.csv councilupdated

insert into freshdata1 (pd,eno,firstname,surname,fulladdress,street,address_1,address_2,address_3,address_4,address_5,address_6,address_7,v12,v14,green,intent,surveyn,knocked,other1,other2,yearmovedin,priorres) 
select councilupdated.pd, councilupdated.eno, councilupdated.firstname, councilupdated.surname, councilupdated.fulladdress, councilupdated.street, councilupdated.address_1, councilupdated.address_2,councilupdated.address_3,councilupdated.address_4,councilupdated.address_5,councilupdated.address_6,councilupdated.address_7,
old.v12, old.v14, old.green, old.intent, old.surveyn, old.knocked, old.other1, old.other2, old.yearmovedin, old.priorres 
from councilupdated 
left outer join old on councilupdated.firstname = old.firstname and councilupdated.surname = old.surname and councilupdated.address_1 = old.address_1;

update freshdata1 set yearmovedin = '2015' where priorres is not 'yes';
update freshdata1 set priorres = 'no' where yearmovedin is '2015';

delete from freshdata1 where rowid not in 
(select min(rowid) from freshdata1 group by firstname, surname, address_1);

drop table members;
.import members.csv members
alter table members add column partymember;
alter table members add column street;
update members set partymember = 'yes'; 

drop table streetmembers;
CREATE TABLE streetmembers(
  "FirstName" TEXT,
  "LastName" TEXT,
 partymember, street);

insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_7;

insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_6;
  
insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_5;

insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_4;

insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_3;

insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_2;

insert into streetmembers (FirstName, LastName, partymember, street) select freshdata1.firstname, freshdata1.surname, members.partymember, freshdata1.street from freshdata1 inner join members on freshdata1.firstname = members.FirstName and freshdata1.surname = members.LastName and members.PostalCode = freshdata1.address_1;

drop table freshdata2;
CREATE TABLE freshdata2(
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
  "other2" TEXT,
  "partymember" TEXT
);

insert into freshdata2 (pd, eno, firstname, surname, fulladdress, street, address_1, address_2, address_3, address_4, address_5, address_6, address_7, priorres, v12, v14, green, intent, surveyn, knocked, other1, other2, yearmovedin, partymember) 
select freshdata1.pd, freshdata1.eno, freshdata1.firstname, freshdata1.surname, freshdata1.fulladdress, freshdata1.street, freshdata1.address_1, freshdata1.address_2, freshdata1.address_3, freshdata1.address_4, freshdata1.address_5, freshdata1.address_6, freshdata1.address_7, freshdata1.priorres, freshdata1.v12, freshdata1.v14, freshdata1.green, freshdata1.intent, freshdata1.surveyn, freshdata1.knocked, freshdata1.other1, freshdata1.other2, freshdata1.yearmovedin, streetmembers.partymember
from freshdata1 left outer join streetmembers on freshdata1.firstname = streetmembers.FirstName and freshdata1.surname = streetmembers.Lastname and freshdata1.street = streetmembers.street;

.headers on
.output 1freshdata.csv
select * from freshdata2;
.output stdout


