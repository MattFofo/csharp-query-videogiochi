-- ------ Query su singola tabella
-- 
-- ```
-- 1- Selezionare tutte le software house americane (3)
select *
from software_houses
where country = 'United States';
-- 2- Selezionare tutti i giocatori della città di 'Rogahnland' (2)
select *
from players
where city = 'Rogahnland';
-- 3- Selezionare tutti i giocatori il cui nome finisce per "a" (220)
select *
from players
where name like '%a';
-- 4- Selezionare tutte le recensioni scritte dal giocatore con ID = 800 (11)
select *
from reviews
where player_id = 800;
-- 5- Contare quanti tornei ci sono stati nell'anno 2015 (9)
select count(*) as number_of_tournaments_in_2015
from tournaments
where year = 2015;
-- 6- Selezionare tutti i premi che contengono nella descrizione la parola 'facere' (2)
select *
from awards
where description like '%facere%';
-- 7- Selezionare tutti i videogame che hanno la categoria 2 (FPS) o 6 (RPG), mostrandoli una sola volta (del videogioco vogliamo solo l'ID) (287)
select distinct videogame_id
from category_videogame
where category_id = 2 or category_id = 6;
-- 8- Selezionare tutte le recensioni con voto compreso tra 2 e 4 (2947)
select *
from reviews
where rating >= 2 and rating <= 4;
-- 9- Selezionare tutti i dati dei videogiochi rilasciati nell'anno 2020 (46)
select name, overview, release_date
from videogames
where DATEPART(year, release_date) = 2020;
-- 10- Selezionare gli id dei videogame che hanno ricevuto almeno una recensione da stelle, mostrandoli una sola volta (443)
select distinct videogame_id
from reviews
where rating = 5;
-- *********** BONUS ***********
-- 
-- 11- Selezionare il numero e la media delle recensioni per il videogioco con ID = 412 (review number = 12, avg_rating = 3)
select count(*) as number_of_reviews, AVG(rating) as average_rating
from reviews
where videogame_id = 412;
-- 12- Selezionare il numero di videogame che la software house con ID = 1 ha rilasciato nel 2018 (13)
select count(*) as n_videogames
from videogames
where DATEPART(year, release_date) = 2018 and software_house_id = 1;
-- ```
-- 
-- ------ Query con group by
-- 
-- ```
-- 1- Contare quante software house ci sono per ogni paese (3)
-- 
-- 2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
-- 
-- 3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
-- 
-- 4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
-- 
-- 5- Contare quanti videogiochi sono disponbiili per ciascun device (del device vogliamo solo l'ID) (7)
-- 
-- 6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
-- ```
-- 
-- ------ Query con join
-- 
-- ```
-- 1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
-- 
-- 2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
-- 
-- 3- Mostrare le categorie di ogni videogioco
-- SELECT v.id AS videogame_id, v.name AS videogame_name, v.release_date, c.id AS category_id, c.name AS category_name (1718)
-- 
-- 4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
-- 
-- 5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
-- 
-- 6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
-- 
-- 7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
-- 
-- 8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
-- 
-- 9- Selezionare i giocatori che hanno giocato al gioco più atteso del 2018 in un torneo del 2019 (3306)
-- 
-- *********** BONUS ***********
-- 
-- 10- Selezionare i dati della prima software house che ha rilasciato un gioco, assieme ai dati del gioco stesso (software house id : 5)
-- 
-- 11- Selezionare i dati del videogame (id, name, release_date, totale recensioni) con più recensioni (videogame id : 398)
-- 
-- 12- Selezionare la software house che ha vinto più premi tra il 2015 e il 2016 (software house id : 1)
-- 
-- 13- Selezionare le categorie dei videogame i quali hanno una media recensioni inferiore a 1.5 (10)
-- ```