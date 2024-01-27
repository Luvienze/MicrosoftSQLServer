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