CREATE TABLE PERSONEL
(
	Perno int identity(1,1),
	�sim varchar(15)
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

--2.
--a.
ALTER TABLE PERSONEL
ALTER column �sim varchar(20)

--b.
ALTER TABLE PERSONEL
ADD Memleket varchar(15),
	ogrenim_durumu varchar (15)
	constraint ck_ogrenim_durumu
	check (ogrenim_durumu in ('�lk��retim','Lise','�nlisans','Lisans','Lisans�st�'))
--c.
ALTER TABLE PERSONEL
ADD Boy int
	constraint ck_boy
	check (boy > 0)

--d.
ALTER TABLE PERSONEL
DROP constraint ck_boy,
	 column Boy

--3
INSERT PERSONEL
VALUES ('Ali','Kara','MUH',2500,'01.01.2001','MEMUR','Bolu','Lise'),
('Can','Doruk','SAT',2000,'02.02.2002','MEMUR','Bolu','Lise'),
('Ali','Demir','ARG',3000,'03.03.2003','MEMUR','Sakarya','Lisans'),
('Cem','Potur','MUH',3500,'04.04.2004','SEF','D�zce','Lisans�st�'),
('Eda','Artuk','SAT',2750,'05.05.2005','MEMUR','�zmir','Lisans'),
('Canan','Zorlu','MUH',2500,'06.06.2006','MUDUR','�stanbul','Lisans�st�'),
('Ali','Meri�','ARG',3600,'07.07.2007','SEF','Ankara','Lisans'),
('Abdullah','Bat�n','SAT',1900,'08.08.2008','SEF','Bayburt','�lk��retim'),
('Veli','Okyel','MUH',1500,'09.09.2009','MEMUR','Ankara','�nlisans'),
('Ali Can','Tok','ARG',1900,'08.05.2005','MEMUR','Denizli','�Lk��retim')

INSERT PERSONEL (�sim) VALUES ('Duygu')

INSERT PERSONEL (�sim,Soyad) VALUES ('Derya','�i�ek')

INSERT PERSONEL (�sim,Soyad,Dept) VALUES ('Kemal','Meri�','SAT')

INSERT PERSONEL (�sim,Soyad,Dept,Ucret) VALUES ('Buket','Pale','ARG',2300)

--4.
--a 
UPDATE PERSONEL SET Ucret += Ucret*0.15

--b.
UPDATE PERSONEL SET Ucret += Ucret*0.10 WHERE Baslamatarih <= '01.01.2005'


--c.
UPDATE PERSONEL SET Dept = 'SER', Unvan ='MUDUR' 
WHERE
Perno = (SELECT TOP 1 Perno FROM PERSONEL WHERE Dept = 'SAT' AND Baslamatarih IS NOT NULL ORDER BY Baslamatarih ASC)

--d.
DELETE FROM PERSONEL
WHERE Perno = (SELECT TOP 1 Perno FROM PERSONEL WHERE Dept = 'SER' AND Baslamatarih IS NOT NULL ORDER BY Baslamatarih DESC)

--e.
UPDATE PERSONEL SET Dept = 'NAK', Unvan = 'ELEMAN'
WHERE Dept IS NULL


--5.

--a.
SELECT * FROM PERSONEL WHERE �sim like '___'

--b.
SELECT * FROM PERSONEL WHERE Soyad like '_____' AND Soyad like '%e%'

--c.
SELECT COUNT(*) AS Total FROM PERSONEL WHERE Dept ='SAT'

--d.
SELECT Dept, COUNT(*) AS Total FROM PERSONEL GROUP BY Dept

--e.
SELECT AVG(Ucret) AS Ortlama FROM PERSONEL WHERE Dept = 'MUH'

--f.
SELECT Dept, AVG(Ucret) FROM PERSONEL GROUP BY Dept

--g.
SELECT �sim FROM PERSONEL WHERE 
Perno =(SELECT TOP 1 Perno FROM PERSONEL WHERE Dept = 'SAT' AND Baslamatarih IS NOT NULL ORDER BY Baslamatarih ASC)

--h.
SELECT Unvan, COUNT(*) as Total FROM PERSONEL GROUP BY Unvan

--i.
SELECT Unvan, AVG(Ucret) as Ortalama FROM PERSONEL GROUP BY Unvan

--j.
SELECT * FROM PERSONEL WHERE Ucret > (SELECT Ucret FROM PERSONEL WHERE Dept = 'MUH' AND �sim ='Recep' )

--k.
SELECT TOP 1 Perno, �sim, Dept, Unvan FROM PERSONEL
WHERE Baslamatarih > (SELECT Baslamatarih FROM PERSONEL WHERE Dept='SAT' AND �sim = 'Eda')

--l.
SELECT �sim FROM PERSONEL WHERE 
Baslamatarih > (SELECT Baslamatarih FROM PERSONEL WHERE Dept='ARG' AND �sim ='Ahmet')

--m.
SELECT DISTINCT Dept FROM PERSONEL 

--n.
SELECT DISTINCT Unvan FROM PERSONEL

--o. 
SELECT (SELECT AVG(Ucret) FROM PERSONEL WHERE Dept = 'MUH') - (SELECT AVG(Ucret) FROM PERSONEL WHERE Dept = 'SAT') AS Fark 

--p.
SELECT TOP 1 �sim FROM PERSONEL WHERE Ucret = (SELECT MAX(Ucret) FROM PERSONEL)

--q.
SELECT TOP 3 �sim FROM PERSONEL ORDER BY Ucret DESC 

--r.
SELECT TOP 1 �sim FROM PERSONEL WHERE Ucret IS NOT NULL ORDER BY Ucret ASC

--s.
SELECT TOP 3 �sim FROM PERSONEL WHERE Ucret IS NOT NULL ORDER BY Ucret ASC