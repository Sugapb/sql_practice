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

/* Или через EXCEPT */
SELECT maker FROM Product WHERE type = 'pc'
EXCEPT
SELECT maker FROM Product WHERE type = 'laptop';

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
SELECT DISTINCT type, l.model, l.speed FROM laptop l INNER JOIN product ON l.model = product.model 
WHERE speed < (SELECT MIN(speed) FROM pc);

Задание № 18:
/* Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price. */
SELECT DISTINCT maker, price  
FROM printer prt JOIN product p ON prt.model= p.model  
WHERE price = (select min(price)from printer where color = 'y') and color = 'y';

Задание № 19:
/* Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов.
Вывести: maker, средний размер экрана. */
SELECT maker, avg(screen) FROM product p JOIN laptop l ON p.model = l.model GROUP BY maker;

Задание № 20:
/* Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК. */
SELECT DISTINCT maker, count(model) FROM product WHERE type = 'pc' GROUP BY maker HAVING count(model) >= 3;

Задание №:
/* */






















