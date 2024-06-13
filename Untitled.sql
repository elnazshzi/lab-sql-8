-- 1. Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title,length, rank() over(order by length desc) as length_rank
 from sakila.film
 where length  is not null and  length > 0;
 
 
 
 -- 2. Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). 
 -- In your output, only select the columns title, length, rating and rank.
 
 select 
 title,
 length,
 rating,
 rank() over ( partition by rating order by length desc ) as ranking
 from sakila.film
  where length  is not null and  length > 0;
  
  
  
  -- 3. How many films are there for each of the categories in the category table? 
  -- Hint: Use appropriate join between the tables "category" and "film_category".
  
  select c.name, count(fc.film_id) as total_films
  from sakila.category c 
  join sakila.film_category fc using(category_id)
  group by c.name
  order by count(fc.film_id) desc;
  
  

  
  -- 4. Which actor has appeared in the most films? 
  -- Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.
  
  select a.first_name, last_name, count(fa.film_id) film_numbers
  from sakila.actor a
  join sakila.film_actor fa using (actor_id)
  group by a.first_name, last_name
  order by film_numbers desc
  limit 1;
  
  
  
  -- 5. Which is the most active customer (the customer that has rented the most number of films)? 
  -- Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select c.first_name, last_name, count(r.rental_id) as rental_count
from sakila.customer c 
join sakila.rental r using (customer_id)
group by c.first_name, last_name
order by rental_count
limit 1;



-- bonus.  Which is the most rented film?

select f.title, count(r.rental_id) as num_rented_film
from sakila.film f
join sakila.inventory i using(film_id)
join sakila.rental r using(inventory_id)
group by f. title
order by num_rented_film desc
limit 1;

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  