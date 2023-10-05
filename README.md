# SQL Calisthenics

This set of SQL practice questions are from our lectures and our textbook. Try solving them yourself before looking at the answers.

## Beers
Consider the following schema:
* Beers (name, manf): the beer with the name is made by the manf.
* Bars (name, addr, license): the bar with the name and at the addr has the
  license number.
* Drinkers (name, addr, phone): the drinker with the name lives at the addr with
  the phone number.
* Likes (drinker, beer): the drinker likes the beer.
* Sells (bar, beer, price): the bar sells the beer for the price.
* Frequents (drinker, bar): the drinker frequents the bar.

1. What beers are made by Anheuser-Busch?
<details>
<summary>answer</summary>

```sql
SELECT name
FROM Beers
WHERE manf = 'Anheuser-Busch';
```
</details>

2. What is the price Joe’s Bar charges for Bud?
<details>
<summary>answer</summary>

```sql
SELECT price
FROM Sells
WHERE bar = 'Joe''s Bar' AND beer = 'Bud';
```
</details>

3. Find drinkers who have a phone number that has '555' followed by 4 more digits.
<details>
<summary>answer</summary>

```sql
SELECT name
FROM Drinkers
WHERE phone LIKE '%555-____';
```
</details>

4. Find the beers liked by at least one person who frequents Joe's Bar.
<details>
<summary>answer</summary>

```sql
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
</details>

5. Find all pairs of beers by the same manufacturer.
    * Do not produce pairs like (Bud, Bud).
    * Produce pairs in alphabetic order, e.g. (Bud, Miller), not (Miller, Bud).
<details>
<summary>answer</summary>

```sql
SELECT b1.name,b2.name
FROM Beers b1, Beers b2
WHERE b1.manf = b2.manf AND b1.name < b2.name;
```
</details>

6. Find the bars that serve 'Miller' for the same price 'Joe' charges for 'Bud'.
<details>
<summary>answer</summary>

```sql
SELECT bar
FROM Sells
WHERE beer = 'Miller' AND price =
  (SELECT price
   FROM Sells
   WHERE bar = 'Joe''s Bar' AND beer = 'Bud');
```
</details>

7. Find the name and manufacturer of each beer that 'Fred' likes.
<details>
<summary>answer</summary>

```sql
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
</details>

8. Find beers that are the only beer made by their manufacturer.
<details>
<summary>answer</summary>

```sql
SELECT name
FROM Beers B
WHERE NOT EXISTS
  (SELECT *
   FROM Beers
   WHERE B.name <> name AND B.manf = manf);
```
</details>

9. Find drinker and beer pairs such that:
    * The drinker likes the beer, and
    * The drinker frequents at least one bar that sells the beer.
<details>
<summary>answer</summary>

```sql
(SELECT drinker, beer
 FROM Likes)
INTERSET
(SELECT drinker, beer
 FROM Frequents F, Sells S
 WHERE F.bar = S.bar);
```
</details>

10. Find all the different prices charged for beers.
<details>
<summary>answer</summary>

```sql
SELECT DISTINCT price
FROM Sells;
```
</details>

11. Find the average price of 'Bud'.
<details>
<summary>answer</summary>

```sql
SELECT AVG(price)
FROM Sells
WHERE beer = 'Bud';
```
</details>

12. Find the number of different prices charged for 'Bud'.
<details>
<summary>answer</summary>

```sql
SELECT COUNT(DISTINCT price)
FROM Sells
WHERE beer = 'Bud';
```
</details>

13. Find the number of bars that sell 'Bud'.
<details>
<summary>answer</summary>

```sql
SELECT COUNT(*)
FROM Sells
WHERE beer = 'Bud';
```
</details>

14. Find the number of bars that sell 'Bud' for a known price.
<details>
<summary>answer</summary>

```sql
SELECT COUNT(price)
FROM Sells
WHERE beer = 'Bud';
```
</details>

15. Find the average price for each beer.
<details>
<summary>answer</summary>

```sql
SELECT beer, AVG(price)
FROM Sells
GROUP BY beer;
```
</details>

16. Find for each drinker the average price of 'Bud' at the bars they frequent.
<details>
<summary>answer</summary>

```sql
SELECT drinker, AVG(price)
FROM Sells S, Frequents F
WHERE S.bar = F.bar AND beer = 'Bud'
GROUP BY drinker;
```
</details>

17. Find the bar that sells 'Bud' the cheapest.
<details>
<summary>answer</summary>

```sql
SELECT bar
FROM Sells
WHERE price =
  (SELECT MIN(price)
   FROM Sells
   WHERE beer = 'Bud') AND beer = 'Bud';
```
</details>

18. Find the average price of those beers that are either served in at least
    three bars or are manufactured by 'Pete's'.
<details>
<summary>answer</summary>

```sql
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
</details>

## Kings and Queens
Consider a database for kings and queens of England:
* Kings(name, nickname, house, beginReign, endReign): kings have unique names,
  e.g. using a Roman numeral to distinguish them, e.g., 'Edward I' or
  'Edward II', or in a few cases using their nickname, e.g., 'Edward the
  Confessor'. The attribute 'nickname' is an additional appelation, if they have
  one and it is not used in their name to distinguish them, e.g., 'The Unready'.
  The value of nickname is NULL if there is no nickname. The attribute house is
  the dynasty, e.g., 'Tudor'. Attribute beginReign and endReign are integers,
  the first and last years, respectively, that the king or queen was on the throne.
* Parents(child, parent): both attributes are the names of kings or queens, with
  the obvious connection that the first is a child of the second.

19. Who was king in the year 1000? Give the name and nickname.
<details>
<summary>answer</summary>

```sql
SELECT name, nickname
FROM Kings
WHERE beginReign <= 1000 AND endReign >= 1000;
```
</details>

20. Find all the pairs of kings or queens (A,B) such that A was the great
    grandchild of B.
<details>
<summary>answer</summary>

```sql
SELECT p1.child, p3.parent
FROM Parents p1, Parents p2, Parents p3
WHERE p1.parent = p2.child AND p2.parent = p3.child;
```
</details>

21. Find the name and nickname of all kings or queens that have a nickname that
    does not begin with "The".
<details>
<summary>answer</summary>

```sql
SELECT name, nickname
FROM Kings
WHERE nickname NOT LIKE 'The%';
```
</details>

22. Find the names of those kings or queens that were the parent of two or
    more kings or queens. List each such person only once.
<details>
<summary>answer</summary>

```sql
SELECT parent
FROM Parents
GROUP BY parent
HAVING COUNT(*) > 1;
```
</details>

23. Find for each house the number of kings or queens of that house.
<details>
<summary>answer</summary>

```sql
SELECT house, COUNT(*)
FROM Kings
GROUP BY house;
```
</details>

24. Several times in British history, kings or queens have deposed one another,
    so that their reigns overlapped. Find all such pairs, listing the pairs in
    both orders; i.e., list both (A,B) and (B,A). However, be careful not to
    list pairs A and B where the only overlap is that A's reign ended in the
    same year that B's began, or vice-versa.
<details>
<summary>answer</summary>

```sql
SELECT k1.name, k2.name
FROM Kings k1, Kings k2
WHERE (k1.beginReign < k2.beginReign AND k1.endReign > k2.beginReign)
OR (k2.beginReign < k1.beginReign AND k1.endReign < k2.endReign);
```
</details>

## Movies
Consider a movie database:
* Movie(title, year, length, inColor, studioName, producerC#)
* StarsIn(movieTitle, movieYear, starName)
* MovieStar(name, address, gender, birthdate)
* MovieExec(name, address, cert#, netWorth)
* Studio(name, address, presC#)

__Note: producerC#, cert#, and presC# have the same meaning - certificate
number.__

25. Find all movies produced by Disney Studios in 1990.
<details>
<summary>answer</summary>

```sql
SELECT *
FROM Movie
WHERE studioName = 'Disney' AND year = 1990;
```
</details>

26. Find movies made after 1970 that are in black-and-white.
<details>
<summary>answer</summary>

```sql
SELECT title
FROM Movie
WHERE year > 1970 AND NOT inColor;
```
</details>

27. Find movies made by MGM Studios that were either made before 1970 or were
    less than 90 minutes long.
<details>
<summary>answer</summary>

```sql
SELECT title
FROM Movie
WHERE (year > 1970 OR length < 90) AND studioName = 'MGM';
```
</details>

28. You remember a movie 'Star something' and you remember that the something
    has four letters. Find such movies.
<details>
<summary>answer</summary>

```sql
SELECT title
FROM Movie
WHERE title LIKE 'Star____';
```
</details>

29. Find all movies with a possessive ('s) in their titles.
<details>
<summary>answer</summary>

```sql
SELECT title
FROM Movie
WHERE title LIKE '%''s%';
```
</details>

30. Find all the stars that appeared either in a movie made in 1980 or a movie
    with 'Love' in the title.
<details>
<summary>answer</summary>

```sql
SELECT starName
FROM Movie
WHERE movieYear = 1980 OR moiveTitle LIKE "%Love%";
```
</details>

31. Find the producer of 'Star Wars'.
<details>
<summary>answer</summary>

```sql
SELECT name
FROM Movie, MovieExec
WHERE title = 'Star Wars' AND producerC# = cert#;
```
</details>

32. Find pairs consisting of a star and an executive with the same address.
<details>
<summary>answer</summary>

```sql
SELECT MovieStar.name, MovieExec.name
FROM MovieStar, MovieExec
WHERE MovieStar.address = MoiveExec.address;
```
</details>

33. Find pairs of stars who share an address.
<details>
<summary>answer</summary>

```sql
SELECT Star1.name, Star2.name
FROM MovieStar AS Star1, MovieStar AS Star2
WHERE Star1.address = Star2.address AND Star1.name < Star2.name;
```
</details>

34. Find the names and addresses of all female movie stars who are also movie
    executives with a net worth over $10,000,000.
<details>
<summary>answer</summary>

```sql
(SELECT name, address
 FROM MovieStar
 WHERE gender = 'F')
INTERSECT
(SELECT name, address
 FROM MovieExec
 WHERE netWorth > 10000000);
```
</details>

35. Find the male stars in 'Terms of Endearment'.
<details>
<summary>answer</summary>

```sql
FROM Movie, StarsIn, MovieStar
WHERE title = movieTitle AND starName = name
AND gender = 'male' AND title = 'Terms of Endearment';
```
</details>

36. Find movies that are longer than 'Gone With the Wind'.
<details>
<summary>answer</summary>

```sql
SELECT title
FROM Moive
WHERE length > (SELECT length FROM Movie WHERE title = 'Gone With the Wind');
```
</details>

37. Find the producers of Harrison Ford's movies.
<details>
<summary>answer</summary>

```sql
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
</details>

38. Find the titles that have been used for two or more movies.
<details>
<summary>answer</summary>

```sql
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
</details>

39. Find the average net worth of all movie executives.
<details>
<summary>answer</summary>

```sql
SELECT AVG(netWorth)
FROM MovieExec;
```
</details>

40. Find the sum of the lengths of all movies for each studio.
<details>
<summary>answer</summary>

```sql
SELECT studioName, SUM(length)
FROM Movie
GROUP BY studioName;
```
</details>

41. Find each producer's total length of film produced.
<details>
<summary>answer</summary>

```sql
SELECT name, SUM(length)
FROM MovieExec, Movie
WHERE producerC# = cert#
GROUP BY name;
```
</details>

42. Find the total file length for producers who made at least on film prior
    to 1930.
<details>
<summary>answer</summary>

```sql
SELECT name, SUM(length)
FROM MovieExec, Movie
WHERE producerC# = cert#
GROUP BY name
HAVING MIN(year) < 1930;
```
</details>
