--
-- MAVEN MOVIES: SINGLE TABLE ANALYSIS (PART 1)
--

USE mavenmovies;

/*
1. ASSIGNMENT: SELECT & FROM
"Pull a list of the first name, last name, and email of each of our customers?”
*/

SELECT
	first_name,
    last_name,
    email
FROM customer;


/*
2. ASSIGNMENT: SELECT DISTINCT
“Pull the records of our films and see if there are any other rental durations?”
*/

SELECT DISTINCT rental_duration
FROM film;


/*
3. ASSIGNMENT: THE WHERE CLAUSE
“Pull all payments from our first 100 customers (based on customer ID)?”
*/

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment
WHERE customer_id BETWEEN 1 AND 100; -- WHERE customer_id <= 100; WHERE customer_id < 101;


/*
4. ASSIGNMENT: WHERE & AND
“Pull payments over $5 for those same customers, since January 1, 2006.”
*/

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment

WHERE customer_id <= 100
	AND amount > 5
	AND payment_date >= '2006-01-01';
    

/*
5. ASSIGNMENT: COMBINING WHERE & OR
“Write a query to pull all payments from those specific customers, along with payments over $5, from any customer?”
*/

SELECT 
	customer_id,
    rental_id,
    amount,
    payment_date
FROM payment

WHERE customer_id = 42    
	OR customer_id = 53
    OR customer_id = 60
    OR customer_id = 75    -- OR customer_id IN (42, 53, 60, 75)
	OR amount > 5;


/*
6. ASSIGNMENT: THE LIKE OPERATOR
“Pull a list of films which include a Behind the Scenes special feature?”
*/

SELECT
	title,
    special_features
FROM film
WHERE special_features LIKE '%Behind the Scenes%';


/*
7. ASSIGNMENT: GROUP BY
“Pull a count of titles sliced by rental duration?”
*/

SELECT * FROM film;

SELECT 
	rental_duration,
    COUNT(title) AS film_total_rental_duration
FROM film
GROUP BY rental_duration;


/*
8. ASSIGNMENT: AGGREGATION FUNCTIONS
“Pull a count of films, along with the average, min, and max rental rate, grouped by replacement cost?”
*/

SELECT * FROM film;

SELECT 
	replacement_cost,
    COUNT(film_id) AS number_of_films,
    MIN(rental_rate) AS cheapest_rental_rate,
    MAX(rental_rate) AS most_expensive_rental_rate,
    AVG(rental_rate) AS average_rental_rate
FROM film
GROUP BY 
	replacement_cost;


/*
9. ASSIGNMENT: THE HAVING CLAUSE
“Pull a list of
customer_ids with less than 15 rentals all-time?”
*/

SELECT * FROM rental;

SELECT
	customer_id,
    COUNT(*) AS total_rental
FROM rental
GROUP BY
	customer_id
HAVING COUNT(*) < 15;


/*
10. ASSIGNMENT: THE ORDER BY CLAUSE
“Pull me a list of all film titles along with their lengths and rental rates, 
and sort them from longest to shortest?”
*/

SELECT
	title, 
    length AS film_duration,
    rental_rate
FROM film
ORDER BY 
	film_duration DESC;
