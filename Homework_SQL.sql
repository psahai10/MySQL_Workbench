SELECT * FROM sakila.country;
USE sakila;

SELECT first_name, last_name
FROM actor;

SELECT UPPER(CONCAT(first_name, " ", last_name)) AS 'Actor Name'
FROM actor;

SELECT actor_id
FROM actor
WHERE first_name = 'Joe';

SELECT * FROM actor 
WHERE last_name like '%G%'
AND last_name like '%E%'
AND last_name like '%N%';

SELECT * FROM actor 
WHERE last_name like '%L%'
AND last_name like '%I%'
ORDER BY last_name, first_name;

SELECT country_id, country
FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

ALTER TABLE actor
ADD COLUMN description BLOB;

ALTER TABLE actor
DROP COLUMN description;

SELECT last_name, COUNT(*)
FROM actor
GROUP BY last_name
HAVING COUNT(*) > 1;

UPDATE actor 
SET first_name = 'HARPO'
WHERE last_name = 'WILLIAMS' AND first_name = 'GROUCHO';

UPDATE actor 
SET first_name = 'GROUCHO'
WHERE first_name = 'HARPO';

SHOW CREATE TABLE address

SELECT * FROM staff
SELECT * FROM address

SELECT first_name, last_name, address
FROM staff
INNER JOIN address ON staff.address_id = address.address_id;

SELECT SUM(payment.amount), payment.staff_id
FROM payment
JOIN staff
ON payment.staff_id = staff.staff_id
WHERE payment_date LIKE '%2005-05%'
GROUP BY staff_id;

SELECT film.title, COUNT(film_actor.actor_id) AS 'Number of actors listed'
FROM film
JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY title;


SELECT film.title, COUNT(inventory.film_id) AS 'Number of copies'
FROM film
JOIN inventory ON film.film_id = inventory.film_id
WHERE title = 'Hunchback Impossible';

SELECT customer.first_name, customer.last_name, SUM(payment.amount) AS 'Total Amount Paid'
FROM payment
JOIN customer ON payment.customer_id = customer.customer_id
GROUP BY customer.last_name ORDER BY customer.last_name;

SELECT title
FROM film
WHERE title like 'K%'
OR title like 'Q%'
AND language_id = 1;

SELECT first_name, last_name
FROM actor
WHERE actor_id IN (
	SELECT actor_id
	from film_actor
	WHERE film_id IN (
		SELECT film_id
		FROM film
		WHERE title = 'ALONE TRIP'
));

SELECT customer.first_name, customer.last_name, customer.email, address.address
FROM customer
JOIN address ON customer.address_id = address.address_id
WHERE store_id = 1;

SELECT title AS 'Family films'
from film
WHERE rating = 'G';

SELECT film.title, COUNT(rental.inventory_id) AS 'Number of rentals'
FROM film
JOIN inventory ON film.film_id = inventory.film_id 
JOIN rental ON  inventory.inventory_id = rental.inventory_id
GROUP BY film.title
ORDER BY COUNT(rental.inventory_id) DESC;

SELECT customer.store_id, SUM(payment.amount) AS 'Total Money in $'
FROM customer
JOIN rental ON customer.customer_id = rental.customer_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY customer.store_id;


SELECT store.store_id, city.city, country.country
FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id;

SELECT category.name AS 'Genres', SUM(payment.amount) AS 'Gross Revenue in $'
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name ORDER BY SUM(payment.amount) DESC LIMIT 5;

CREATE VIEW top_five_genres
AS SELECT category.name AS 'Genres', SUM(payment.amount) AS 'Gross Revenue in $'
FROM payment
JOIN rental ON payment.rental_id = rental.rental_id
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film_category ON inventory.film_id = film_category.film_id
JOIN category ON film_category.category_id = category.category_id
GROUP BY category.name ORDER BY SUM(payment.amount) DESC LIMIT 5;

SELECT * FROM top_five_genres;

DROP VIEW IF EXISTS top_five_genres;