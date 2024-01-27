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