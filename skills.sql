-- 1. Select all columns for all brands in the Brands table.
select * from brands;

-- 2. Select all columns for all car models made by Pontiac in the Models table.
select * from models where brand_name = 'Pontiac';

-- 3. Select the brand name and model name for all models made in 1964 from the Models table.
select brand_name,name from models where year=1964 ;


-- 4. Select the model name, brand name, and headquarters for the Ford Mustang from the Models and Brands tables.
select models.name, brand_name, headquarters from models, brands where models.brand_name = brands.name;

-- 5. Select all rows for the three oldest brands from the Brands table (Hint: you can use LIMIT and ORDER BY).
select * from brands order by founded limit 3;

-- 6. Count the Ford models in the database (output should be a **number**).
select count(name) from models where brand_name = 'Ford';
select brand_name,count(name) from models group by brand_name;

-- 7. Select the **name** of any and all car brands that are not discontinued.
select name from brands where discontinued is Null;


-- 8. Select rows 15-25 of the DB in alphabetical order by model name.
SELECT * FROM models order by name LIMIT 10 OFFSET 15

-- 9. Select the **brand, name, and year the model's brand was 
--    founded** for all of the models from 1960. Include row(s)
--    for model(s) even if its brand is not in the Brands table.
--    (The year the brand was founded should be ``null`` if 
--    the brand is not in the Brands table.)

 select models.brand_name,models.name,brands.founded 
 from models left outer join brands on  models.brand_name = brands.name 
 where year>1960


-- Part 2: Change the following queries according to the specifications. 
-- Include the answers to the follow up questions in a comment below your
-- query.

-- 1. Modify this query so it shows all **brands** that are not discontinued
-- regardless of whether they have any cars in the cars table.
-- before:
    -- SELECT b.name,
    --        b.founded,
    --        m.name
    -- FROM MODEL AS m
    --   LEFT JOIN brands AS b
    --     ON b.name = m.brand_name
    -- WHERE b.discontinued IS NULL;
    
select b.name,b.founded,m.name from brands as b left join models as m  on b.name=m.brand_name where b.discontinued is NULL;




-- 2. Modify this left join so it only selects models that have brands in the Brands table.
-- before: 
    -- SELECT m.name,
    --        m.brand_name,
    --        b.founded
    -- FROM Models AS m
    --   LEFT JOIN Brands AS b
    --     ON b.name = m.brand_name;
select m.name, m.brand_name, b.founded FROM Models as m INNER JOIN Brands as b ON b.name = m.brand_name;
-- followup question: In your own words, describe the difference between 
-- left joins and inner joins.
INNER JOIN - is joining two tables with 100 % matching of the records in the two data columns.
LEFT OUTER JOIN - is joining the driving table and the other table with 100 % records of the driving table and assigning null values for he records that are known/ not available.


-- 3. Modify the query so that it only selects brands that don't have any car models in the cars table. 
-- (Hint: it should only show Tesla's row.)
-- before: 
    -- SELECT name,
    --        founded
    -- FROM Brands
    --   LEFT JOIN Models
    --     ON brands.name = Models.brand_name
    -- WHERE Models.year > 1940;
select b.name,b.founded,m.name from brands as b left join models as m  on b.name=m.brand_name where m.name is NULL;    


-- 4. Modify the query to add another column to the results to show 
-- the number of years from the year of the model *until* the brand becomes discontinued
-- Display this column with the name years_until_brand_discontinued.
-- before: 
    -- SELECT b.name,
    --        m.name,
    --        m.year,
    --        b.discontinued
    -- FROM Models AS m
    --   LEFT JOIN brands AS b
    --     ON m.brand_name = b.name
    -- WHERE b.discontinued NOT NULL;
SELECT b.name, m.name, m.year, b.discontinued, b.discontinued - m.year as years_until_brand_discontinued from Models AS m LEFT JOin brands AS b ON m.brand_name = b.name WHERE b.discontinued NOT NULL;





-- Part 3: Futher Study

-- 1. Select the **name** of any brand with more than 5 models in the database.

 select b.name,count(m.name) FROM Models as m INNER JOIN Brands as b ON b.name = m.brand_name group by b.name having count(m.name) > 5;


-- 2. Add the following rows to the Models table.

-- year    name       brand_name
-- ----    ----       ----------
-- 2015    Chevrolet  Malibu
-- 2015    Subaru     Outback

insert into models values (49,2015,'Chevrolet','Malibu');
insert into models values (50,2015,'Subaru','Outback');

-- 3. Write a SQL statement to crate a table called ``Awards`` 
--    with columns ``name``, ``year``, and ``winner``. Choose 
--    an appropriate datatype and nullability for each column.

CREATE TABLE Awards (
    name VARCHAR(50) NOT NULL,
    year INT(4) NOT NULL,
    winner INTEGER NULL
);


-- 4. Write a SQL statement that adds the following rows to the Awards table:

--   name                 year      winner_model_id
--   ----                 ----      ---------------
--   IIHS Safety Award    2015      # get the ``id`` of the 2015 Chevrolet Malibu
--   IIHS Safety Award    2015      # get the ``id`` of the 2015 Subaru Outback

insert into Awards values ('IIHS Safety Award',2015,49);
insert into Awards values ('IIHS Safety Award',2015,50);

-- 5. Using a subquery, select only the *name* of any model whose 
-- year is the same year that *any* brand was founded.

select m.name from models as m where m.year in ( select b.founded from brands as b )

other way -

select m.name from models as m  join brands as b on m.year = b.founded 



