--
-- MAVEN MOVIES: FINAL PROJECT
--

USE mavenmovies;

/*
1. Pull the managers’ names at each store, with the full address of each property (street address, district, city, and
country please).
*/

SELECT 
	staff.first_name AS manager_first_name,
    staff.last_name AS manager_last_name,
    address.address,
    address.district,
    city.city,
    country.country

FROM staff
	LEFT JOIN address
		ON staff.address_id = address.address_id
	LEFT JOIN city
		ON address.city_id = city.city_id
	LEFT JOIN country
		ON city.country_id = country.country_id;

/*
2. Pull together a list of each inventory item you have stocked, including the store_id number, the
inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost.
*/

SELECT 
	inventory.store_id,
	inventory.inventory_id,
    film.title,
    film.rating,
    film.rental_rate,
    film.replacement_cost

FROM inventory
	LEFT JOIN film
		ON film.film_id = inventory.film_id;
		


/*
3. From the same list of films you just pulled, please roll that data up and provide a summary level overview of
your inventory. We would like to know how many inventory items you have with each rating at each store.
*/

SELECT 
	inventory.store_id,
    film.rating,
	COUNT(inventory.inventory_id) AS total_inventory

FROM inventory
	LEFT JOIN film
		ON film.film_id = inventory.film_id
        
GROUP BY
	inventory.store_id,
    film.rating;

/*
4. Pull the number of films, as well as the average replacement cost, and total replacement cost, sliced by store and film 
category.
*/

SELECT 
	inventory.store_id,
    category.name AS film_category,
    COUNT(inventory.inventory_id) AS number_of_films,
    AVG(film.replacement_cost) AS avg_replacement,
    SUM(film.replacement_cost) AS total_replacement
    
FROM inventory
	LEFT JOIN film
		ON inventory.film_id = film.film_id
	LEFT JOIN film_category
		ON film_category.film_id = film.film_id
	LEFT JOIN category
		ON film_category.category_id = category.category_id
        
GROUP BY
	inventory.store_id,
    film_category;
    

/*
5. Pull a list of all customer names, which store they go to, whether or not they are currently active, and their full
addresses – street address, city, and country.
*/

SELECT
	customer.first_name AS customer_first_name,
    customer.last_name AS customer_last_name,
    customer.store_id,
    customer.active,
    address.address,
    city.city,
    country.country

FROM customer
	LEFT JOIN store
		ON customer.store_id = store.store_id
	LEFT JOIN address
		ON store.address_id = address.address_id
	LEFT JOIN city
		ON address.city_id = city.city_id
	LEFT JOIN country
		ON city.country_id = country.country_id;
        

/*
6. Pull together a list of customer names, their total lifetime rentals, and the sum of all payments you have collected from them. 
It would be great to see this ordered on total lifetime value, with the most valuable customers at the top of the list.
*/

SELECT 
	customer.first_name AS customer_first_name,
    customer.last_name AS customer_last_name,
    COUNT(payment.rental_id) AS total_rentals,
    SUM(payment.amount) AS total_payments
    
from customer
	LEFT JOIN payment
		ON customer.customer_id = payment.customer_id
        
GROUP BY
	customer_first_name,
    customer_last_name
    
ORDER BY
	total_payments DESC;

/*
7. Pull a list of advisor and investor names in one table? Could you please note whether they are an
investor or an advisor, and for the investors, it would be good to include which company they work with.
*/

SELECT 
	'investor' AS type,
	investor.first_name AS investor_first_name,
    investor.last_name AS investor_last_name,
    investor.company_name
FROM investor
    
UNION

SELECT 
	'advisor' AS type,    
    advisor.first_name AS advisor_first_name,
    advisor.last_name AS advisor_last_name,
    NULL
FROM advisor;
    

/*
8. Of all the actors with three types of awards, for what % of them do we carry a film? And how about for actors with two 
types of awards? Same questions. Finally, how about actors with just one award?
*/

SELECT DISTINCT awards FROM actor_award;

SELECT 
	CASE 
		WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3_awards' -- 1 space after Tony
        WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN '2_awards'
        ELSE '1_award'
    END AS number_of_awards,
    AVG(CASE WHEN actor_award.actor_id IS NULL THEN 0 ELSE 1 END) AS pct_w_one_film

FROM actor_award

GROUP BY
	CASE 
		WHEN awards = 'Emmy, Oscar, Tony ' THEN '3_awards'
        WHEN awards IN ('Emmy, Oscar' , 'Emmy, Tony' , 'Oscar, Tony') THEN '2_awards'
        ELSE '1_award'
    END;



