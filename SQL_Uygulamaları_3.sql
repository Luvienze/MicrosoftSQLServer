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