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