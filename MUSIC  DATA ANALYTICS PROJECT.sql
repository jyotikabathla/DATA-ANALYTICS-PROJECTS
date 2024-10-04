use music_world;

select* from album3;

/*1.	Who is the senior most employee based on job title? */
select * from employee
ORDER BY levels desc
limit 1;

/*2.	Which countries have the most Invoices? */
select count(*) as c, billing_country
 from invoice
 group by billing_country
 order by c desc;
 /*3.	What are top 3 values of total invoice?*/  
 select total from invoice
 order by total desc
 limit 3;
 /*4.	Which city has the best customers? We would like to 
 throw a promotional Music Festival in the city we made the
 most money. Write a query that returns one city that has 
 the highest sum of invoice totals.
 Return both the city name & sum of all invoice totals  */
 
 select SUM(total) as invoice_total, billing_city
 from invoice
 group by billing_city
 order by invoice_total desc;
/*5.	Who is the best customer? 

The customer who has spent the most money will be declared
 the best customer. Write a query that returns the
 person who has spent the most money*/ 
 SELECT 
    customer.customer_id, 
    first_name, 
    last_name,
    SUM(total) AS total_spending 
FROM 
    customer
JOIN 
    invoice ON customer.customer_id = invoice.customer_id
GROUP BY 
    customer.customer_id, 
    first_name, 
    last_name
ORDER BY 
    total_spending DESC
LIMIT 1;
/*5.	Who is the best customer? The customer who has spent the
 most money will be declared the best customer. 
 Write a query that returns the person
 who has spent the most money */
 SELECT distinct email as EMAIL,first_name as FIRST_NAME,last_name
 from customer
 join invoice on invoice.customer_id= customer.customer_id
 join invoice_line on invoice_line.invoice_id= invoice.invoice_id
 join track on track.track_id= invoice_line.track_id
 join genre on genre.genre_id= track.genre_id
 
 where genre.name like 'rock'
 
 order by email;
 
 
 /*.7 Let's invite the artists who have written 
 the most rock music in our dataset. Write a query 
 that returns the Artist name and total 
 
 track count of the top 10 rock bands */
 
 SELECT 
    artist.artist_id, 
    artist.name, 
    COUNT(track.track_id) AS number_of_songs
FROM 
    track
JOIN 
    album3 ON album3.album_id = track.album_id
JOIN 
    artist ON artist.artist_id = album3.artist_id
JOIN 
    genre ON genre.genre_id = track.genre_id
WHERE 
    genre.name = 'Rock'
GROUP BY 
    artist.artist_id, 
    artist.name
ORDER BY 
    number_of_songs DESC
LIMIT 10;

SELECT 
    artist.artist_id, 
    artist.name, 
    COUNT(track.track_id) AS number_of_songs
FROM 
    track
JOIN 
    album3 ON album3.album_id = track.album_id
JOIN 
    artist ON artist.artist_id = album3.artist_id
JOIN 
    genre ON genre.genre_id = track.genre_id
WHERE 
    genre.name = 'Rock'
GROUP BY 
    artist.artist_id, 
    artist.name
ORDER BY 
    number_of_songs DESC
LIMIT 10;
SELECT 
    artist.artist_id, 
    artist.name, 
    COUNT(track.track_id) AS number_of_songs
FROM 
    track
JOIN 
    album3 ON album3.album_id = track.album_id
JOIN 
    artist ON artist.artist_id = album3.artist_id
JOIN 
    genre ON genre.genre_id = track.genre_id
WHERE 
    genre.name = 'Rock'
GROUP BY 
    artist.artist_id, 
    artist.name
ORDER BY 
    number_of_songs DESC
LIMIT 10;

/*8.Find how much amount spent by each customer on artists? Write a query to return customer name,
 artist name and total spent*/
 WITH best_selling_artist AS (
    SELECT 
        artist.artist_id AS artist_id, 
        artist.name AS artist_name, 
        SUM(invoice_line.unit_price * invoice_line.quantity) AS total_sales
    FROM 
        invoice_line
    JOIN 
        track ON track.track_id = invoice_line.track_id
    JOIN 
        album3 ON album3.album_id = track.album_id
    JOIN 
        artist ON artist.artist_id = album3.artist_id
    GROUP BY 
        artist.artist_id, artist.name
    ORDER BY 
        total_sales DESC
    LIMIT 1
)
SELECT 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    bsa.artist_name, 
    SUM(il.unit_price * il.quantity) AS amount_spent
FROM 
    invoice i
JOIN 
    customer c ON c.customer_id = i.customer_id
JOIN 
    invoice_line il ON il.invoice_id = i.invoice_id
JOIN 
    track t ON t.track_id = il.track_id
JOIN 
    album3 alb ON alb.album_id = t.album_id
JOIN 
    best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 
    c.customer_id, 
    c.first_name, 
    c.last_name, 
    bsa.artist_name
ORDER BY 
    amount_spent DESC;
     /*9.*We want to find out the most popular music Genre for each country. We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns each country along with the top Genre. For countries where the maximum number of purchases
    is shared return all Genres */
    WITH popular_genre AS 
(
    SELECT COUNT(invoice_line.quantity) AS purchases, customer.country, genre.name, genre.genre_id, 
	ROW_NUMBER() OVER(PARTITION BY customer.country ORDER BY COUNT(invoice_line.quantity) DESC) AS RowNo 
    FROM invoice_line 
	JOIN invoice ON invoice.invoice_id = invoice_line.invoice_id
	JOIN customer ON customer.customer_id = invoice.customer_id
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN genre ON genre.genre_id = track.genre_id
	GROUP BY 2,3,4
	ORDER BY 2 ASC, 1 DESC
)
SELECT * FROM popular_genre WHERE RowNo <= 1;