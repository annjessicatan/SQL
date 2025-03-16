--
-- MAVEN MOVIES: ANALYZING MULTIPLE TABLES WITH JOINS
--

USE mavenmovies;

/*
ASSIGNMENT: INNER JOIN
1. Pull a list of each film we have in inventory. Pull the film’s title, description, and the store_id value
associated with each item, and its inventory_id. 
*/

SELECT 
	inventory.inventory_id,
    inventory.store_id,
    film.title,
    film.description
FROM film
	INNER JOIN inventory
		ON film.film_id = inventory.film_id;


/*
ASSIGNMENT: LEFT JOIN
2. Pull a list of all titles, and figure out how many actors are associated with each title.
*/

SELECT
	film.title,
    COUNT(film_actor.actor_id) as number_of_actors
FROM film
	LEFT JOIN film_actor
		ON film.film_id = film_Actor.film_id
GROUP BY film.title;


/*
ASSIGNMENT: "BRIDGING" TABLES
3. Pull a list of all actors, with each title that they appear in.
*/

SELECT 
	actor.first_name,
    actor.last_name,
    film.title
FROM actor
	INNER JOIN film_actor
		ON actor.actor_id = film_actor.actor_id
	INNER JOIN film
		ON film.film_id = film_actor.film_id

ORDER BY
	actor.last_name,
	actor.first_name;


/*
ASSIGNMENT: MULTI-CONDITION JOINTS
4. Pull a list of distinct titles and their descriptions, currently available in inventory at store 2.
*/

SELECT DISTINCT
	film.title,
    film.description
    
FROM film
	INNER JOIN inventory
		ON film.film_id = inventory.film_id
        -- inventory.store_id = 2 (instead of WHERE)
WHERE inventory.store_id = 2 
ORDER BY
	film.title;


/*
ASSIGNMENT: THE UNION OPERATOR
5. Pull one list of all staff and advisor names, and include a column noting whether they are a staff member or advisor.
*/

SELECT 
	'staff' AS type,
    first_name,
    last_name
FROM staff

UNION

SELECT 
	'advisor' AS type,
    first_name,
    last_name
FROM advisor;