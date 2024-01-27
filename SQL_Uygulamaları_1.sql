CREATE TABLE OGRENCILER
(
	ogrno int identity(1,1) PRIMARY KEY,
	ograd varchar(5),
	ogrsoyad varchar(15),
	veliadsoyad varchar(20),
	adres varchar(50),
	sýnýf varchar(3)
		constraint ck_sýnýf
		check(sýnýf like('[1][0-2][A-C]')),
	dogumtar date,
	alan varchar(3)
		constraint ck_alan
		check(alan in ('FEN','TM','SOS'))
)

CREATE TABLE URUNLER
(
	urunno int identity(1,1) PRIMARY KEY,
	urunad varchar(15),
	uruntaným varchar(50),
	maliyetfiyat money,
	karoran float,
	KDV float,
	kolisekli varchar(10)
		constraint ck_kolisekli
		check (kolisekli in('ADET','KG','DESTE','LITRE','SERI')),
	CONSTRAINT ck_karoran CHECK (karoran >= maliyetfiyat *0.05 AND karoran <= maliyetfiyat*0.25),
	CONSTRAINT ck_kdv CHECK (kdv >= maliyetfiyat *0.03 AND kdv <= maliyetfiyat *0.25)
)

CREATE TABLE ARABALAR
(
	aracno varchar(4) PRIMARY KEY
		constraint ck_aracno
		check(aracno like ('[ORF][0-9][0-9][0-9]')),
	marka varchar(10)
		constraint ck_marka
		check(marka in ('OPEL','RENAULT','FORD')),
	model varchar(10),
	trafikyil date DEFAULT('2009'),
		constraint ck_trafikyil
		check(trafikyil >= '01.01.2000' AND trafikyil <= '01.01.2009'),
	renk varchar(10),
	yakit varchar(10)
		constraint ck_yakit
		check(yakit in('BENZIN','DIZEL','LPG','KARMA')),
	kilo int
)

--B. 

--1. 
ALTER TABLE OGRENCILER
ADD kangrup varchar(3)
	constraint ck_kangrup
	check(kangrup in ('A+','A-','B+','B-','AB+','AB-','0+','0-')) 

--2.
ALTER TABLE OGRENCILER
ALTER column ograd varchar(15)

--3.
ALTER TABLE OGRENCILER
ADD dogumyer varchar(20)

--4.
ALTER TABLE URUNLER
ALTER column uruntaným varchar(40)

--5.
ALTER TABLE URUNLER
DROP constraint ck_kolisekli,
	 column kolisekli

--6.
ALTER TABLE URUNLER
ADD renk varchar(10),
	kilo int
	constraint ck_kilo
	check(kilo >0)

--7.
ALTER TABLE URUNLER
DROP constraint ck_kilo

ALTER TABLE URUNLER
DROP column kilo

--8. 
ALTER TABLE ARABALAR
DROP constraint ck_aracno

ALTER TABLE ARABALAR
ADD constraint ck_aracno
	check(aracno like '[ORFH][0-9][0-9][0-9]')

--9.
ALTER TABLE ARABALAR
DROP constraint ck_marka

ALTER TABLE ARABALAR
ADD constraint ck_marka
	check(marka in ('OPEL','RENAULT','FORD','HYUNDAI'))

--10.
ALTER TABLE ARABALAR
DROP column kilo

--C
--1.
INSERT OGRENCILER VALUES ('Eren','Sönmez','Serap Sönmez','Düzce','12A','07.29.2002','FEN','0-','Sakarya')
INSERT OGRENCILER VALUES ('Kemal','Ceylan','Ahmet Ceylan','Adana','12C','05.21.1997','SOS','AB+','Osmaniye')
INSERT OGRENCILER VALUES ('Duygu','Coþkun','Nermin Coþkun','Bursa','12B','02.08.2000','FEN','B+','Bursa')

--2.
INSERT OGRENCILER (ograd,ogrsoyad,veliadsoyad,adres,alan,kangrup) 
VALUES('Burcu','Kýran','Mehmet Kýran','Bolu','TM','A-')

INSERT OGRENCILER (ograd,ogrsoyad,veliadsoyad,adres,alan,kangrup) 
VALUES('Zeynep','Derin','Ayþe Derin','Bolu','SOS','AB-')

--3.
INSERT INTO URUNLER (urunad, uruntaným, maliyetfiyat, karoran, kdv, renk)
VALUES('Lightsaber', 'Used by Jedi', 50000,2500, 1500,'Mavi'),
('Sonic Driver', 'Used by Time Lords', 1500, 75, 50,'Gri')

INSERT INTO URUNLER (urunad, uruntaným, maliyetfiyat, karoran, kdv, renk)
VALUES('Council Table', 'Destroyed by Palpatine and Yoda', 200, 10, 10,'Yeþil')

--4.
INSERT INTO URUNLER (urunad, uruntaným, maliyetfiyat, kdv) VALUES
('Ornithopter', 'Chopper for Arrakis', 5000, 150),
('Klarnet', 'Üflemeli Çalgý', 1500, 45)

--5.
INSERT ARABALAR 
VALUES ('O123','OPEL','Vectra','05.27.2008','Beyaz','DIZEL'),
('O129','OPEL','Astra','01.29.2002','Siyah','BENZIN'),
('R356','RENAULT','Megan','11.03.2002','Beyaz','KARMA'),
('H500','HYUNDAI','Tuscon','03.14.2005','Mavi','KARMA')
--6.
INSERT ARABALAR (aracno,marka,trafikyil,yakit)
VALUES ('F003','FORD','01.01.2008','KARMA'),
('F982','FORD','03.25.2003','BENZIN')

--7.
INSERT OGRENCILER (ograd) VALUES ('Ege')

--8.
INSERT OGRENCILER (ograd, dogumtar) VALUES ('Ýrem','05.15.2002')

--9.
ALTER TABLE URUNLER
ADD kolisekli varchar(10)
	constraint ck_kolisekli
	check(kolisekli in ('ADET','KG','DESTE','LITRE','SERI','GRAM'))

INSERT URUNLER (urunad, kolisekli) VALUES ('kalem','GRAM')

--10. 
SET IDENTITY_INSERT URUNLER ON

INSERT URUNLER (urunno,urunad) VALUES (48,'SANDALYE')

SET IDENTITY_INSERT URUNLER OFF

--11. 
INSERT ARABALAR (aracno,marka, model) VALUES ('F004','FORD', 'Focus')


--D

--1.
SELECT * FROM OGRENCILER

--2.
SELECT ogrno, ograd FROM OGRENCILER WHERE sýnýf = '11B'

--3.
SELECT * FROM OGRENCILER WHERE dogumyer = 'BOLU'

--4.
SELECT * FROM OGRENCILER WHERE sýnýf like '11%'

--5.
SELECT * FROM OGRENCILER WHERE ograd like '_____'

--6.
SELECT * FROM OGRENCILER WHERE sýnýf like '12%' AND alan = 'FEN'
