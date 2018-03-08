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
