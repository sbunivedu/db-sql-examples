# SQL Calisthenics

Consider a beer database:
* Beers (name, manf): the beer with the name is made by the manf.
* Bars (name, addr, license): the bar with the name and at the addr has the
  license number.
* Drinkers (name, addr, phone): the drinker with the name lives at the addr with
  the phone number.
* Likes (drinker, beer): the drinker likes the beer.
* Sells (bar, beer, price): the bar sells the beer for the price.
* Frequents (drinker, bar): the drinker frequents the bar.

1. What beers are made by Anheuser-Busch?
2. What is the price Joe’s Bar charges for Bud?
3. Find drinkers who have a phone number that has '555' followed by 4 more digits.
4. Find the beers liked by at least one person who frequents Joe's Bar.
5. Find all pairs of beers by the same manufacturer.
    * Do not produce pairs like (Bud, Bud).
    * Produce pairs in alphabetic order, e.g. (Bud, Miller), not (Miller, Bud).
6. Find the bars that serve 'Miller' for the same price 'Joe' charges for 'Bud'.
7. Find the name and manufacturer of each beer that 'Fred' likes.
8. Find beers that are the only beer made by their manufacturer.
9. Find drinker and beer pairs such that:
    * The drinker likes the beer, and
    * The drinker frequents at least one bar that sells the beer.
10. Find all the different prices charged for beers.
11. Find the average price of 'Bud'.
12. Find the number of different prices charged for 'Bud'.
13. Find the number of bars that sell 'Bud'.
14. Find the number of bars that sell 'Bud' for a known price.
15. Find the average price for each beer.
16. Find for each drinker the average price of 'Bud' at the bars they frequent.
17. Find the bar that sells 'Bud' the cheapest.
18. Find the average price of those beers that are either served in at least
    three bars or are manufactured by 'Pete's'.

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
20. Find all the pairs of kings or queens (A,B) such that A was the great
    grandchild of B.
21. Find the name and nickname of all kings or queens that have a nickname that
    does not begin with "The".
22. Find the names of those kings or queens that were the parent of two or
    more kings or queens. List each such person only once.
23. Find for each house the number of kings or queens of that house.
24. Several times in British history, kings or queens have deposed one another,
    so that their reigns overlapped. Find all such pairs, listing the pairs in
    both orders; i.e., list both (A,B) and (B,A). However, be careful not to
    list pairs A and B where the only overlap is that A's reign ended in the
    same year that B's began, or vice-versa.
