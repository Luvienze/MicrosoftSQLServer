CREATE TABLE PERSONEL
(
	Perno int identity(1,1),
	Ýsim varchar(15)
		constraint ck_isim
		check (isim >= '___'),
	Soyad varchar (15)
		constraint ck_soyad
		check (soyad >= '__'),
	Dept varchar(3)
		constraint ck_dept
		check (dept in ('MUH','SAT','SER','NAK','ARG')),
	Ucret money
		constraint ck_ucret
		check (ucret BETWEEN 0 AND 10000),
	Baslamatarih date
		constraint ck_baslamatarih
		check (baslamatarih >= '01.01.2000' AND baslamatarih <= getDate()),
	Unvan varchar (6)
		constraint ck_unvan
		check (unvan in ('MUDUR','SEF','MEMUR','ELEMAN'))
)