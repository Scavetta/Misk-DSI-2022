SELECT *
FROM flights
WHERE tailnum IN ('N652AW', 'N370NB');


SELECT *
FROM flights
WHERE (tailnum IN ('N652AW', 'N370NB') AND dep_delay > 10);

SELECT DISTINCT tailnum FROM flights;

SELECT * 
FROM flights
GROUP BY "month"
HAVING (tailnum IN ('N652AW', 'N370NB'));


SELECT * 
FROM flights
WHERE (tailnum IN ('N652AW', 'N370NB'));

-- 37 delayed N370NB
SELECT tailnum, dep_delay
FROM flights
WHERE  (tailnum IN ('N370NB') AND dep_delay > 10);

-- 18 delayed N370NB
SELECT tailnum, dep_delay
FROM flights
WHERE  (tailnum IN ('N652AW') AND dep_delay > 10);


-- 55 delayed for both
SELECT tailnum, dep_delay
FROM flights
WHERE (tailnum IN ('N652AW', 'N370NB') AND dep_delay > 10);

--  delayed for both
SELECT tailnum, flight, dep_delay, COUNT(tailnum)
FROM flights
GROUP BY flight 
HAVING (tailnum IN ('N652AW', 'N370NB') AND dep_delay > 10);


--  delayed for both
SELECT tailnum, flight, COUNT(tailnum), SUM(dep_delay)
FROM flights
GROUP BY flight 
HAVING (tailnum IN ('N652AW', 'N370NB') AND dep_delay > 0);

SELECT tailnum, flight, SUM(dep_delay) / COUNT(flight) avg_delay
FROM flights
GROUP BY flight 
HAVING (tailnum IN ('N652AW', 'N370NB') AND dep_delay > 0)
ORDER BY avg_delay DESC;


SELECT flight, dep_delay 
FROM flights
where flight = 604;


SELECT flight, COUNT(flight)
FROM flights
GROUP BY flight;

SELECT tailnum, flight , COUNT(flight) n
FROM flights
GROUP BY tailnum, flight
ORDER BY n DESC;

SELECT tailnum, flight
FROM flights
GROUP BY tailnum, flight;


SELECT tailnum, flight, COUNT(flight) n
FROM flights
GROUP BY tailnum, flight
HAVING (tailnum IN ('N652AW', 'N370NB') AND dep_delay > 0);




SELECT *
FROM flights
INNER JOIN airports;


