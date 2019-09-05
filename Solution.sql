Заданние № 1: 
/* Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd. */
SELECT model, speed, hd FROM pc WHERE price < 500;

Задание № 2: 
/* Найдите производителей принтеров. Вывести: maker. */
SELECT DISTINCT maker FROM product WHERE type = 'printer';

Задание № 3:
/* Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол. */
SELECT model, ram, screen FROM laptop WHERE price > 1000;

Задание № 4:
/* Найдите все записи таблицы Printer для цветных принтеров. */
SELECT * FROM printer WHERE color = 'y';

Задание № 5:
/* Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол. */
SELECT model, speed, hd FROM pc WHERE (cd = '12x' OR cd = '24x') AND price < 600;
/*или */ 
SELECT model, speed, hd FROM pc WHERE cd IN ('12x', '24x') and price < 600;

Задание № 6:
/* Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, 
найти скорости таких ПК-блокнотов. Вывод: производитель, скорость. */
SELECT DISTINCT maker, speed FROM product JOIN laptop ON product.model = laptop.model AND laptop.hd >= 10;

Задание № 7:
/* Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква). */
SELECT pc.model, pc.price FROM pc INNER JOIN product p ON pc.model = p.model WHERE maker = 'B'
UNION
SELECT l.model, l.price FROM laptop l INNER JOIN product p ON l.model = p.model WHERE maker = 'B'
UNION
SELECT prt.model, prt.price FROM printer prt INNER JOIN Product p ON prt.model = p.model WHERE maker = 'B';

Задание № 8:
/* Найдите производителя, выпускающего ПК, но не ПК-блокноты. */
SELECT DISTINCT maker FROM product WHERE type = 'pc' AND maker NOT IN(SELECT maker FROM product WHERE type = 'laptop');
/* или */
SELECT maker FROM product WHERE type = 'pc'
EXCEPT
SELECT maker FROM product WHERE type = 'laptop';

Задание № 9:
/* Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker. */
SELECT DISTINCT maker FROM product p INNER JOIN pc ON p.model = pc.model WHERE speed >= 450;

Задание № 10:
/* Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price. */
SELECT model, price FROM printer WHERE price = (SELECT MAX(price) FROM printer);

Задание № 11:
/* Найдите среднюю скорость ПК. */
SELECT AVG(speed) FROM pc;

Задание № 12:
/* Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол. */
SELECT AVG(speed) FROM laptop WHERE price > 1000;

Задание № 13:
/* Найдите среднюю скорость ПК, выпущенных производителем A. */
SELECT AVG(speed) FROM pc INNER JOIN product ON pc.model = product.model WHERE product.maker = 'A';

Задание № 14:
/* Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий. */
 SELECT s.class, s.name, c.country FROM ships s INNER JOIN classes c ON s.class = c.class WHERE c.numGuns >=10;

Задание № 15:
/* Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD. */
SELECT hd FROM pc GROUP BY hd HAVING COUNT(hd) >1;

Задание № 16:
/* Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз,
т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM. */
SELECT DISTINCT a.model AS Model_A, b.model AS Model_B, a.speed, a.ram
FROM pc a INNER JOIN pc b ON a.speed = b.speed AND a.ram = b.ram AND a.model > b.model ORDER BY a.model;

Задание № 17:
/* Найдите модели ПК-блокнотов, скорость которых меньше скорости любого из ПК. Вывести: type, model, speed.  */
SELECT DISTINCT type, l.model, l.speed FROM laptop l JOIN product p ON l.model = p.model 
WHERE speed < (SELECT MIN(speed) FROM pc);
/* или */
SELECT DISTINCT type, l.model, l.speed FROM laptop l JOIN product p ON l.model = p.model
WHERE l.speed < ALL(SELECT speed FROM pc);

Задание № 18:
/* Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price. */
SELECT DISTINCT maker, price FROM printer prt JOIN product p ON prt.model= p.model  
WHERE price = (select min(price)from printer where color = 'y') and color = 'y';
/*или */ 
SELECT DISTINCT maker, price FROM product, printer WHERE product.model = printer.model 
AND color = 'y' AND price IN (SELECT min(price) FROM printer WHERE color ='y');

Задание № 19:
/* Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана. */
SELECT maker, avg(screen) FROM product p JOIN laptop l ON p.model = l.model GROUP BY maker;

Задание № 20:
/* Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК. */
SELECT maker, count(model) FROM product WHERE type = 'pc' GROUP BY maker HAVING count(model) >= 3;

Задание № 23:
/* Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, 
так и ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker */
SELECT DISTINCT maker FROM product p JOIN pc ON p.model = pc.model AND speed >= 750 
AND maker IN (SELECT maker FROM product p JOIN laptop l ON p.model = l.model AND speed >=750);
/* или */ 
SELECT maker FROM product p INNER JOIN pc ON p.model = pc.model WHERE speed > = 750
INTERSECT
SELECT maker FROM product p INNER JOIN laptop l ON p.model = l.model WHERE speed > = 750;

Задание № 24:
/* Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе данных продукции. */
SELECT model FROM(
       SELECT model, price FROM pc UNION
       SELECT model, price FROM laptop UNION
       SELECT model, price FROM printer) AS m
WHERE price IN(
       SELECT max(price) FROM(
       SELECT price FROM pc UNION
       SELECT price FROM laptop UNION
       SELECT price FROM printer) AS m);
       
Задание № 26:
/* Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна общая средняя цена. */
SELECT avg(price) FROM (
SELECT price FROM pc, product p WHERE pc.model = p.model AND maker = 'A'
UNION ALL
SELECT price FROM laptop l , product p WHERE l.model = p.model AND maker = 'A') AS avg

Задание № 27:
/* Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. 
Вывести: maker, средний размер HD. */
SELECT maker, avg(HD) AS Avg_HD FROM product p, pc WHERE p.model = pc.model AND maker IN (
SELECT maker FROM product WHERE type = 'printer') GROUP BY maker;
 

Задание № 28:
/* Используя таблицу Product, определить количество производителей, выпускающих по одной модели. */
SELECT count(maker) FROM (SELECT maker FROM product GROUP BY maker HAVING count(model) = 1) AS c;

Задание № 35:
/* В таблице Product найти модели, которые состоят только из цифр или только из латинских букв (A-Z, без учета регистра).
Вывод: номер модели, тип модели. */
SELECT model, type FROM product WHERE upper(model) not like '%[^A-Z]%'OR model not like '%[^0-9]%';

Задание № 36:
/* Перечислите названия головных кораблей, имеющихся в базе данных (учесть корабли в Outcomes). */
SELECT name FROM ships WHERE class = name
UNION 
SELECT ship AS name FROM classes JOIN outcomes ON classes.class = outcomes.ship;

Задание № 37:
/* Найдите классы, в которые входит только один корабль из базы данных (учесть также корабли в Outcomes). */
SELECT c.class FROM classes c JOIN (
SELECT class,name FROM ships UNION
SELECT c.class,o.ship FROM Outcomes o JOIN classes c ON c.class = o.ship) AS t1
ON t1.class = c.class GROUP BY c.class HAVING COUNT(c.class) = 1;

Задание № 38:
/* Найдите страны, имевшие когда-либо классы обычных боевых кораблей ('bb') и имевшие когда-либо классы крейсеров ('bc'). */
SELECT country FROM classes WHERE type = 'bb' AND country IN (SELECT country FROM classes WHERE type ='bc');
/* или*/
SELECT country FROM classes WHERE type = 'bb'
INTERSECT
SELECT country FROM classes WHERE type = 'bc';

Задание № 42:
/* Найдите названия кораблей, потопленных в сражениях, и название сражения, в котором они были потоплены. */
SELECT ship, battle FROM outcomes WHERE result = 'sunk';

Задание № 44:
/* Найдите названия всех кораблей в базе данных, начинающихся с буквы R. */
SELECT name FROM Ships WHERE name LIKE 'r%'
UNION
SELECT ship FROM Outcomes WHERE ship LIKE 'r%';

Задание № 45:
/* Найдите названия всех кораблей в базе данных, состоящие из трех и более слов (например, King George V).
Считать, что слова в названиях разделяются единичными пробелами, и нет концевых пробелов. */
SELECT name FROM ships WHERE name LIKE '% % %'
UNION
SELECT ship FROM outcomes WHERE ship LIKE '% % %'

Задание № 48:
/* Найдите классы кораблей, в которых хотя бы один корабль был потоплен в сражении. */
SELECT class FROM classes, outcomes WHERE classes.class = outcomes.ship AND result = 'sunk'
UNION
SELECT class FROM ships, outcomes WHERE ships.name = outcomes.ship AND result = 'sunk';
/* или */
SELECT class FROM classes WHERE class IN(SELECT ship FROM outcomes WHERE result = 'sunk')
UNION
SELECT class FROM  ships WHERE name IN(SELECT ship FROM outcomes WHERE result ='sunk');

Задание № 49:
/* Найдите названия кораблей с орудиями калибра 16 дюймов (учесть корабли из таблицы Outcomes). */
SELECT name FROM ships, classes WHERE ships.class = classes.class AND bore = '16'
UNION 
SELECT ship FROM outcomes, classes WHERE outcomes.ship = classes.class AND bore = '16';
/* или */ 
SELECT name FROM ships WHERE class IN(SELECT class FROM classes WHERE bore = '16')
UNION 
SELECT ship FROM outcomes WHERE ship IN(SELECT class FROM classes WHERE bore = '16');

Задание №:
/* */
Задание №:
/* */
Задание №:
/* */
Задание №:
/* */
Задание №:
/* */
Задание №:
/* */
Задание №:
/* */
Задание №:
/* */
Задание №:
/* */



















