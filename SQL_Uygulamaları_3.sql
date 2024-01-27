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
		check(kitap_adý like ('%[^a-zA-Z]%')),
	Yazar_Adý varchar(20)
		constraint ck_yazar_adý
		check (yazar_adý like ('%[^a-zA-Z]%')),
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
		check(ad like '%[^a-zA-Z]%'),
	Soyad varchar(20)
		constraint ck_soyad
		check(soyad like '%[^a-zA-Z]%'),
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