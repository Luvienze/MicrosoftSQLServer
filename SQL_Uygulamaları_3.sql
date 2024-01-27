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
		check(kitap_ad� like ('%[^a-zA-Z]%')),
	Yazar_Ad� varchar(20)
		constraint ck_yazar_ad�
		check (yazar_ad� like ('%[^a-zA-Z]%')),
	Birim_Fiyat money,
	Bas�m_Y�l� date NOT NULL
		constraint ck_bas�m_y�l�
		check(bas�m_y�l� <= getDate())
		DEFAULT(getDate()),
	Kategori varchar(20)
		constraint ck_kategori
		check(kategori in ('Programlama','Grafik-Tasar�m','Networkd', 'Genel', 'Veritaban�')),
	Adet int
		constraint ck_adet
		check(adet >= 0)
)