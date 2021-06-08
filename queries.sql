
 CREATE TABLE cities
            (
    name       VARCHAR(50),
    country    VARCHAR(50),
    population INTEGER,
    area       INTEGER
);

-- put data in the database
    INSERT INTO cities (name, country, population, area)
    VALUES ('Tokyo', 'Japan', 38505000, 8223);

    INSERT INTO cities (name, country, population, area)
    VALUES ('Delhi', 'India', 28125000, 2240),
       ('Shanghai', 'China', 22125000, 4015),
               ('Sao Paulo', 'Brazil', 20935000, 3043);

-- take all info from database
    SELECT *
    FROM cities;

    SELECT name, country
    FROM cities;

    select name, country, population / area as density
    from cities;

-- concatenation ||
    SELECT name || country
    FROM cities;

    SELECT name || ', ' || country
    FROM cities;

    SELECT name || ', ' || country AS location
    FROM cities;

    SELECT CONCAT(name, country) AS location
    FROM cities;

    SELECT CONCAT(name, ', ', country) AS location
    FROM cities;

    SELECT CONCAT(UPPER(name), ', ', UPPER(country)) AS location
    FROM cities;

    SELECT UPPER(CONCAT(name, ', ', country)) AS location
    FROM cities;

    SELECT name, area
    FROM cities
    WHERE area between 200 and 4000;

    update cities
    set population = 39505000
    where name = 'Tokyo';

    delete
    from cities
    where name = 'Tokyo';

    insert into cities (name, country, population, area)
    values ('Tokyo', 'Japan', 38505000, 8223);

-- delete databases table
    drop table cities;

--------------------------------------------------------------------------
    CREATE TABLE users
            (
                    id       SERIAL PRIMARY KEY,
                    username VARCHAR(50)
);

    INSERT INTO users (username)
    VALUES ('monahan93'),
       ('pferrer'),
               ('si93onis'),
               ('99stroman');

    SELECT *
    FROM users;
------------------------------------------------------------------------
    CREATE TABLE photos
            (
                    id      SERIAL PRIMARY KEY,
                    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id)
);

    INSERT INTO photos (url, user_id)
    VALUES ('http://one.jpg', 4);

    SELECT *
    FROM photos;

    INSERT INTO photos (url, user_id)
    VALUES ('http://two.jpg', 1),
           ('http://25.jpg', 1),
           ('http://36.jpg', 1),
           ('http://754.jpg', 2),
           ('http://35.jpg', 3),
           ('http://256.jpg', 4);

    SELECT *
    FROM photos;

    SELECT *
    FROM photos
    WHERE user_id = 4;

-- take some info from photos and join some info from another table
    SELECT url, username
    FROM photos
    JOIN users ON users.id = photos.user_id;
-----------------------------------36-------------------------------------------
    SELECT *
    FROM users;

-- This results in an error
    INSERT INTO photos (url, user_id)
    VALUES ('http://jpg', 9999);

    INSERT INTO photos (url, user_id)
    VALUES ('http://jpg', NULL);

    SELECT *
    FROM photos;

    drop table photos;
----------------------------38--------------------------
    CREATE TABLE photos
            (
                    id      SERIAL PRIMARY KEY,
                    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) on delete cascade
);

    INSERT INTO photos (url, user_id)
    VALUES ('http:/one.jpg', 4),
       ('http:/two.jpg', 1),
               ('http:/25.jpg', 1),
               ('http:/36.jpg', 1),
               ('http:/754.jpg', 2),
               ('http:/35.jpg', 3),
               ('http:/256.jpg', 4);

    DELETE
    FROM users
    WHERE id = 1;

    SELECT *
    FROM photos;
------------40----------------------------------------------------------

    DROP TABLE users;

    CREATE TABLE photos
            (
                    id      SERIAL PRIMARY KEY,
                    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE SET NULL
);

    INSERT INTO photos (url, user_id)
    VALUES ('http:/one.jpg', 4),
       ('http:/754.jpg', 2),
               ('http:/35.jpg', 3),
               ('http:/256.jpg', 4);

    DELETE
    FROM users
    WHERE id = 4;

    SELECT *
    FROM photos;

---------------------------42-------------------------------------

    CREATE TABLE users
            (
                    id       SERIAL PRIMARY KEY,
                    username VARCHAR(50)
);

    CREATE TABLE photos
            (
                    id      SERIAL PRIMARY KEY,
                    url     VARCHAR(200),
    user_id INTEGER REFERENCES users (id) ON DELETE CASCADE
);

    CREATE TABLE comments
            (
                    id       SERIAL PRIMARY KEY,
                    contents VARCHAR(240),
    user_id  INTEGER REFERENCES users (id) ON DELETE CASCADE,
    photo_id INTEGER REFERENCES photos (id) ON DELETE CASCADE
);

    INSERT INTO users (username)
    VALUES ('Reyna.Marvin');

    INSERT INTO comments (contents, user_id, photo_id)
    VALUES ('Quo velit iusto ducimus quos a incidunt nesciunt facilis.', 2, 4);

    select *
    from users;

    select *
    from photos;

    select contents, username
    from comments
    join users on users.id = comments.user_id;

    select contents, url
    from comments
    join photos on photos.id = comments.photo_id;
-------------------------------------49-------------------------------------------

    INSERT INTO photos (url, user_id)
    VALUES ('https://banner.jpg', NULL);

    select url, username
    from photos
    join users on users.id = photos.user_id;
-----------------------------52------------------------------------------------------

    INSERT INTO users (username)
    VALUES ('Nicole');

    select url, username
    from photos
    left join users on users.id = photos.user_id;

    select url, username
    from photos
    right join users on users.id = photos.user_id;

    select url, username
    from photos
    full join users on users.id = photos.user_id;
---------------------------56----------------------------------------------
    select *
    from comments;

    select *
    from photos;

    select url, contents, username
    from comments
    join photos on photos.id = comments.photo_id
    join users on users.id = comments.user_id
    and users.id = photos.user_id;

    select user_id
    from comments
    group by user_id;
----------------------62------------------------------------------------

    select max(id)
    from comments;

    select user_id, max(id)
    from comments
    group by user_id;

    select user_id, count(id) as num_comments_created
    from comments
    group by user_id;

    select photo_id, count(*)
    from comments
    group by photo_id;

    select photo_id, count(*)
    from comments
    where photo_id < 3
    group by photo_id
    having count(*) > 2;

    select user_id, count(*)
    from comments
    where photo_id < 50
    group by user_id
    having count(*) > 20;

    select photo_id
    from comments
    where user_id * photo_id > 10
    group by photo_id;

    drop table comments, photos, users;
-------------------------------75--------------------------------------------

    CREATE TABLE users
            (
                    id         SERIAL PRIMARY KEY,
                    first_name VARCHAR,
                    last_name  VARCHAR
            );
    CREATE TABLE products
            (
                    id         SERIAL PRIMARY KEY,
                    name       VARCHAR,
                    department VARCHAR,
                    price      INTEGER,
                    weight     INTEGER
            );
    CREATE TABLE orders
            (
                    id         SERIAL PRIMARY KEY,
                    user_id    INTEGER REFERENCES users (id),
    product_id INTEGER REFERENCES products (id),
    paid       BOOLEAN
);


    INSERT INTO users (first_name, last_name)
    VALUES ('Iva', 'Lindgren'),
       ('Ignatius', 'Johns');


    INSERT INTO products (name, department, price, weight)
    VALUES ('Practical Fresh Shirt', 'Toys', 876.00, 3);


    INSERT INTO orders (user_id, product_id, paid)
    VALUES (41, 100, true);

---------------------------------------76----------------------------------

    select *
    from users;
    select *
    from products;
    select *
    from orders;

    select *
    from products
    order by price;

    select *
    from products
    order by price desc;

    select *
    from products
    order by price, weight;

    select *
    from users
    offset 40;

    select *
    from users
    limit 5;

    select *
    from products
    order by price
    limit 5;
-------------------86-----------------------------------

        (
    select *
    from products
    order by price desc
    limit 4
            )
    union all
            (
                    select *
                    from products
                    order by price / weight desc
                    limit 4
            );

(
    select *
    from products
    order by price desc
    limit 4
            )
    intersect
            (
                    select *
                    from products
                    order by price / weight desc
                    limit 4
            );

(
    select *
    from products
    order by price desc
    limit 4
            )
    except
            (
                    select *
                    from products
                    order by price / weight desc
                    limit 4
            );
---------------------------------92---------------------------------

    select name, price
    from products
    where price > (
    select max(price)
    from products
    where department = 'Toys');

    select name,
            price,
       (
    select max(price)
    from products
       )
    from products
    where price > 867;


    select name,
            price,
       (select max(price)
    from products)         as max_price,
       (select max(price)
    from products) / price as ratio
    from products;

    select name, price / weight as price_weight_ratio
    from products;

    select name, price_weight_ratio
    from (
            select name, price / weight as price_weight_ratio
            from products
    ) as p
    where price_weight_ratio > 5;

    select *
    from products;

    select user_id, count(*)
    from orders
    group by user_id;
-----------------------------------------99-------------------------------

    select avg(order_count)
    from (
            select user_id, count(*) as order_count
    from orders
    group by user_id
     ) as p;

    select avg(price)
    from products;

    select user_id, count(*) as order_count
    from orders
    group by user_id;

    select *
    from orders;

    select id
    from orders
    where product_id in (
            select id
    from products
            where price / weight > 50
    );

    select name, price
    from products
    where price > (
    select avg(price)
    from products
);

    select name, department
    from products
    where department not in (
            select department
    from products
            where price < 100
    );

    select name, department, price
    from products
    where price > all (
            select price
    from products
            where department = 'Industrial'
    );

    select name, department, price
    from products
    where price > some (
            select price
    from products
            where department = 'Industrial'
    );

    select name, department, price
    from products as p1
    where p1.price = (
    select max(price)
    from products as p2
    where p1.department = p2.department
);
----------------------------------113---------------------------------

    select p1.name,
            (
    select count(*)
    from orders as o1
    where o1.product_id = p1.id
       ) as num_orders
    from products as p1;

    select (
            select max(price)
    from products
       ) / (
    select avg(price)
    from products
       );

    select count(distinct department)
    from products;

    select name, weight, greatest(30, 2 * weight)
    from products;

    select least(1000, 20, 50, 100);

    select name, price, least(price * 0.5, 400)
    from products;


    select *
    from products;

    select name,
            price,
       case
    when price > 600 then 'high'
    when price > 300 then 'medium'
            else 'cheap'
    end
    from products;

    select (12::integer);

    select ('a'::char(3));

    select ('true'::boolean);

    select ('nov 20 1980'::date);

    select ('01:23:23 am pst'::time with time zone);

    select
            ('NOW-20-1980 1:23 AM EST'::timestamp with time zone)
-
        ('NOW-10-1980 1:23 AM EST'::timestamp with time zone);

------distinct - find non-duplicate.(work only with single argument)
    select distinct department from products;

    SELECT ('1 D 20 H 30 M 45 S'::INTERVAL) - ('1 D'::INTERVAL);

    select
            ('11-20-1980 1:23 AM EST'::timestamp with time zone)
        - ('1 D'::INTERVAL);
----------------------------------135-----------------------------

    create table products (
            id serial primary key,
            name varchar(40),
    department varchar(40),
    price integer,
    weight integer
);

    insert into products (name, department, price, weight)
    values ('Shirt', 'Clothes', 20, 1);

    insert into products (name, department, weight)
    values ('Pants', 'Clothes', 3);

---how to change the validation in a column of an existing table-----------
    alter table products
    alter column price
    set not null;

    update products set price = 9999 where price is null;

    insert into products (name, department, weight)
    values ('Shoes', 'Clothes', 5);

    alter table products
    alter column price
    set default 999;

    insert into products (name, department, weight)
    values ('Gloves', 'Tools', 1);

    insert into products (name, department, price, weight)
    values ('Shirt', 'Tools', 24, 1);

    alter table products
    add unique (name, department);

    insert into products (name, department, price, weight)
    values ('Shirt', 'Houswares', 24, 1);

    select * from products;

    update products set department = 'Housewares' where id = 6;

    alter table products add check (price > 0);

    insert into products (name, department, price, weight)
    values ('Belt', 'House', -99, 1);
-----------------142--------------------------------

    create table orders (
            id serial primary key,
            name varchar(40) not null,
    created_at timestamp not null,
    est_delivery timestamp not null,
    check (created_at < est_delivery)
);

    insert into orders (name, created_at, )*/

