.read data.sql


CREATE TABLE bluedog AS
  SELECT color, pet FROM students WHERE color = "blue" AND pet = "dog";

CREATE TABLE bluedog_songs AS
  SELECT color, pet, song FROM students WHERE color = "blue" AND pet = "dog";


CREATE TABLE smallest_int_having AS
  SELECT time, smallest FROM students GROUP BY smallest HAVING 1 = COUNT(smallest);


CREATE TABLE matchmaker AS
  SELECT first.pet, first.song, first.color, second.color FROM students AS first, students AS second WHERE first.time != second.time AND first.pet = second.pet AND first.song = second.song AND first.time < second.time;


CREATE TABLE sevens AS
  SELECT a.seven FROM students AS a, numbers AS b WHERE a.time = b.time and a.number = 7 AND b.'7' = 'True';


CREATE TABLE average_prices AS
  SELECT category, avg(MSRP) AS average_price FROM products GROUP BY category;


CREATE TABLE lowest_prices AS
  SELECT store, item, price FROM inventory where (item, price) IN (SELECT item, MIN(price) FROM inventory GROUP BY item);


-- CREATE TABLE shopping_list AS
--   SELECT item, store
--   FROM products, lowest_prices
--   WHERE lowest_prices.item = products.name AND (products.category, lowest_prices.price / products.rating) IN (SELECT products.category, MIN(lowest_prices.price / products.rating) FROM products, lowest_prices WHERE lowest_prices.item = products.name GROUP BY category);
CREATE TABLE shopping_list AS
  SELECT name, store FROM
    (SELECT item.name AS name, inventory.store AS store, MIN(inventory.price)
      FROM (SELECT name, MIN(MSRP / rating) FROM products GROUP BY category) item 
      JOIN inventory ON item.name = inventory.item
      GROUP BY item.name);

-- CREATE TABLE shopping_list AS 
--   SELECT products.category, MIN(lowest_prices.price / products.rating) FROM lowest_prices, products WHERE lowest_prices.item = products.name GROUP BY category;

CREATE TABLE total_bandwidth AS
  SELECT SUM(stores.Mbs) FROM shopping_list s JOIN stores ON s.store = stores.store;

