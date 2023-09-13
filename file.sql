create table kaubanduskeskus(
kaubanduskeskus_id int primary key identity(1,1), 
töölised varchar(1000) null, 
kaubad varchar(1000) null, 
poed varchar(1000) null, 
poe_kirjeldus varchar(100) null, 
toote_aegumiskuupäev date null
);
--------------------------------------------------------------
create table logi(
logi_id int primary key identity(1,1), 
kasutaja varchar(100), 
andmed text, 
tegevus varchar(15), 
kuupäev datetime
);
--------------------------------------------------------------
--------------------------------------------------------------
create trigger lisamine
on kaubanduskeskus
for insert
as 
insert into logi(kasutaja, andmed, tegevus, kuupäev) 
select user, 
concat(inserted.töölised, ', ', inserted.kaubad, ', ', inserted.poed, ', ', 
inserted.poe_kirjeldus, ', ', inserted.toote_aegumiskuupäev), 
'Insert', GETDATE()
from inserted
--------------------------------------------------------------
INSERT INTO kaubanduskeskus (poed, toote_aegumiskuupäev) VALUES ('Ise cream', '2023-12-12');
select * from kaubanduskeskus;
select * from logi;
--------------------------------------------------------------
--------------------------------------------------------------
create trigger kustutamine
on kaubanduskeskus
for delete
as 
insert into logi(kasutaja, andmed, tegevus, kuupäev) 
select user, 
concat(deleted.töölised, ', ', deleted.kaubad, ', ', deleted.poed, ', ', 
deleted.poe_kirjeldus, ', ', deleted.toote_aegumiskuupäev), 
'delete', GETDATE()
from deleted
--------------------------------------------------------------
delete from kaubanduskeskus where toote_aegumiskuupäev = '2023-12-12';
select * from kaubanduskeskus;
select * from logi;
--------------------------------------------------------------
--------------------------------------------------------------
CREATE PROCEDURE näita  
AS   
select * from kaubanduskeskus;
select * from logi;
--------------------------------------------------------------
EXECUTE näita;  
--------------------------------------------------------------
--------------------------------------------------------------
CREATE PROCEDURE millal_tooted_halvaks_lähevad  
    @name_of_product varchar(50)  
AS   
select * from kaubanduskeskus where poed = @name_of_product;
--------------------------------------------------------------
EXECUTE millal_tooted_halvaks_lähevad @name_of_product= 'ise cream';  
--------------------------------------------------------------
--------------------------------------------------------------
CREATE PROCEDURE näitab_töötajate_arvu  
AS   
SELECT COUNT(töölised) FROM kaubanduskeskus;
--------------------------------------------------------------
EXECUTE näitab_töötajate_arvu;  
--------------------------------------------------------------
--------------------------------------------------------------
CREATE PROCEDURE kustuta  
@kasutaja_id int
AS   
delete from kaubanduskeskus where kaubanduskeskus_id = @kasutaja_id;
--------------------------------------------------------------
select * from kaubanduskeskus;
EXECUTE kustuta @kasutaja_id = 3;  
select * from kaubanduskeskus;
