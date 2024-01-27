CREATE TABLE �ller 
(
	�lkodu int PRIMARY KEY
		constraint ck_ilkodu
		check(ilkodu > 0),
	�l_Ad� varchar (20)
)

CREATE TABLE Yay�nevleri
(
	Yay�nevi_No int PRIMARY KEY,
	Yay�nevi_Ad� varchar(20),
	Yetkili varchar(20),
	�lKodu int FOREIGN KEY REFERENCES �ller (�lkodu),
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
	Kitap_Ad� varchar(20)
		constraint ck_kitap_ad�
		check(kitap_ad� like ('%[a-zA-Z]%')),
	Yazar_Ad� varchar(20)
		constraint ck_yazar_ad�
		check (yazar_ad� like ('%[a-zA-Z]%')),
	Birim_Fiyat money,
	Bas�m_Y�l� date NOT NULL
		constraint ck_bas�m_y�l�
		check(bas�m_y�l� <= getDate())
		DEFAULT(getDate()),
	Kategori varchar(20)
		constraint ck_kategori
		check(kategori in ('Programlama','Grafik-Tasar�m','Network', 'Genel', 'Veritaban�')),
	Yay�nevi_No int FOREIGN KEY REFERENCES Yay�nevleri (Yay�nevi_No)
)

CREATE TABLE M��teriler
(
	M��teri_No int identity(1,1) PRIMARY KEY,
	Ad varchar(20)
		constraint ck_ad
		check(ad like '%[a-zA-Z]%'),
	Soyad varchar(20)
		constraint ck_soyad
		check(soyad like '%[a-zA-Z]%'),
	Tel varchar(11),
	�lkodu int FOREIGN KEY REFERENCES �ller(�lkodu)
)

CREATE TABLE Sat��lar
(
	Sat_No int identity(1,1) PRIMARY KEY,
	Tarih date
		constraint ck_tarih
		check(tarih<=getDate())
		DEFAULT(getDate()),
	M��teri_No int FOREIGN KEY REFERENCES M��teriler(M��teri_No),
	Kitap_No int FOREIGN KEY REFERENCES Kitaplar(Kitap_No),
	Adet int 
		constraint ck_adet
		check(adet > 0)
)
-- //////// INSERTLER ////////

INSERT �ller VALUES (54, 'Sakarya'),(81, 'D�zce'), (34, '�stanbul'), (05,'Ankara'), (35,'�zmir')

INSERT M��teriler VALUES
('Eren','S�nmez','380-5142890',54),
('�amil','Keten','380-5142890',35),
('Deniz','Ulu','380-5142890',81)

INSERT INTO M��teriler (Ad,Tel,�lkodu) VALUES
('Fatma','380-5142991',05),
('Ege','380-5143092',35),
('Caner','380-5143193',81)

INSERT Yay�nevleri VALUES (1,'�thaki', 'Yetkili1', 34, '380-5142789','www.ithaki.com')

INSERT Yay�nevleri VALUES (2,'Pegasus', 'Yetkili2', 35, '380-5142890','www.pegasus.com'),
(3,'ziraat', 'Yetkili3', 34, '380-5142991','www.ziraat.com'),
(4,'domingo', 'Yetkili4', 54, '380-5143092','www.domingo.com'),
(5,'kapra', 'Yetkili5', 54, '380-5143193','www.kapra.com')

INSERT Kitaplar VALUES ('Dune','Frank Herbert', 130, '01.01.2001', 'Genel',1)

INSERT Kitaplar VALUES ('Y�z�k Karde�li�i','J.R.R Tolkien', 100, '01.01.1999', 'Genel',2),
('Bilgisayar A�lar�','Resul Kara', 170, '02.02.2020', 'Network',2),
('SQL Server','Microsoft', 80, '03.03.2003', 'Veritaban�',3),
('Java ile OOP','Oracle', 200, '04.04.1998', 'Programlama',4),
('Spring Framework','Oracle', 130, '05.05.2004', 'Programlama',5),
('Blender Tutorial ','Blender ', 50, '06.06.2020', 'Grafik-Tasar�m',1)

INSERT Sat��lar VALUES
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

--3. //////// G�NCELLEMELER ////////
SELECT * FROM M��teriler

--a.
UPDATE M��teriler SET Soyad = 'UNKNOWN' WHERE Soyad IS NULL

--b.
SELECT UPPER(LEFT(Yay�nevi_Ad�,1)) + LOWER(SUBSTRING(Yay�nevi_Ad�,2, LEN(Yay�nevi_Ad�))) FROM Yay�nevleri

--c.
SELECT UPPER(Kitap_Ad�) FROM Kitaplar

--d.
ALTER TABLE Yay�nevleri
DROP constraint ck_webadresi

ALTER TABLE Yay�nevleri
ADD constraint ck_webadresi
	check(webadresi like '%.com' OR webadresi like '%.org')

UPDATE Yay�nevleri SET webadresi = (REPLACE(webadresi, '.com','.org')) FROM Yay�nevleri

--e.
DELETE FROM Sat��lar WHERE M��teri_No IN 
(SELECT M��teri_No FROM M��teriler WHERE Ad like '%�%' AND Ad like '_____')
 
DELETE FROM M��teriler WHERE Ad like '%�%' AND Ad like '_____'

--4. //////// S�LMELER ////////
--a.
DELETE FROM Sat��lar WHERE M��teri_No IN 
(SELECT M��teri_No FROM M��teriler WHERE Ad like '%�%' AND Ad like '_____')
 
DELETE FROM M��teriler WHERE Ad like '%�%' AND Ad like '_____'

--b.
DELETE FROM M��teriler WHERE �lkodu = (SELECT �lkodu FROM �ller WHERE �l_Ad�= 'Kars')

--c.
DELETE FROM Sat��lar WHERE M��teri_No IN (SELECT M��teri_No FROM M��teriler WHERE �lkodu = (SELECT �lkodu FROM �ller WHERE �l_Ad�='Ankara'))
AND Kitap_No = (SELECT Kitap_No FROM Kitaplar WHERE Kitap_Ad� = 'C#')

SELECT * FROM Yay�nevleri
--d.
DELETE FROM Sat��lar WHERE Kitap_No IN (SELECT Kitap_No FROM Kitaplar WHERE Yay�nevi_No IN 
									   (SELECT Yay�nevi_No FROM Yay�nevleri WHERE Yetkili = 'Yetkili 5'))
 
 --5.
-- //////// ALT SORGULAR ////////

--a.
SELECT * FROM Sat��lar WHERE Kitap_No = (SELECT Kitap_No FROM Kitaplar WHERE Kitap_Ad� = 'Dune')

--b.
SELECT * FROM Sat��lar WHERE M��teri_No = (SELECT M��teri_No FROM M��teriler WHERE Ad = 'Eren')

--c.
SELECT Ad 
FROM M��teriler
WHERE M��teri_No IN 
(SELECT M��teri_No FROM Sat��lar WHERE Kitap_No = (SELECT Kitap_No FROM Kitaplar WHERE Kitap_Ad� = 'Dune'))

--d.
SELECT Ad 
FROM M��teriler
WHERE M��teri_No IN
(SELECT M��teri_No FROM Sat��lar WHERE Kitap_No IN 
(SELECT Kitap_No FROM Kitaplar WHERE Yay�nevi_No = 
(SELECT Yay�nevi_No FROM Yay�nevleri WHERE Yay�nevi_Ad� = 'domingo')))

--e.
SELECT COUNT(*) FROM Sat��lar WHERE Kitap_No IN 
(SELECT Kitap_No FROM Kitaplar WHERE Birim_Fiyat >= 100)

--f.
SELECT COUNT(*) FROM Sat��lar WHERE M��teri_No IN
(SELECT M��teri_No FROM M��teriler WHERE �lkodu = 
(SELECT �lkodu FROM �ller WHERE �l_Ad� = 'Ankara'))
AND Kitap_No IN 
(SELECT Kitap_No FROM Kitaplar WHERE Kategori = 'Programlama')

--g.
SELECT Yay�nevi_Ad� FROM Yay�nevleri WHERE Yay�nevi_No IN 
(SELECT Yay�nevi_No FROM Kitaplar WHERE Kitap_No NOT IN (SELECT Kitap_No FROM Sat��lar))
 
 -- //////// JOIN ////////
 --a 
SELECT * FROM Sat��lar s INNER JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No
WHERE Kitap_Ad� = 'Dune'

--b.
SELECT * FROM Sat��lar s INNER JOIN M��teriler m
ON s.M��teri_No = m.M��teri_No
WHERE Ad = 'Eren'

--c.
SELECT Ad FROM Sat��lar s INNER JOIN M��teriler m
ON s.M��teri_No = m.M��teri_No JOIN Kitaplar k
ON k.Kitap_No = s.Kitap_No
WHERE Kitap_Ad� = 'Dune'

--d.
SELECT Ad FROM M��teriler m INNER JOIN Sat��lar s
ON m.M��teri_No = s.M��teri_No JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No JOIN Yay�nevleri y
ON k.Yay�nevi_No = y.Yay�nevi_No
WHERE Yay�nevi_Ad� = 'domingo'

--e.
SELECT Count(*) FROM Sat��lar s INNER JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No
WHERE k.Birim_Fiyat > 100

--f.
SELECT COUNT(*) FROM Sat��lar s INNER JOIN Kitaplar k
ON s.Kitap_No = k.Kitap_No JOIN M��teriler m
ON s.M��teri_No = m.M��teri_No JOIN �ller i
ON m.�lkodu = i.�lkodu
WHERE �l_Ad� = 'Ankara' AND Kategori = 'Programlama'

--g.
SELECT Yay�nevi_Ad� FROM Yay�nevleri y LEFT JOIN Kitaplar k
ON y.Yay�nevi_No = k.Yay�nevi_No LEFT JOIN Sat��lar s
ON k.Kitap_No = s.Kitap_No
GROUP BY Yay�nevi_Ad�
HAVING COUNT (s.Kitap_No) = 0 OR Count(s.Kitap_No) IS NULL

--6 //////// STORED PROCEDURE ////////

--a.
CREATE PROC spListM��teriler
AS
	SELECT * FROM M��teriler
GO

EXEC spListM��teriler

--b.
CREATE PROC spListKitap
	@kitapad� varchar(20)
AS
	SELECT * FROM Sat��lar s INNER JOIN Kitaplar k
	ON s.Kitap_No = k.Kitap_No
	WHERE k.Kitap_Ad� = @kitapad�
GO

EXEC spListKitap 'Dune'

--c.
CREATE PROC spListKitapSat��Toplam
	@yay�neviad� varchar(20)
AS
	SELECT * FROM Sat��lar s INNER JOIN Kitaplar k
	ON s.Kitap_No = k.Kitap_No JOIN Yay�nevleri y
	ON k.Yay�nevi_No = y.Yay�nevi_No
	WHERE Yay�nevi_Ad� = @yay�neviad�
GO

EXEC spListKitapSat��Toplam 'domingo'

--d.
CREATE PROC spKitapZam
	@yay�neviad� varchar(20)
AS
	UPDATE Kitaplar SET Birim_Fiyat += Birim_Fiyat * 0.10
	FROM Kitaplar k LEFT JOIN Yay�nevleri y
	ON k.Yay�nevi_No = y.Yay�nevi_No
	WHERE y.Yay�nevi_Ad� = @yay�neviad�
GO

EXEC spKitapZam 'domingo'

--e.
CREATE PROC spKitap�ndirim
AS
	UPDATE Kitaplar SET Birim_Fiyat -= Birim_Fiyat *0.20
	WHERE Kitap_No NOT IN (SELECT Kitap_No FROM Sat��lar)
GO

EXEC spKitap�ndirim


--f.
CREATE PROC spEn�okSat�lan
AS
	SELECT k.Kitap_Ad�, y.Yay�nevi_Ad� FROM Sat��lar s INNER JOIN Kitaplar k
	ON s.Kitap_No = k.Kitap_No JOIN Yay�nevleri y
	ON k.Yay�nevi_No =y.Yay�nevi_No
	WHERE Adet = (SELECT MAX(Adet) FROM Sat��lar)
GO

EXEC spEn�okSat�lan

--g. 
CREATE PROC spEn�okAl��veri�Yapan
AS
	SELECT TOP 1 Ad FROM M��teriler m INNER JOIN Sat��lar s
	ON m.M��teri_No = s.M��teri_No
	GROUP BY m.Ad
	ORDER BY COUNT(*) DESC
GO

EXEC spEn�okAl��veri�Yapan