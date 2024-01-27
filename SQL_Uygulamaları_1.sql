CREATE TABLE OGRENCILER
(
	ogrno int identity(1,1) PRIMARY KEY,
	ograd varchar(5),
	ogrsoyad varchar(15),
	veliadsoyad varchar(20),
	adres varchar(50),
	s�n�f varchar(3)
		constraint ck_s�n�f
		check(s�n�f like('[1][0-2][A-C]')),
	dogumtar date,
	alan varchar(3)
		constraint ck_alan
		check(alan in ('FEN','TM','SOS'))
)

CREATE TABLE URUNLER
(
	urunno int identity(1,1) PRIMARY KEY,
	urunad varchar(15),
	uruntan�m varchar(50),
	maliyetfiyat money,
	karoran float,
	KDV float,
	kolisekli varchar(10)
		constraint ck_kolisekli
		check (kolisekli in('ADET','KG','DESTE','LITRE','SERI')),
	CONSTRAINT ck_karoran CHECK (karoran >= maliyetfiyat *0.05 AND karoran <= maliyetfiyat*0.25),
	CONSTRAINT ck_kdv CHECK (kdv >= maliyetfiyat *0.03 AND kdv <= maliyetfiyat *0.25)
)