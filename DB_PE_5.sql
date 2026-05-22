-- 1
SELECT * FROM aircrafts;

--2
SELECT	aircraft_code,
	    model
FROM	aircrafts;

--3
SELECT model, range
FROM bookings.aircrafts_data
WHERE range < 5000;

--4
SELECT book_ref, passenger_id, passenger_name --сверял ошибки уже после того, как прошелся по всем пунктам. Честно говоря, тут даже не заметил, потому что машинально переписал сразу без ошибки.
FROM bookings.tickets
WHERE passenger_name LIKE 'V%'
   OR passenger_name LIKE 'E%';
   
--5
SELECT flight_no, scheduled_departure, scheduled_arrival, --после scheduled_arrival отсутствовала запятая
	   departure_airport, arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
  AND scheduled_departure between '2017-08-31' and '2017-09-01'
  
--6
SELECT flight_no, scheduled_departure, scheduled_arrival,
	   departure_airport, arrival_airport
FROM   bookings.flights
WHERE departure_airport = 'DME'
AND arrival_airport IN ('LED', 'KZN')
AND scheduled_departure between '2017-08-31' and '2017-09-01'

--7
SELECT
	flight_no,
	scheduled_departure,
	scheduled_arrival,
	actual_departure,
	actual_arrival
FROM bookings.flights
WHERE departure_airport = 'DME'
	AND actual_departure = NULL; --"равно" заменить на IS, следующий пункт намекает.
	
	
SELECT
	flight_no,
	scheduled_departure,
	scheduled_arrival,
	actual_departure,
	actual_arrival
FROM bookings.flights
WHERE departure_airport = 'DME'
	AND actual_departure IS NULL;
	
	
SELECT
	flight_no,
	scheduled_departure,
	scheduled_arrival,
	COALESCE(actual_departure, '9999-12-31'),
	COALESCE(actual_arrival, '9999-12-31')
FROM bookings.flights
WHERE departure_airport = 'DME'
	AND arrival_airport = 'KZN';
	
	
SELECT
	flight_no,
	scheduled_departure,
	scheduled_arrival,
	COALESCE(actual_departure, '9999-12-31') AS "Actual Departure",
	COALESCE(actual_arrival, '9999-12-31') "Actual Arrival" --думал тут пропущен AS, но нет, я так понял, что и верхний AS не обязателен.
FROM bookings.flights
WHERE departure_airport = 'DME'
	AND arrival_airport = 'KZN';
	
	
SELECT 
	scheduled_departure,
	flight_no,
	COALESCE(actual_departure::varchar, 'CANCELED') AS "Actual Departure"
FROM bookings.flights
WHERE departure_airport = 'DME'
	AND arrival_airport = 'KZN';
	
--8
SELECT
	scheduled_departure,
	flight_no,
	departure_airport,
	arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
ORDER BY arrival_airport;


SELECT
	scheduled_departure,
	flight_no,
	departure_airport,
	arrival_airport
FROM bookings.flights
WHERE departure_airport = 'DME'
ORDER BY arrival_airport, scheduled_departure DESC;

--9
SELECT DISTINCT
	departure_airport,
	arrival_airport
FROM bookings.flights
ORDER BY 1,2;

--10
SELECT
	scheduled_departure,
	'from ' || departure_airport::varchar || ' to '
		   || arrival_airport::varchar AS Destination,
	status
FROM bookings.flights;


SELECT
	book_ref,
	substring(passenger_name from 1 for position(' 'in passenger_name)) as Name,
	substring(passenger_name from position(' 'in passenger_name)) as Surname
FROM bookings.tickets

--11
SELECT
	AVG(amount) AS Average,
	SUM(amount) as Summary
FROM bookings.ticket_flights
WHERE fare_conditions = "Economy"; --заменить ковычки на одинарные, второй пример - подсказка.


SELECT
	COUNT(*)
FROM bookings.ticket_flights
WHERE fare_conditions = 'Economy';

--12
SELECT
	COUNT(*)
FROM bookings.flights
WHERE COALESCE(actual_arrival::date, '2017-06-12') = '2017-06-12';


SELECT
	COUNT(actual_arrival)
FROM bookings.flights
WHERE COALESCE (actual_arrival::date, '2017-06-12') = '2017-06-12';


SELECT
	COUNT(DISTINCT departure_airport)
FROM bookings.flights;

--13
SELECT
	departure_airport,
	count(actual_arrival)
FROM bookings.flights; --ERROR: column "flights.departure_airport" must appear in the GROUP BY. Убираем ; и добавлем GROUP BY departure_airport;

--14
SELECT
	departure_airport,
	count(actual_arrival)
FROM bookings.flights
GROUP BY departure_airport;

--15
SELECT
	departure_airport,
	count(actual_arrival)
FROM bookings.flights
GROUP BY departure_airport
HAVING count(actual_arrival) < 50;

--16
SELECT
	departure_airport,
	arrival_airport,
	count(actual_arrival)
FROM bookings.flights
GROUP BY ROLLUP (departure_airport, arrival_airport)
HAVING count(actual_arrival) > 300;


SELECT
	departure_airport,
	arrival_airport,
	count(actual_arrival)
FROM bookings.flights
GROUP BY CUBE (departure_airport, arrival_airport)
HAVING count(actual_arrival) > 300;
