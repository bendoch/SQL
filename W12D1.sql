use sakila;
select *
from customer;

-- Scoprite quanti clienti si sono registrati nel 2006.
select count(*)
from customer
where year(create_date)='2006';


-- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.
select count(*)
from rental
where rental_date='2006-01-01';


-- Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati.
select f.title
       , c.first_name
       , c.last_name
       , r.rental_date
from rental as r
join customer as c
    on c.customer_id=r.customer_id
join inventory as i
    on i.inventory_id=r.inventory_id
join film as f
    on f.film_id=i.film_id
where r.rental_date between 
                    (select max(rental_date) - interval 7 day from rental) and 
                    (select max(rental_date) from rental)
order by r.rental_date desc;


-- Calcolate la durata media del noleggio per ogni categoria di film
select avg(datediff(return_date,rental_date)) as average_rental_duration
       , c.name as category_name
from rental as r
join inventory as i
    on r.inventory_id=i.inventory_id
join film_category as fc
    on fc.film_id=i.film_id
join category as c
    on c.category_id=fc.category_id
group by c.name;


-- Trovate la durata del noleggio più lungo.
select datediff(return_date,rental_date) as rental_duration
       , f.title 
       , r.customer_id
       , r.rental_id
from rental as r
join inventory as i
    on i.inventory_id=r.inventory_id
join film as f
    on f.film_id=i.film_id
where return_date is not null
    and datediff(return_date,rental_date)=(select max(datediff(return_date,rental_date)) from rental where return_date is not null) ;


-- Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006
select c.first_name
       , c.last_name
from customer as c
left join rental as r
    on r.customer_id=c.customer_id
       and r.rental_date between '2006-01-01' and '2006-31-01'
where r.rental_id is null;


-- Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005
-- Modificato in seconda metà del 2005
select f.title
       ,count(f.title) as times_rented
       , r.rental_date
from film as f
join inventory as i
    on f.film_id=i.film_id
join rental as r
	on r.inventory_id=i.inventory_id
where r.rental_date between '2005-07-01' and '2005-12-31'
group by f.title
having count(f.title) > 10
order by r.rental_date desc;


-- Trovate il numero totale di noleggi effettuati il giorno 1/1/2006
select count(*)
from rental
where rental_date='2006-01-01';


-- Calcolate la somma degli incassi generati nei weekend (sabato e domenica)
select sum(p.amount)
from payment as p
where dayofweek(p.payment_date) between 6 and 7;


-- Individuate il cliente che ha speso di più in noleggi
select sum(p.amount) as total_spent
       , c.first_name
       , c.last_name
from payment as p
join customer as c
    on p.customer_id=c.customer_id
group by p.customer_id
order by total_spent desc
limit 1;


-- Elencate i 5 film con la maggior durata media di noleggio
select f.title
       , avg(datediff(r.return_date,r.rental_date)) as average_rental_duration
from film as f
join inventory as i
    on f.film_id=i.film_id
join rental as r
	on r.inventory_id=i.inventory_id
group by f.film_id
order by average_rental_duration desc
limit 5;

-- Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente.
select customer_id
	   , rental_date
       , return_date
from rental
order by customer_id, rental_date desc;



-- Individuate il numero di noleggi per ogni mese del 2005
select month(rental_date) as month
       , count(*) as total_rentals
from rental
where year(rental_date) = '2005'
group by month;


-- Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno
select f.title
       , r.rental_date
from film as f
join inventory as i
    on f.film_id=i.film_id
join rental as r
	on r.inventory_id=i.inventory_id
group by f.title, day(r.rental_date)
having count(*)>=2
order by r.rental_date;

-- Calcolate il tempo medio di noleggio
select avg(datediff(return_date,rental_date)) as average_rental_duration
from rental;