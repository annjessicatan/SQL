--
-- MAVEN MOVIES: MID COURSE PROJECT
--

USE mavenmovies;

/*
1. We will need a list of all staff members, including their first and last names, email addresses, and the store
identification number where they work
*/

SELECT
	first_name,
    last_name, 
	email,
    store_id
FROM staff;


/*
2. We will need separate counts of inventory items held at each of your two stores.
*/

SELECT
	store_id,
    COUNT(inventory_id) AS total_inventory_items
FROM inventory
GROUP BY store_id;


/*
3. We will need a count of active customers for each of your stores. Separately, please.
*/

SELECT 
	store_id,
    COUNT(customer_id) AS total_active_customers
FROM customer
WHERE active = 1
GROUP BY store_id;


/*
4. In order to assess the liability of a data breach, we will need you to provide a count of all customer email
addresses stored in the database
*/

SELECT 
	COUNT(email) AS total_customer_email
FROM customer;

/*
5. Provide a count of unique film titles you have in inventory at each store and then provide a count of the unique 
categories of films you provide.
*/

SELECT
	store_id,
    COUNT(DISTINCT film_id) AS total_unique_titles
FROM inventory
GROUP BY store_id;

SELECT 
	COUNT(DISTINCT name) AS total_categories
FROM category;


/*
6. Provide the replacement cost for the film that is least expensive to replace, the most expensive to replace, 
and the average of all films you carry.
*/

SELECT 
	MIN(replacement_cost) AS cheapest_replacement,
    MAX(replacement_cost) AS most_expensive_replacement,
	AVG(replacement_cost) AS avg_replacement
FROM film;


/*
7. Provide the average payment you process, as well as the maximum payment you have processed.
*/

SELECT 
	AVG(amount) AS avg_pay,
    MAX(amount) AS max_pay
FROM payment;


/*
8. Provide a list of all customer identification values, with a count of rentals they have made all-time, 
with your highest volume customers at the top of the list
*/

SELECT * FROM rental;

SELECT 
	customer_id, 
    COUNT(rental_id) AS total_rentals
FROM rental
GROUP BY 
	customer_id
ORDER BY 
	total_rentals DESC;