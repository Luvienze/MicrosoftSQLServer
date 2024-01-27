CREATE TABLE Ýller 
(
	Ýlkodu int PRIMARY KEY
		constraint ck_ilkodu
		check(ilkodu > 0),
	Ýl_Adý varchar (20)
)

CREATE TABLE Yayýnevleri
(
	Yayýnevi_No int PRIMARY KEY,
	Yayýnevi_Adý varchar(20),
	Yetkili varchar(20),
	ÝlKodu int FOREIGN KEY REFERENCES Ýller (Ýlkodu),
	Tel varchar(11)
		constraint ck_tel
		check(tel like ('380-%')),
	webadresi varchar(50)
		constraint ck_webadresi
		check (webadresi like ('www.%') AND webadresi like ('%.com'))
)

CREATE TABLE Kitaplar
(
	Kitap_No int identity(1,1) PRIMARY KEY,
	Kitap_Adý varchar(20)
		constraint ck_kitap_adý
		check(kitap_adý like ('%[a-zA-Z]%')),
	Yazar_Adý varchar(20)
		constraint ck_yazar_adý
		check (yazar_adý like ('%[a-zA-Z]%')),
	Birim_Fiyat money,
	Basým_Yýlý date NOT NULL
		constraint ck_basým_yýlý
		check(basým_yýlý <= getDate())
		DEFAULT(getDate()),
	Kategori varchar(20)
		constraint ck_kategori
		check(kategori in ('Programlama','Grafik-Tasarým','Network', 'Genel', 'Veritabaný')),
	Yayýnevi_No int FOREIGN KEY REFERENCES Yayýnevleri (Yayýnevi_No)
)

CREATE TABLE Müþteriler
(
	Müþteri_No int identity(1,1) PRIMARY KEY,
	Ad varchar(20)
		constraint ck_ad
		check(ad like '%[a-zA-Z]%'),
	Soyad varchar(20)
		constraint ck_soyad
		check(soyad like '%[a-zA-Z]%'),
	Tel varchar(11),
	Ýlkodu int FOREIGN KEY REFERENCES Ýller(Ýlkodu)
)

CREATE TABLE Satýþlar
(
	Sat_No int identity(1,1) PRIMARY KEY,
	Tarih date
		constraint ck_tarih
		check(tarih<=getDate())
		DEFAULT(getDate()),
	Müþteri_No int FOREIGN KEY REFERENCES Müþteriler(Müþteri_No),
	Kitap_No int FOREIGN KEY REFERENCES Kitaplar(Kitap_No),
	Adet int 
		constraint ck_adet
		check(adet > 0)
)
-- //////// INSERTLER ////////

INSERT Ýller VALUES (54, 'Sakarya'),(81, 'Düzce'), (34, 'Ýstanbul'), (05,'Ankara'), (35,'Ýzmir')

INSERT Müþteriler VALUES
('Eren','Sönmez','380-5142890',54),
('Þamil','Keten','380-5142890',35),
('Deniz','Ulu','380-5142890',81)

INSERT INTO Müþteriler (Ad,Tel,Ýlkodu) VALUES
('Fatma','380-5142991',05),
('Ege','380-5143092',35),
('Caner','380-5143193',81)

INSERT Yayýnevleri VALUES (1,'Ýthaki', 'Yetkili1', 34, '380-5142789','www.ithaki.com')

INSERT Yayýnevleri VALUES (2,'Pegasus', 'Yetkili2', 35, '380-5142890','www.pegasus.com'),
(3,'ziraat', 'Yetkili3', 34, '380-5142991','www.ziraat.com'),
(4,'domingo', 'Yetkili4', 54, '380-5143092','www.domingo.com'),
(5,'kapra', 'Yetkili5', 54, '380-5143193','www.kapra.com')

INSERT Kitaplar VALUES ('Dune','Frank Herbert', 130, '01.01.2001', 'Genel',1)

INSERT Kitaplar VALUES ('Yüzük Kardeþliði','J.R.R Tolkien', 100, '01.01.1999', 'Genel',2),
('Bilgisayar Aðlarý','Resul Kara', 170, '02.02.2020', 'Network',2),
('SQL Server','Microsoft', 80, '03.03.2003', 'Veritabaný',3),
('Java ile OOP','Oracle', 200, '04.04.1998', 'Programlama',4),
('Spring Framework','Oracle', 130, '05.05.2004', 'Programlama',5),
('Blender Tutorial ','Blender ', 50, '06.06.2020', 'Grafik-Tasarým',1)

INSERT Satýþlar VALUES
(getDate(),1,1,1),
(getDate(),1,5,1),
(getDate(),1,6,1),
(getDate(),2,2,2),
(getDate(),2,3,1),
(getDate(),2,4,1),
(getDate(),3,7,1),
(getDate(),3,6,2),
(getDate(),3,4,3),
(getDate(),3,1,1)

--3. //////// GÜNCELLEMELER ////////
SELECT * FROM Müþteriler

--a.
UPDATE Müþteriler SET Soyad = 'UNKNOWN' WHERE Soyad IS NULL

--b.
SELECT UPPER(LEFT(Yayýnevi_Adý,1)) + LOWER(SUBSTRING(Yayýnevi_Adý,2, LEN(Yayýnevi_Adý))) FROM Yayýnevleri

--c.
SELECT UPPER(Kitap_Adý) FROM Kitaplar

--d.
ALTER TABLE Yayýnevleri
DROP constraint ck_webadresi

ALTER TABLE Yayýnevleri
ADD constraint ck_webadresi
	check(webadresi like '%.com' OR webadresi like '%.org')

UPDATE Yayýnevleri SET webadresi = (REPLACE(webadresi, '.com','.org')) FROM Yayýnevleri

--e.
DELETE FROM Satýþlar WHERE Müþteri_No IN 
(SELECT Müþteri_No FROM Müþteriler WHERE Ad like '%Þ%' AND Ad like '_____')
 
DELETE FROM Müþteriler WHERE Ad like '%Þ%' AND Ad like '_____'

--4. //////// SÝLMELER ////////
--a.
DELETE FROM Satýþlar WHERE Müþteri_No IN 
(SELECT Müþteri_No FROM Müþteriler WHERE Ad like '%Þ%' AND Ad like '_____')
 
DELETE FROM Müþteriler WHERE Ad like '%Þ%' AND Ad like '_____'

--b.
DELETE FROM Müþteriler WHERE Ýlkodu = (SELECT Ýlkodu FROM Ýller WHERE Ýl_Adý= 'Kars')

--c.
DELETE FROM Satýþlar WHERE Müþteri_No IN (SELECT Müþteri_No FROM Müþteriler WHERE Ýlkodu = (SELECT Ýlkodu FROM Ýller WHERE Ýl_Adý='Ankara'))
AND Kitap_No = (SELECT Kitap_No FROM Kitaplar WHERE Kitap_Adý = 'C#')

SELECT * FROM Yayýnevleri
--d.
DELETE FROM Satýþlar WHERE Kitap_No IN (SELECT Kitap_No FROM Kitaplar WHERE Yayýnevi_No IN 
									   (SELECT Yayýnevi_No FROM Yayýnevleri WHERE Yetkili = 'Yetkili 5'))
 
 --5.
-- //////// ALT SORGULAR ////////

--a.
SELECT * FROM Satýþlar WHERE Kitap_No = (SELECT Kitap_No FROM Kitaplar WHERE Kitap_Adý = 'Dune')

--b.
SELECT * FROM Satýþlar WHERE Müþteri_No = (SELECT Müþteri_No FROM Müþteriler WHERE Ad = 'Eren')

--c.
SELECT Ad 
FROM Müþteriler
WHERE Müþteri_No IN 
(SELECT Müþteri_No FROM Satýþlar WHERE Kitap_No = (SELECT Kitap_No FROM Kitaplar WHERE Kitap_Adý = 'Dune'))

--d.
SELECT Ad 
FROM Müþteriler
WHERE Müþteri_No IN
(SELECT Müþteri_No FROM Satýþlar WHERE Kitap_No IN 
(SELECT Kitap_No FROM Kitaplar WHERE Yayýnevi_No = 
(SELECT Yayýnevi_No FROM Yayýnevleri WHERE Yayýnevi_Adý = 'domingo')))

--e.
SELECT COUNT(*) FROM Satýþlar WHERE Kitap_No IN 
(SELECT Kitap_No FROM Kitaplar WHERE Birim_Fiyat >= 100)

--f.
SELECT COUNT(*) FROM Satýþlar WHERE Müþteri_No IN
(SELECT Müþteri_No FROM Müþteriler WHERE Ýlkodu = 
(SELECT Ýlkodu FROM Ýller WHERE Ýl_Adý = 'Ankara'))
AND Kitap_No IN 
(SELECT Kitap_No FROM Kitaplar WHERE Kategori = 'Programlama')

--g.
SELECT Yayýnevi_Adý FROM Yayýnevleri WHERE Yayýnevi_No IN 
(SELECT Yayýnevi_No FROM Kitaplar WHERE Kitap_No NOT IN (SELECT Kitap_No FROM Satýþlar))
 
 -- //////// JOIN ////////
 --a 
SELECT * FROM Satýþlar s INNER JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No
WHERE Kitap_Adý = 'Dune'

--b.
SELECT * FROM Satýþlar s INNER JOIN Müþteriler m
ON s.Müþteri_No = m.Müþteri_No
WHERE Ad = 'Eren'

--c.
SELECT Ad FROM Satýþlar s INNER JOIN Müþteriler m
ON s.Müþteri_No = m.Müþteri_No JOIN Kitaplar k
ON k.Kitap_No = s.Kitap_No
WHERE Kitap_Adý = 'Dune'

--d.
SELECT Ad FROM Müþteriler m INNER JOIN Satýþlar s
ON m.Müþteri_No = s.Müþteri_No JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No JOIN Yayýnevleri y
ON k.Yayýnevi_No = y.Yayýnevi_No
WHERE Yayýnevi_Adý = 'domingo'

--e.
SELECT Count(*) FROM Satýþlar s INNER JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No
WHERE k.Birim_Fiyat > 100

--f.
SELECT COUNT(*) FROM Satýþlar s INNER JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No JOIN Müþteriler m
ON s.Müþteri_No = m.Müþteri_No JOIN Ýller i
ON m.Ýlkodu = i.Ýlkodu
WHERE Ýl_Adý = 'Ankara' AND Kategori = 'Programlama'

--g.
SELECT Yayýnevi_Adý FROM Yayýnevleri y LEFT JOIN Kitaplar k
ON y.Yayýnevi_No = k.Yayýnevi_No LEFT JOIN Satýþlar s
ON k.Kitap_No = s.Kitap_No
GROUP BY Yayýnevi_Adý
HAVING COUNT (s.Kitap_No) = 0 OR Count(s.Kitap_No) IS NULL

--6 //////// STORED PROCEDURE ////////

--a.
CREATE PROC spListMüþteriler
AS
	SELECT * FROM Müþteriler
GO

EXEC spListMüþteriler

--b.
CREATE PROC spListKitap
	@kitapadý varchar(20)
AS
	SELECT * FROM Satýþlar s INNER JOIN Kitaplar k
	ON s.Kitap_No = k.Kitap_No
	WHERE k.Kitap_Adý = @kitapadý
GO

EXEC spListKitap 'Dune'

--c.
CREATE PROC spListKitapSatýþToplam
	@yayýneviadý varchar(20)
AS
	SELECT * FROM Satýþlar s INNER JOIN Kitaplar k
	ON s.Kitap_No = k.Kitap_No JOIN Yayýnevleri y
	ON k.Yayýnevi_No = y.Yayýnevi_No
	WHERE Yayýnevi_Adý = @yayýneviadý
GO

EXEC spListKitapSatýþToplam 'domingo'

--d.
CREATE PROC spKitapZam
	@yayýneviadý varchar(20)
AS
	UPDATE Kitaplar SET Birim_Fiyat += Birim_Fiyat * 0.10
	FROM Kitaplar k LEFT JOIN Yayýnevleri y
	ON k.Yayýnevi_No = y.Yayýnevi_No
	WHERE y.Yayýnevi_Adý = @yayýneviadý
GO

EXEC spKitapZam 'domingo'

--e.
CREATE PROC spKitapÝndirim
AS
	UPDATE Kitaplar SET Birim_Fiyat -= Birim_Fiyat *0.20
	WHERE Kitap_No NOT IN (SELECT Kitap_No FROM Satýþlar)
GO

EXEC spKitapÝndirim


--f.
CREATE PROC spEnÇokSatýlan
AS
	SELECT k.Kitap_Adý, y.Yayýnevi_Adý FROM Satýþlar s INNER JOIN Kitaplar k
	ON s.Kitap_No = k.Kitap_No JOIN Yayýnevleri y
	ON k.Yayýnevi_No =y.Yayýnevi_No
	WHERE Adet = (SELECT MAX(Adet) FROM Satýþlar)
GO

EXEC spEnÇokSatýlan

--g. 
CREATE PROC spEnÇokAlýþveriþYapan
AS
	SELECT TOP 1 Ad FROM Müþteriler m INNER JOIN Satýþlar s
	ON m.Müþteri_No = s.Müþteri_No
	GROUP BY m.Ad
	ORDER BY COUNT(*) DESC
GO

EXEC spEnÇokAlýþveriþYapan