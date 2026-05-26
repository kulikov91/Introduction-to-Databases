--1
CREATE TABLESPACE my_tablespace1
OWNER postgres
LOCATION '/Library/PostgreSQL/18';

--2
CREATE DATABASE my_bd
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'C'
    LC_CTYPE = 'C'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = my_tablespace1
    CONNECTION LIMIT = 10
    IS_TEMPLATE = False;

--3
CREATE TABLE my_table1 (column1 int, column2 bigint);

--4
CREATE TABLE my_table2 (column1 int, column2 bigint) TABLESPACE pg_default; --Если предположить, что мы в табличном пространстве pg_ddefault, то TABLESPACE pg_default после скобок можно опустить. 

--5
ALTER TABLE my_table1 SET TABLESPACE pg_default;