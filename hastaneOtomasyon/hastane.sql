ALTER PROC HastaneInsert
(
@randevualanhasta int,
@randevuverendokor int,
@randevubolum int
)
AS
BEGIN
INSERT INTO Randevu (RandevuAlanHasta,RandevuVerenDoktor,RandevuBolum) 
VALUES (@randevualanhasta,@randevuverendokor,@randevubolum)
END

EXEC HastaneInsert 10,2,2

CREATE PROC DeleteRandevu
(
@Randevuid int
)
AS
BEGIN
DELETE 
FROM Randevu
WHERE RandevuID = @Randevuid
PRINT 'Randevu basarili bir sekilde silindi ' + CONVERT (VARCHAR(50),@Randevuid) + ' numarali urun silinmistir.' 
SELECT * FROM Randevu
END

EXEC DeleteRandevu 19

ALTER PROC UpdateRandevu
@randevuid int,
@randevualanhasta int
AS
BEGIN
UPDATE Randevu
SET RandevuAlanHasta = @randevualanhasta
WHERE RandevuID = @randevuid
PRINT 'Ürün Güncelleme Ýþlemi Baþarili' + @randevualanhasta +' Ranvesunu aldi'
SELECT * FROM Randevu
END

EXEC UpdateRandevu 16,5

ALTER VIEW view_DoktorRandevuSayisi
as
SELECT COUNT(RandevuVerenDoktor) as [Doktorun Verdiði Randevu Sayisi] , D.DoktorAdi
FROM Randevu
JOIN Doktorlar AS D
ON Randevu.RandevuVerenDoktor=D.DoktorID
GROUP BY DoktorAdi

select * from view_DoktorRandevuSayisi

alter TRIGGER Trigger_ekle
on Randevu
AFTER INSERT AS 
BEGIN
declare @randevuid int
SELECT @randevuid=RandevuID from inserted
update Randevu set RandevuVerenDoktor=RandevuVerenDoktor+@randevuid where @randevuid=RandevuVerenDoktor
end

INSERT INTO Randevu (RandevuVerenDoktor,RandevuAlanHasta,RandevuBolum) VALUES(9,8,7)

ALTER TRIGGER Trigger_ilacazalt
on Receteler
AFTER INSERT AS 
BEGIN
declare @ilacid int
SELECT @ilacid=IlaclarID from inserted
update Ilaclar set TotalIlacSayisi=TotalIlacSayisi-1 where @ilacid=IlaclarID
end

INSERT INTO Ilaclar (IlacTedarikci,ÝlacAdi) VALUES(3,'Fucidin')