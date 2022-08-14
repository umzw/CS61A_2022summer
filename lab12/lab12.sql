CREATE TABLE pizzas AS
  SELECT "Pizzahhh" AS name, 12 AS open, 15 AS close UNION
  SELECT "La Val's"        , 11        , 22          UNION
  SELECT "Sliver"          , 11        , 20          UNION
  SELECT "Cheeseboard"     , 16        , 23          UNION
  SELECT "Emilia's"        , 13        , 18;

CREATE TABLE meals AS
  SELECT "breakfast" AS meal, 11 AS time UNION
  SELECT "lunch"            , 13         UNION
  SELECT "dinner"           , 19         UNION
  SELECT "snack"            , 22;


-- Pizza places that open before 1pm in alphabetical order
CREATE TABLE opening AS
-- SELECT "REPLACE THIS LINE WITH YOUR SOLUTION";
SELECT name FROM pizzas WHERE open < 13 ORDER BY name;


-- Two meals at the same place
CREATE TABLE double AS
SELECT m1.meal, m2.meal, name FROM pizzas AS p, meals AS m1, meals AS m2 WHERE p.open <= m1.time AND m2.time <= p.close  AND m1.time + 6 < m2.time;
-- SELECT "REPLACE THIS LINE WITH YOUR SOLUTION";

