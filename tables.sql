learn=# CREATE DATABASE rolodex;
CREATE DATABASE
learn=# \c
You are now connected to database "learn" as user "learn".
learn=# \c rolodex
You are now connected to database "rolodex" as user "learn".
rolodex=# CREATE TABLE persons (id serial PRIMARY KEY, given_name varchar, family_name varchar, address varchar, dob varchar, email varchar);
CREATE TABLE
rolodex=# INSERT INTO persons (given_name, family_name, address, dob, email) VALUES ('KAZ', 'TATEIWA', '123 MAIN ST', '01/09/1970', 'kaz@gmail.com'), ('GERARDO', 'CABRAL', '555 S.MAIN ST', '02/26/1989', 'gerardo@gmail.com'), ('JON', 'SNOW', '1 WINTERFELL LN', '12/15/1854', 'whitewolf@gmail.com'), ('DONALD', 'TRUMP', '555 WHITEHOUSE', '06/06/1906', 'spraytansRus@whitehouse.com'), ('BRUCE', 'WILLIS', '123 DIEHARD DR', '01/04/1967', 'johnmcclain@gmail.com');
INSERT 0 5
rolodex=# select * from persons;
 id | given_name | family_name |     address     |    dob     |            email
----+------------+-------------+-----------------+------------+-----------------------------
  1 | KAZ        | TATEIWA     | 123 MAIN ST     | 01/09/1970 | kaz@gmail.com
  2 | GERARDO    | CABRAL      | 555 S.MAIN ST   | 02/26/1989 | gerardo@gmail.com
  3 | JON        | SNOW        | 1 WINTERFELL LN | 12/15/1854 | whitewolf@gmail.com
  4 | DONALD     | TRUMP       | 555 WHITEHOUSE  | 06/06/1906 | spraytansRus@whitehouse.com
  5 | BRUCE      | WILLIS      | 123 DIEHARD DR  | 01/04/1967 | johnmcclain@gmail.com
(5 rows)

rolodex=# \d
             List of relations
 Schema |      Name      |   Type   | Owner
--------+----------------+----------+-------
 public | persons        | table    | learn
 public | persons_id_seq | sequence | learn
(2 rows)

rolodex=# INSERT INTO persons (given_name, family_name, address, dob, email) VALUES ('GERARDO', 'CABRAL', '555 S.MAIN ST', '10/03/1958', 'gSR@gmail.com');
INSERT 0 1
rolodex=# SELECT * FROM persons
rolodex-# select * from persons;
ERROR:  syntax error at or near "select"
LINE 2: select * from persons;
        ^
rolodex=# SELECT * FROM persons;
 id | given_name | family_name |     address     |    dob     |            email
----+------------+-------------+-----------------+------------+-----------------------------
  1 | KAZ        | TATEIWA     | 123 MAIN ST     | 01/09/1970 | kaz@gmail.com
  2 | GERARDO    | CABRAL      | 555 S.MAIN ST   | 02/26/1989 | gerardo@gmail.com
  3 | JON        | SNOW        | 1 WINTERFELL LN | 12/15/1854 | whitewolf@gmail.com
  4 | DONALD     | TRUMP       | 555 WHITEHOUSE  | 06/06/1906 | spraytansRus@whitehouse.com
  5 | BRUCE      | WILLIS      | 123 DIEHARD DR  | 01/04/1967 | johnmcclain@gmail.com
  6 | GERARDO    | CABRAL      | 555 S.MAIN ST   | 10/03/1958 | gSR@gmail.com
(6 rows)

rolodex=# UPDATE persons SET address = '123 DIEHARD DR' WHERE address = '555 S.MAIN ST';
UPDATE 2
rolodex=# SELECT * FROM persons;
 id | given_name | family_name |     address     |    dob     |            email
----+------------+-------------+-----------------+------------+-----------------------------
  1 | KAZ        | TATEIWA     | 123 MAIN ST     | 01/09/1970 | kaz@gmail.com
  3 | JON        | SNOW        | 1 WINTERFELL LN | 12/15/1854 | whitewolf@gmail.com
  4 | DONALD     | TRUMP       | 555 WHITEHOUSE  | 06/06/1906 | spraytansRus@whitehouse.com
  5 | BRUCE      | WILLIS      | 123 DIEHARD DR  | 01/04/1967 | johnmcclain@gmail.com
  2 | GERARDO    | CABRAL      | 123 DIEHARD DR  | 02/26/1989 | gerardo@gmail.com
  6 | GERARDO    | CABRAL      | 123 DIEHARD DR  | 10/03/1958 | gSR@gmail.com
(6 rows)

rolodex=# DELETE FROM persons WHERE address != '123 DIEHARD DR';
DELETE 3
rolodex=# SELECT * FROM persons;
 id | given_name | family_name |    address     |    dob     |         email
----+------------+-------------+----------------+------------+-----------------------
  5 | BRUCE      | WILLIS      | 123 DIEHARD DR | 01/04/1967 | johnmcclain@gmail.com
  2 | GERARDO    | CABRAL      | 123 DIEHARD DR | 02/26/1989 | gerardo@gmail.com
  6 | GERARDO    | CABRAL      | 123 DIEHARD DR | 10/03/1958 | gSR@gmail.com
(3 rows)

rolodex=# DELETE FROM persons WHERE family_name != 'CABRAL';
DELETE 1
rolodex=# SELECT * FROM persons;
 id | given_name | family_name |    address     |    dob     |       email
----+------------+-------------+----------------+------------+-------------------
  2 | GERARDO    | CABRAL      | 123 DIEHARD DR | 02/26/1989 | gerardo@gmail.com
  6 | GERARDO    | CABRAL      | 123 DIEHARD DR | 10/03/1958 | gSR@gmail.com
(2 rows)
__________________________________________________________________
 COUNTRY CLUB CHALLEGES
EPIC 1

-- this creates a table that has members information and links with bookings table
CREATE TABLE members (
  id serial PRIMARY KEY,
  surname varchar,
  first_name varchar,
  address varchar,
  zipcode integer,
  telephone varchar,
  recommended_by integer REFERENCES members(id),
  join_date timestamp without time zone
  );

-- this creates a table that has facility information and links from bookings table

CREATE TABLE facilities (id serial PRIMARY KEY, name varchar, member_cost numeric, guest_cost numeric, initial_out_lay numeric,
  monthly_maintenance numeric);

-- this creates a table for bookings and it links to both the members table and the facilities table
CREATE TABLE bookings (id serial PRIMARY Key, facility_id integer REFERENCES facilities(id), member_id integer REFERENCES members(id), start_time timestamp without time zone, slots integer);


EPIC 2
QUERY THE DATABASE USING JOINs ON THE FOREIGN KEYS


-- Produce a list of start times for bookings by members named 'David Farrell'?
--
-- Hint: Remember that a JOIN is selecting all records from Table A and Table B, where the join condition is met.


SELECT b.start_time FROM members m JOIN bookings b ON (m.id = b.id) WHERE m.surname = 'Farrell' AND m.first_name = 'David';

-- Produce a list of the start times for bookings for tennis courts, for the date '2016-09-21'? Return a list of start time and facility name pairings, ordered by the time.
-- Hint: In the WHERE clause use IN. See Example IN Operator

--used to find the booking dates for tennis courts 1 & 2 and ordered by time
SELECT start_time, name FROM facilities, bookings WHERE to_char(start_time, 'YYYY-MM-DD') IN ('2012-09-21') AND name LIKE 'Tennis Court %' ORDER BY start_time ASC;

-- used to find the list of start times and facility names ordered by time
SELECT start_time, name FROM facilities, bookings WHERE to_char(start_time, 'YYYY-MM-DD') IN ('2012-09-21', 'Tennis Court') ORDER BY start_time ASC;


-- Produce a list of all members who have used a tennis court? Include in your output the name of the court, and the name of the member formatted as first name, surname. Ensure no duplicate data, and order by the first name.

-- DISTINCT helps get rid of doubles to minimize search
SELECT DISTINCT
m.surname,
m.first_name,
f.name
FROM members m JOIN bookings b ON (m.id = b.member_id), bookings b_2 JOIN facilities f ON (b_2.facility_id = f.id)
WHERE f.name IN ('Tennis Court 1', 'Tennis Court 2')
ORDER BY m.first_name DESC;
