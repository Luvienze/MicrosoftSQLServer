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
		check(kategori in ('Programlama','Grafik-Tasarým','Networkd', 'Genel', 'Veritabaný')),
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
-- /////////// INSERTLER ///////////

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