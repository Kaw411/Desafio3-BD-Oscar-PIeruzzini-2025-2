DROP DATABASE IF EXISTS tienda; 

CREATE DATABASE tienda CHARACTER SET utf8mb4;

USE tienda;

CREATE TABLE fabricante ( 
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
id int unsigned auto_increment primary key,
nombre varchar(100) not null,
precio DOUBLE NOT NULL,
id_fabricante int unsigned not null,
FOREIGN key (id_fabricante) references fabricante(id)
);

INSERT INTO fabricante values(1, 'Asus');
INSERT INTO fabricante values(2, 'Lenovo');
INSERT INTO fabricante values(3, 'Hewlett-Packard');
INSERT INTO fabricante values(4, 'Samsung');
INSERT INTO fabricante values(5, 'Seagate');
INSERT INTO fabricante values(6, 'Crucial');
INSERT INTO fabricante values(7, 'Gigabyte');
INSERT INTO fabricante values(8, 'Huawei');
INSERT INTO fabricante values(9, 'Xiaomi');

insert into producto values(1, 'Disco duro SATA3 1TB', 89.99, 5);
insert into producto values(2, 'Memoria RAM DDR4 8GB', 120, 6);
insert into producto values(3, 'Disco SSD 1TB', 150.99, 4); 
insert into producto values(4, 'GeForce GTX 1050Ti', 185, 7);
insert into producto values(5, 'GeForce GTX 1080 Xtreme', 755, 6);
insert into producto values(6, 'Monitor 24 LED FULL HD', 202, 1);
insert into producto values(7, 'Monitor 27 LED FULL HD', 245.99, 1);
insert into producto values(8, 'Portatil Yoga 520', 559, 2);
insert into producto values(9, 'Portatil Ideapd 320', 444, 2);
insert into producto values(10, 'Impresora HP Deskjet 3720', 59.99, 3);
insert into producto values(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

-- Consulta para la propiedad nombre en la tabla producto USAMOS SELECT
select nombre from producto;

-- Consultamos nombre y precio de la tabla producto con select pero con los dos atributos que nos interesa 
select nombre, precio from producto;

-- Consultamos todas las tablas de la lista producto
select * from producto; 

-- Consultamos el nombre de los productos pero con el precio en EUROS y en DOLARES (USD), utilizamos as para cambiar momentaneamente el nombre de la columna 
select nombre as NombreDeProducto, precio as PrecioEuros, precio*1.17 as PrecioDolar from producto;

-- Consultamos la lista de los nombres y los precios de todos los productos de la tabla producto pero en mayusculas los nombres 
select upper(nombre) as NombreMayus, precio from producto;

-- Consultamos la tabla producto y obtenemos los nombres en minuscula y los precios
select lower(nombre) as NombreMayus, precio from producto;

-- Obtenemos la lista de todos los fabricantes y en otra columna los dos primeros caracteres en mayusculas, usando left, en mayuscula y con un limite de 2 para que nos de los primeros 2 caracteres
select nombre, left(upper(nombre), 2) as PrimerosDos from fabricante;

-- Obtenemos nombre y precio redondeado de la tabla producto, usamos round()
select nombre, round(precio) from producto; 

-- Obtenemos ahora el nombre y precio pero sin decimales, usando truncate con 0 como argumento.  
select nombre, truncate(precio, 0) from producto;

-- Obtenemos la lista del identificador de los fabricantes que tienen producto en la tabla de producto de una vez filtrada sin repeticiones 
select id from fabricante where id in (select id_fabricante from producto); 

-- Obtenemos la lista de los nombres de los fabricantes ordenados de forma ascendente 
select nombre from fabricante order by nombre asc;

-- Ahora de forma descendente 
select nombre from fabricante order by nombre desc;

-- Obtenemos los nombres de los productos ordenados primero por nombre ascendente y luego por precio de forma descendente
select nombre, precio from producto order by nombre asc, precio desc; 

-- obtenemos la lista con las primeras 5 filas de la tabla fabricante
select * from fabricante limit 5;

-- Calculamos el número total de productos que hay en la tabla productos usamos la funcion COUNT()
select count(*) as NroProductosTOTAL from producto;

-- Calculamos el número total de fabricantes que hay en la tabla fabricante igualmente con la funcion COUNT()
select count(*) as NroFabricantesTotal from fabricante; 

-- Calculamos el número de valores distintos de identificador de fabricante aparecen en la tabla productos haciendo uso de la propiedad de funcion distinct.
select count(distinct id_fabricante) as NroFabricantesDistintos from producto;

-- calculamos la media de precios de los productos haciendo uso de la funcion AVG() "average"
select avg(precio) from producto;

-- calculamos ahora el precio mas barato y el precio mas caro de todos los productos haciendo uso de las funciones max y min 
select min(precio) from producto;
select max(precio) from producto;

-- listamos ahora el nombre que acompana al precio mas barato y el mas caro 
select nombre, precio from producto where precio = (select min(precio) from producto); 

select nombre, precio from producto where precio = (select max(precio) from producto); 

-- listamos la suma de los precios en la tabla producto con la funcion SUM  
select sum(precio) from producto; 

-- calculamos el numero de productos que tiene el fabricante ASUS usando count pero con clausula WHERE para asus = 1
select count(id_fabricante) from producto where id_fabricante = (1); 

-- calculamos ahora la media de esos productos con la clausula WHERE 
select avg(precio) from producto where id_fabricante = (1);

-- calculamos ahora el precio mas barato de esos dos productos usando unicamente min(), y dejando la restriccion del where
select min(precio) from producto where id_fabricante = (1);

-- de forma similar para el precio mas caro pero usando max()
select max(precio) from producto where id_fabricante = (1); 

-- seguimos con la misma logica pero calculamos la suma sum() de asus 
select sum(precio) from producto where id_fabricante = (1);

-- por ultimo calculamos el precio minimo, maximo, promedio y la cantidad de productos del fabricante CRUCIAL (id fabricante = 6) usando las funciones ya vistas, pero mostrando todo en una sola consulta, de forma tal que la clausula WHERE condicione las 4 operaciones al mismo tiempo
select min(precio), max(precio), avg(precio), count(id_fabricante) from producto where id_fabricante = (6); 

