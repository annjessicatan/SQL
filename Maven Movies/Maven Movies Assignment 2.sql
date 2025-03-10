--
-- MAVEN MOVIES: SINGLE TABLE ANALYSIS (PART 2)
--

USE mavenmovies;

/*
1. ASSIGNMENT: THE CASE STATEMENT
"Pull a list of first and last names of all customers, and label them as either ‘store 1 active’, ‘store 1 inactive’, ‘store 2 active’, or ‘store 2 inactive’.”
*/

SELECT
	first_name,
    last_name,
    CASE 
		WHEN store_id = 1 AND active = 1 THEN 'store 1 active'
        WHEN store_id = 1 AND active = 0 THEN 'store 1 inactive'
        WHEN store_id = 2 AND active = 1 THEN 'store 2 active'
        WHEN store_id = 2 AND active = 0 THEN 'store 2 inactive'
        ELSE 'uh-oh... Check again'
	END AS store_and_status

FROM customer;


/*
2. ASSIGNMENT: COUNT & CASE
"Create a table to count the number of customers broken down by store_id (in rows), and active status (in columns).”
*/

SELECT
	store_id,
    COUNT(CASE WHEN active = 1 THEN customer_id ELSE NULL END) AS active,
    COUNT(CASE WHEN active = 0 THEN customer_id ELSE NULL END) AS inactive
FROM customer
GROUP BY 
	store_id;