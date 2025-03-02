SELECT Competitions.competition_name, Categories.category_name
FROM Competitions
JOIN Categories ON Competitions.category_id = Categories.category_id;
SELECT Categories.category_name, COUNT(Competitions.competition_id) AS competition_count
FROM Competitions
JOIN Categories ON Competitions.category_id = Categories.category_id
GROUP BY Categories.category_name;
SELECT competition_name
FROM Competitions
WHERE type = 'doubles';
SELECT competition_name
FROM Competitions
WHERE category_id = (SELECT category_id FROM Categories WHERE category_name = 'ITF Men');
SELECT parent.competition_name AS parent_competition, child.competition_name AS sub_competition
FROM Competitions AS parent
JOIN Competitions AS child ON parent.competition_id = child.parent_id;
SELECT Categories.category_name, Competitions.type, COUNT(Competitions.competition_id) AS competition_count
FROM Competitions
JOIN Categories ON Competitions.category_id = Categories.category_id
GROUP BY Categories.category_name, Competitions.type;
SELECT competition_name
FROM Competitions
WHERE parent_id IS NULL;
SELECT Venues.venue_name, Complexes.complex_name
FROM Venues
JOIN Complexes ON Venues.complex_id = Complexes.complex_id;
SELECT Complexes.complex_name, COUNT(Venues.venue_id) AS venue_count
FROM Venues
JOIN Complexes ON Venues.complex_id = Complexes.complex_id
GROUP BY Complexes.complex_name;
SELECT *
FROM Venues
WHERE country_name = 'Chile';
SELECT venue_name, timezone
FROM Venues;
SELECT Complexes.complex_name, COUNT(Venues.venue_id) AS venue_count
FROM Venues
JOIN Complexes ON Venues.complex_id = Complexes.complex_id
GROUP BY Complexes.complex_name
HAVING venue_count > 1;
SELECT country_name, GROUP_CONCAT(venue_name SEPARATOR ', ') AS venues
FROM Venues
GROUP BY country_name;
SELECT Venues.venue_name
FROM Venues
JOIN Complexes ON Venues.complex_id = Complexes.complex_id
WHERE Complexes.complex_name = 'Nacional';
SELECT Competitors.name, Competitor_Rankings.ranks, Competitor_Rankings.points
FROM Competitors
JOIN Competitor_Rankings ON Competitors.competitor_id = Competitor_Rankings.competitor_id;

SELECT Competitors.name, Competitor_Rankings.competitor_rank, Competitor_Rankings.points
FROM Competitors
JOIN Competitor_Rankings ON Competitors.competitor_id = Competitor_Rankings.competitor_id
WHERE Competitor_Rankings.competitor_rank <= 5
ORDER BY Competitor_Rankings.competitor_rank ASC;
SELECT Competitors.name, Competitor_Rankings.competitor_rank, Competitor_Rankings.points
FROM Competitors
JOIN Competitor_Rankings ON Competitors.competitor_id = Competitor_Rankings.competitor_id
WHERE Competitor_Rankings.movement = 0;
SELECT Competitors.country, SUM(Competitor_Rankings.points) AS total_points
FROM Competitors
JOIN Competitor_Rankings ON Competitors.competitor_id = Competitor_Rankings.competitor_id
WHERE Competitors.country = 'Croatia'
GROUP BY Competitors.country;
SELECT country, COUNT(*) AS num_competitors
FROM Competitors
GROUP BY country;
SELECT Competitors.name, Competitor_Rankings.points
FROM Competitors
JOIN Competitor_Rankings ON Competitors.competitor_id = Competitor_Rankings.competitor_id
ORDER BY Competitor_Rankings.points DESC
LIMIT 1;
