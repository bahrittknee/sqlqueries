TIME_FORMAT((CASE 
WHEN HOUR(`request_date`) = 0 THEN '0:00'
WHEN HOUR(`request_date`) = 1 THEN '1:00'
WHEN HOUR(`request_date`) = 2 THEN '2:00'
WHEN HOUR(`request_date`) = 3 THEN '3:00'
WHEN HOUR(`request_date`) = 4 THEN '4:00'
WHEN HOUR(`request_date`) = 5 THEN '5:00'
WHEN HOUR(`request_date`) = 6 THEN '6:00'
WHEN HOUR(`request_date`) = 7 THEN '7:00'
WHEN HOUR(`request_date`) = 8 THEN '8:00'
WHEN HOUR(`request_date`) = 9 THEN '9:00'
WHEN HOUR(`request_date`) = 10 THEN '10:00'
WHEN HOUR(`request_date`) = 11 THEN '11:00'
WHEN HOUR(`request_date`) = 12 THEN '12:00'
WHEN HOUR(`request_date`) = 13 THEN '13:00'
WHEN HOUR(`request_date`) = 14 THEN '14:00'
WHEN HOUR(`request_date`) = 15 THEN '15:00'
WHEN HOUR(`request_date`) = 16 THEN '16:00'
WHEN HOUR(`request_date`) = 17 THEN '17:00'
WHEN HOUR(`request_date`) = 18 THEN '18:00'
WHEN HOUR(`request_date`) = 19 THEN '19:00'
WHEN HOUR(`request_date`) = 20 THEN '20:00'
WHEN HOUR(`request_date`) = 21 THEN '21:00'
WHEN HOUR(`request_date`) = 22 THEN '22:00'
WHEN HOUR(`request_date`) = 23 THEN '23:00'
ELSE 0 END), '%H:%i')