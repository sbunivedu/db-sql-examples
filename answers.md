1.
```
SELECT name
FROM Beers
WHERE manf = 'Anheuser-Busch';
```
2.
```
SELECT price
FROM Sells
WHERE bar = 'Joe''s Bar' AND beer = 'Bud';
```
3.
```
SELECT name
FROM Drinkers
WHERE phone LIKE '%555-_ _ _ _';
```
4.
```
SELECT beer
FROM LIKES
WHERE drinker IN
  (SELECT drinker
   FROM Frequents
   WHERE bar = 'Joe''s Bar');

SELECT beer
FROM Likes, Frequents
WHERE bar = 'Joe''s Bar' AND Frequents.drinker = Likes.drinker;
```
5.
```
SELECT b1.name,b2.name
FROM Beers b1, Beers b2
WHERE b1.manf = b2.manf AND b1.name < b2.name;
```
6.
```
SELECT bar
FROM Sells
WHERE beer = 'Miller' AND price =
  (SELECT price
   FROM Sells
   WHERE bar = 'Joe''s Bar' AND beer = 'Bud');
```
7.
```
SELECT name, manf
FROM Likes, Beers
WHERE beer = name AND drinker = 'Fred';

SELECT name, manf
FROM Beers
WHERE name IN
  (SELECT beer
   FROM Likes
   WHERE drinker = 'Fred');
```
8.
```
SELECT name
FROM Beers B
WHERE NOT EXISTS
  (SELECT *
   FROM Beers
   WHERE B.name <> name AND B.manf = manf);
```
9.
```
(SELECT drinker, beer
 FROM Likes)
INTERSET
(SELECT drinker, beer
 FROM Frequents F, Sells S
 WHERE F.bar = S.bar);
```
10.
```
SELECT DISTINCT price
FROM Sells;
```
11.
```
SELECT AVG(price)
FROM Sells
WHERE beer = 'Bud';
```
12.
```
SELECT COUNT(DISTINCT price)
FROM Sells
WHERE beer = 'Bud';
```
13.
```
SELECT COUNT(*)
FROM Sells
WHERE beer = 'Bud';
```
14.
```
SELECT COUNT(price)
FROM Sells
WHERE beer = 'Bud';
```
15.
```
SELECT beer, AVG(price)
FROM Sells
GROUP BY beer;
```
16.
```
SELECT drinker, AVG(price)
FROM Sells S, Frequents F
WHERE S.bar = F.bar AND beer = 'Bud'
GROUP BY drinker;
```
17.
```
SELECT bar
FROM Sells
WHERE price =
  (SELECT MIN(price)
   FROM Sells
   WHERE beer = 'Bud') AND beer = 'Bud';
```
18.
```
SELECT beer, avg(price)
FROM Sells S, Beers B
WHERE S.beer = B.name AND
  ((SELECT count(*)
    FROM Sells
    WHERE beer = B.name) > 2) OR B.manf = 'Pete''s')
GROUP BY beer;

SELECT beer, AVG(price)
FROM Sells
GROUP BY beer
HAVING COUNT(bar) > 2 OR beer IN
(SELECT name
 FROM Beers
 WHERE manf = 'Pete''s');
```
19.
```
SELECT name, nickname
FROM Kings
WHERE beginReign <= 1000 AND endReign >= 1000;
```
20.
```
SELECT p1.child, p3.parent
FROM Parents p1, Parents p2, Parents p3
WHERE p1.parent = p2.child AND p2.parent = p3.child;
```
21.
```
SELECT name, nickname
FROM Kings
WHERE nickname NOT LIKE 'The%';
```
22.
```
SELECT parent
FROM Parents
GROUP BY parent
HAVING COUNT(*) > 1;
```
23.
```
SELECT house, COUNT(*)
FROM Kings
GROUP BY house;
```
24.
```
SELECT k1.name, k2.name
FROM Kings k1, Kings k2
WHERE (k1.beginReign < k2.beginReign AND k1.endReign > k2.beginReign)
OR (k2.beginReign < k1.beginReign AND k1.endReign < k2.endReign);
```
25.
```

SELECT *
FROM Movie
WHERE studioName = 'Disney' AND year = 1990;
```
26.
```
SELECT title
FROM Movie
WHERE year > 1970 AND NOT inColor;
```
27.
```
SELECT title
FROM Movie
WHERE (year > 1970 OR length < 90) AND studioName = 'MGM';
```
28.
```
SELECT title
FROM Movie
WHERE title LIKE 'Star____';
```
29.
```
SELECT title
FROM Movie
WHERE title LIKE '%''s%';
```
30.
```
SELECT starName
FROM Movie
WHERE movieYear = 1980 OR moiveTitle LIKE "%Love%";
```
31.
```
SELECT name
FROM Movie, MovieExec
WHERE title = 'Star Wars' AND producerC# = cert#;
```
32.
```
SELECT MovieStar.name, MovieExec.name
FROM MovieStar, MovieExec
WHERE MovieStar.address = MoiveExec.address;
```
33.
```
SELECT Star1.name, Star2.name
FROM MovieStar AS Star1, MovieStar AS Star2
WHERE Star1.address = Star2.address AND Star1.name < Star2.name;
```
34.
```
(SELECT name, address
 FROM MovieStar
 WHERE gender = 'F')
INTERSECT
(SELECT name, address
 FROM MovieExec
 WHERE netWorth > 10000000);
```
35.
```
FROM Movie, StarsIn, MovieStar
WHERE title = movieTitle AND starName = name
AND gender = 'male' AND title = 'Terms of Endearment';
```
36.
```
SELECT title
FROM Moive
WHERE length > (SELECT length FROM Movie WHERE title = 'Gone With the Wind');
```
37.
```
SELECT name
FROM MovieExec
WHERE cert# IN
  (SELECT producerC#
   FROM Movie
   WHERE (title, year) IN
     (SELECT movieTitle, movieYear
      FROM StarsIn
      WHERE starName = 'Harrison Ford'
     )
   );

SElECT name
FROM MovieExec, Movie, StarsIn
WHERE cert# = producerC#
AND title = movieTitle
AND year = movieYear
AND starName = 'Harrison Ford';
```
38.
```
SELECT title
FROM Movie AS Old
WHERE year < ANY
  (SElECT year
   FROM Movie
   WHERE title = Old.title
  );

SELECT title
FROM Movie
GROUP BY title
HAVING count(*) > 1;
```
39.
```
SELECT AVG(netWorth)
FROM MovieExec;
```
40.
```
SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName;
```
41.
```
SELECT name, SUM(length)
FROM MovieExec, Movie
WHERE producerC# = cert#
GROUP BY name;
```
42.
```
SELECT name, SUM(length)
FROM MovieExec, Movie
WHERE producerC# = cert#
GROUP BY name
HAVING MIN(year) < 1930;
```
