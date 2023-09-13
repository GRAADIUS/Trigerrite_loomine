create table kaubanduskeskus(
kaubanduskeskus_id int primary key AUTO_INCREMENT, 
töölised varchar(1000) null, 
kaubad varchar(1000) null, 
poed varchar(1000) null, 
poe_kirjeldus varchar(100) null, 
toote_aegumiskuupäev date null
);
--------------------------------------------------------------
create table logi(
logi_id int primary key AUTO_INCREMENT, 
kasutaja varchar(100), 
andmed text, 
tegevus varchar(15), 
kuupäev datetime
);
