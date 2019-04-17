CASE WHEN DAYOFWEEK(`request_date`) = 1 THEN 'Sunday'
WHEN DAYOFWEEK(`request_date`) = 2 THEN 'Monday'
WHEN DAYOFWEEK(`request_date`) = 3 THEN 'Tuesday'
WHEN DAYOFWEEK(`request_date`) = 4 THEN 'Wednesday'
WHEN DAYOFWEEK(`request_date`) = 5 THEN 'Thursday'
WHEN DAYOFWEEK(`request_date`) = 6 THEN 'Friday'
WHEN DAYOFWEEK(`request_date`) = 7 THEN 'Saturday'
ELSE 'day' END
