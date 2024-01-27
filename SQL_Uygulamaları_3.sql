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