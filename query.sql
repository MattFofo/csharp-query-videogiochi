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
select count(*) as number_of_software_houses, country 
from software_houses
group by country;
-- 2- Contare quante recensioni ha ricevuto ogni videogioco (del videogioco vogliamo solo l'ID) (500)
select count(*) as number_of_reviews, videogame_id
from reviews
group by videogame_id;
-- 3- Contare quanti videogiochi hanno ciascuna classificazione PEGI (della classificazione PEGI vogliamo solo l'ID) (13)
select count(*) as number_of_videogames, pegi_label_id
from pegi_label_videogame
group by pegi_label_id;
-- 4- Mostrare il numero di videogiochi rilasciati ogni anno (11)
select count(*) as number_of_videogames_released_each_year, DATEPART(year, release_date) as release_year
from videogames
group by DATEPART(year, release_date);
-- 5- Contare quanti videogiochi sono disponbili per ciascun device (del device vogliamo solo l'ID) (7)
select count(*) as number_of_videogames, device_id
from device_videogame
group by device_id;
-- 6- Ordinare i videogame in base alla media delle recensioni (del videogioco vogliamo solo l'ID) (500)
select videogame_id, AVG(CAST(rating as decimal (10, 2))) as average_rating
from reviews
group by videogame_id
-- ```
-- 
-- ------ Query con join
-- 
-- ```
-- 1- Selezionare i dati di tutti giocatori che hanno scritto almeno una recensione, mostrandoli una sola volta (996)
select count(*) 
from players
inner join reviews on players.id = player_id
group by player_id;
-- 2- Sezionare tutti i videogame dei tornei tenuti nel 2016, mostrandoli una sola volta (226)
select distinct videogame_id, videogames.name, tournaments.year
from tournament_videogame
inner join tournaments on tournaments.id = tournament_id
inner join videogames on videogame_id = videogames.id
where tournaments.year = 2016
-- 3- Mostrare le categorie di ogni videogioco
-- SELECT v.id AS videogame_id, v.name AS videogame_name, v.release_date, c.id AS category_id, c.name AS category_name (1718)
SELECT videogames.id AS videogame_id, videogames.name AS videogame_name, videogames.release_date, categories.id AS category_id, categories.name AS category_name
from category_videogame
inner join categories on category_id = categories.id
inner join videogames on videogame_id = videogames.id
-- 4- Selezionare i dati di tutte le software house che hanno rilasciato almeno un gioco dopo il 2020, mostrandoli una sola volta (6)
select software_houses.name
from videogames
inner join software_houses on software_houses.id = software_house_id
where DATEPART(year, release_date) > 2020
group by software_houses.name;
-- 5- Selezionare i premi ricevuti da ogni software house per i videogiochi che ha prodotto (55)
select software_houses.name, awards.name
from awards
inner join award_videogame on awards.id = award_videogame.award_id
inner join videogames on award_videogame.videogame_id = videogames.id
inner join software_houses on software_houses.id = videogames.software_house_id
order by software_houses.name;
-- 6- Selezionare categorie e classificazioni PEGI dei videogiochi che hanno ricevuto recensioni da 4 e 5 stelle, mostrandole una sola volta (3363)
select categories.name, pegi_labels.name, videogames.name
from reviews
inner join videogames on reviews.videogame_id = videogames.id
inner join pegi_label_videogame on videogames.id = pegi_label_videogame.videogame_id
inner join pegi_labels on pegi_label_videogame.pegi_label_id = pegi_labels.id
inner join category_videogame on videogames.id = category_videogame.videogame_id
inner join categories on category_videogame.category_id = categories.id
where reviews.rating = 4 or reviews.rating = 5
group by categories.name, pegi_labels.name, videogames.name;
-- 7- Selezionare quali giochi erano presenti nei tornei nei quali hanno partecipato i giocatori il cui nome inizia per 'S' (474)
select distinct videogames.name
from players
inner join player_tournament on players.id = player_tournament.player_id
inner join tournaments on player_tournament.tournament_id = tournaments.id
inner join tournament_videogame on tournaments.id = tournament_videogame.tournament_id
inner join videogames on tournament_videogame.videogame_id = videogames.id
where players.name like 'S%';
-- 8- Selezionare le città in cui è stato giocato il gioco dell'anno del 2018 (36)
select tournaments.city
from tournaments
inner join tournament_videogame on tournaments.id = tournament_videogame.tournament_id
inner join videogames on tournament_videogame.videogame_id = videogames.id
inner join award_videogame on videogames.id = award_videogame.videogame_id
inner join awards on award_videogame.award_id = awards.id
where DATEPART(year, videogames.release_date) = 2018 and awards.name = 'Gioco dell''anno';
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