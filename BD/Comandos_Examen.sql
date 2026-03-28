-- Comando para crear una base de datos
CREATE DATABASE ecommerce_matricula;  /* colocar su matrícula*/

-- Comando para activar el uso de la base creada
USE ecommerce_matricula;

-- Comando para crear una tabla 

CREATE TABLE clientes (
  id INT unsigned primary key auto_increment,
  nombres VARCHAR(100) not null,  
  apellido_paterno VARCHAR(100) not null,
  apellido_materno VARCHAR(100), 
  fecha_nacimiento date not null, 
  genero ENUM("F", "M","N/B") not null DEFAULT "N/B",
  estatus ENUM("Activo", "Inactivo", "Bloqueado") not null DEFAULT 'Activo',
  fecha_registro DATETIME default NOW(),
  tipo_fiscal ENUM ("Persona Física", "Personal Moral", "N/A") 
  NOT NULL DEFAULT 'N/A',
  RFC CHAR(13));
  
  
  -- Comando para insertar nuevos datos en nuestra tabla creada usando INSERT
 -- 9 cols - 9 date
 INSERT clientes VALUES(default,"Marco Antonio","Ramírez", 
 "Hernández", "1988/07/16", "M",default,default,default,NULL);
 INSERT clientes VALUES(default,"Olga","Mejía", 
 "Romero", "2003/05/05", "F",default,default,default,NULL);

-- Estos datos no serán insertados dado que el género tiene un valor no permitido
 INSERT clientes VALUES(default,"Francisco","Calva", 
 "Álvarez", "1970/01/12", "Perro",default,default,default,NULL); 
 
 
-- Variacion del comando insert enviando solo los datos 
-- obligatorios sin valor por defecto (default)
 INSERT INTO clientes(nombres,apellido_Paterno, fecha_nacimiento) 
 VALUES ("Juan","Pérez","2004/08/04");
 
 
 -- Variación del comando insert enviando los datos en un orden diferente
 -- al definido en las columnas de la tabla
 INSERT INTO clientes(apellido_paterno, apellido_materno,nombres, genero,
 fecha_nacimiento) VALUES ("Rodríguez", "Gutiérrez", "Angélica", "F", "2009/03/02");
 
  
 -- Comandos del 13/01/2026 
 
 -- Crear la tabla de PROVEEDORES
 
 USE ecommerce_matricula;
 
 CREATE TABLE proveedores (
 id int unsigned primary key auto_increment,
 persona_id int unsigned not null, 
 tipo enum("Mayoreo", "Menudeo", "Mixto") not null default "Menudeo",
 estatus enum("Activo", "Inactivo", "Bloqueado", "No vigente") not null 
 default "Activo",
 fecha_registro DATETIME not null default now(),
 total_productos INT not null default 0,
 monto_acumulado FLOAT not null default 0.0, 
 fecha_ultima_compra DATETIME);
 
-- INSERTAMOS DATOS DE PRUEBA  
-- Supongamos que nuestro proveedor es tiene el numero de persona 52, que nos surte
-- 150 productos diferentes y que le hemos comprado $355,000.00 pesos y la fecha de
-- la última compra se la realizamos el 28 de Diciembre de 2025

INSERT INTO proveedores VALUES 
 (DEFAULT, 52, "Mayoreo", "Activo", DEFAULT,150, 350000.00, "2025/12/28");
 
 
-- Verificamos que ha sido insertado
SELECT * FROM proveedores;



-- Creación de la Tabla PERSONAS

CREATE TABLE personas (
id int unsigned primary key auto_increment,
tipo enum("Física", "Moral") not null default "Física",
fecha_registro DATETIME not null default now(),
estatus enum("Activo", "Inactivo", "No vigente") default "Activo",
rfc CHAR(13),
nacionalidad VARCHAR(50));

-- CREACIÓN DE LA TABLA PERSONA FÍSICA
CREATE TABLE persona_fisica(
id int unsigned not null,
titulo_cortesia VARCHAR(20), 
nombre VARCHAR(60) not null,
primer_apellido VARCHAR(60) not null, 
segundo_apellido VARCHAR(60) not null, 
fecha_nacimiento DATE not null,
genero ENUM("F", "M", "N/B"),
CONSTRAINT fk_persona_fisica FOREIGN KEY (id) REFERENCES personas(id));		

-- CREACIÓN DE LA TABLA PERSONA MORAL

use ecommerce_230173;
create table persona_moral(
id int unsigned not null,
razon_social varchar(200) not null,
tipo varchar(100) not null,
fecha_registro datetime not null default now(),
fecha_creación date not null,
estatus enum("Activa", "Inactiva", "No Vigente", "Clausurada") not null default "Activa",
responsabilidad varchar(100),
capacidad_juridica varchar(100),
patrimonio varchar(100),
constraint fk_persona_moral foreign key (id) references personas(id));

-- como ya tenemos definidos los datos de las personas morales y fisicas, tenemos que actualizar nuestra tabla clientes por que las columnas de nombre, apllido, fecha de nacimiento se movieron a la tabla de persona

alter table clientes
drop column nombres,
drop column apellido_paterno,
drop column apellido_materno,
drop column fecha_nacimiento,
drop column genero;

alter table clientes
drop column RFC;

alter table clientes
drop column tipo_fiscal;

truncate clientes; -- este comando elimina todos los datos de la tabla resetendo sus llaves primarias y es necesario porque no podemos agregar llaves foraneas sin la tabla tiene datos

alter table clientes
add column persona_id int unsigned not null after id,
add constraint fk_persona foreign key (persona_id) references personas (id),
add column tipo_frecuencia enum("Frecuente", "Ocacional", "Exporadico", "Mayorista", "Nuevo", "No definido") not null default "No definido" after persona_id,
add column monto_acumulado_compras double default 0.0 after tipo_frecuencia;

-- población de 5 clientes: 3 clientes que son personas fisica y 2 persona moral
-- Paso 1
insert into personas values
(default, "Fisica", default, default, null, "Mexicana"),
(default, "Fisica", default, default, null, "Mexicana"),
(default, "Fisica", default, default, null, "Norteamericana"),
(default, "Moral", default, default, null, "Mexicana"),
(default, "Moral", default, default, null, "Española");
-- paso 2: regsitrar los datos personales o empresariales
insert into persona_fisica values
(1, "T.S.U.", "Samuel", "Galindo", "Vaquier", "2005/09/01", "M"),
(2, null, "Carlos Eduardo", "Galindo", "Vaquier", "2007/11/23", "M"),
(3, "Dr.", "Oscar", "Huerta", null, "1970/12/10", "M");
insert into persona_moral values
(4, "Grupo Bimbo, S.A.B. de C.V.", "Sociedad Anonima Bursatil", DEFAULT, "1945/12/02", default, "Limitada para Accionistas", "Plena", "4,300,000,000.00 MXN"),
(5, "ZARA ESPAÑA SA", "Sociedad Anonima", DEFAULT, "1974/12/24", default, "Limitada para Accionistas", "Plena", "$5,500.00 E");

use ecommerce_230173;
insert into clientes values
(default, 1, default, default, default, default),
(default, 3, default, default, default, default),
(default, 4, default, default, default, default);

-- Como podemos observar los datos de cliente se encuentran en diferentes tablas, eb la tabla persona, estan los datos del tipo generales de ambos tipos fisica y moral, en la tabla de personas fisica o moral estan los datos propios de la persona y en la de clientes, pero como puede unirlos para poder verificar que estan correctos?
-- La respuesta es utilizar consultas multitablas (JOIN) que nos permita vincular datos que compraten llaves foraneas que para este caso es el id de la persona

-- Datos los clientes que son personas fisicas
select "Cliente", personas.tipo, persona_fisica.nombre, persona_fisica.primer_apellido, persona_fisica.segundo_apellido, persona_fisica.fecha_nacimiento, persona_fisica.genero, clientes.tipo_frecuencia
from personas
join clientes on personas.id = clientes.persona_id
join persona_fisica on personas.id = persona_fisica.id;

-- Datos los clientes que son personas morales
select "Cliente", personas.tipo, persona_moral.razon_social, persona_moral.tipo, persona_moral.fecha_creación, clientes.tipo_frecuencia
from personas
join clientes on personas.id = clientes.persona_id
join persona_moral on personas.id = persona_moral.id;

-- Uniendo las dos consultas para tener un solo listado de clientes importando el tipo
(select "Cliente", personas.tipo as "TipoPersona",
concat_ws( "", persona_fisica.titulo_cortesia, persona_fisica.nombre,
persona_fisica.primer_apellido, persona_fisica.segundo_apellido)
as "Nombre/RazonSocial",
persona_fisica.fecha_nacimiento as "Fecha Nacimiento/Registro",
persona_fisica.genero as "Genero", clientes.tipo_frecuencia as "Tipo Frecuencia"
from personas
join clientes on personas.id = clientes.persona_id
join persona_fisica on personas.id = persona_fisica.id)
union
(select "Cliente", personas.tipo, persona_moral.razon_social,
persona_moral.fecha_creación, persona_moral.tipo, clientes.tipo_frecuencia
from personas
join clientes on personas.id = clientes.persona_id
join persona_moral on personas.id = persona_moral.id);

-- iNSERTAR PROVEDORES
-- Para este ejercio simularemos que nuestra persona moral 5 y nustra persona fisica 2 serán proveedores de nuetro ecommerce
insert into proveedores values
(default, 2, "Mixto", default, default, default,default, null),
(default, 5, "Mayoreo", default, default, default,default, null);

(select "Cliente" as "Cliente/Proveedor", personas.tipo as "Tipo Persona",
concat_ws( " ", persona_fisica.titulo_cortesia, persona_fisica.nombre,
persona_fisica.primer_apellido, persona_fisica.segundo_apellido)
as "Nombre/RazonSocial",
persona_fisica.fecha_nacimiento as "Fecha Nacimiento/ Fecha Creación",
persona_fisica.genero as "Genero", clientes.tipo_frecuencia as "Tipo Frecuencia"
from personas
join clientes on personas.id = clientes.persona_id
join persona_fisica on personas.id = persona_fisica.id)
union
(select "Cliente", personas.tipo, persona_moral.razon_social,
persona_moral.fecha_creación, persona_moral.tipo, clientes.tipo_frecuencia
from personas
join clientes on personas.id = clientes.persona_id
join persona_moral on personas.id = persona_moral.id)
union
(select "Proveedor" as "Cliente/Proveedor", personas.tipo as "Tipo Persona",
concat_ws(" ", persona_fisica.titulo_cortesia, persona_fisica.nombre,
persona_fisica.primer_apellido, persona_fisica.segundo_apellido)
as "Nombre/Razón Social",
persona_fisica.fecha_nacimiento as "Fecha Nacimiento/ Fecha Creación",
persona_fisica.genero as "Genero", proveedores.tipo as "Tipo"
from personas
join proveedores on personas.id = proveedores.persona_id
join persona_fisica on personas.id = persona_fisica.id)
union
(select "Proveedor", personas.tipo, persona_moral.razon_social,
persona_moral.fecha_creación, persona_moral.tipo,
proveedores.tipo
from personas
join proveedores on personas.id = proveedores.persona_id
join persona_moral on personas.id = persona_moral.id);

-- Crear tabla para las categorias de los productos
create table categorias(
id int unsigned not null primary key auto_increment,
nombre varchar (100) not null, -- 1024 caracteres
descripcion text, -- no tien limite de tamaño
fecha_registro datetime not null default now(),
estatus enum("Activa", "Inactiva", "No Vigente", "Cancelada") not null default "Activa",
total_productos int not null default 0,
categoria_padre_id int unsigned,
constraint fk_categoria_padre foreign key (categoria_padre_id) references categorias (id));

-- Poblamos la tabla de categorias con 10 categorias, 4 padre y 6 sub categorias
insert into categorias values
(default,"Ropa", "Productos Textiles para toda la familia", default, default, default, null),
(default,"Accesorios", "Aditamiento para acompañar la moda textil", default, default, default, null),
(default,"Perfumeria", "Fragancias para todos los generos", default, default, default, null),
(default,"Zapateria", "Productos de calzado para toda la familia", default, default, default, null);

-- Sub categorias
insert into categorias values
(default,"Mujeres", "Prendas Textiles recomendadas para el genero femenino", default, default, default, 1),
(default,"Hombres", "Prendas Textiles recomendadas para el genero masculino", default, default, default, 1),
(default,"Niños", "Prendas Textiles recomendadas para niños 3 a 18", default, default, default, 1),
(default,"Niñas", "Prendas Textiles recomendadas para niñas 3 a 18", default, default, default, 1),
(default,"Bebes", "Prendas Textiles recomendadas para bebes unisex 0 a 36 meses", default, default, default, 1),
(default,"Nacional", "Perfumes de origen Mexicano", default, default, default, 3),
(default,"Importaciones", "Productos originarios de otros paises ", default, default, default, 3);

-- Creamos la tabla de productos
create table productos (
id int unsigned primary key auto_increment,
nombre varchar (150) not null,
descripcion text,
marca varchar (100) not null,
modelo varchar (100),
precio_menudeo decimal (10,2) not null default 0.0,
precio_mayoreo decimal (10,2),
tipo enum("Perecedero", "No perecedero") not null default "No perecedero",
estatus enum ("Activo", "Agostado", "En existencia", "Descontinuado", "Baja existencia") not null default "Activo",
codigo_barras varchar(40) not null unique, -- define que no hara 2 productos con el codigo
SKU varchar (40) not null unique);

-- Para poder asociar los productos a las categorias, dado que un producto puede pertenecer a muchas categorias
-- requerimientos contuir un tabla derivada para poder controlar que productos pertenecen a que categoria

create table productos_categoria (
 categoria_id int unsigned not null,
 producto_id int unsigned not null,
 estatus enum("Activo", "Inactivo"),
 fecha_registro datetime default now(),
 constraint fk_categoria foreign key (categoria_id) references categorias(id),
 constraint fk_producto foreign key (producto_id) references productos(id));
 
 -- Poblamos 5 productos para la Botique
 insert into productos values
 (default, "Gabardina de Pana","Prenda diseñada para crear una combinacion de elegancia, confort y funcionalidad", "Zara", "INV-F230", "600", "540.00", default, default, "OUT-PAN-GAB-26-001", "750260000017");
 
 insert into productos values
 (default, "Hoddie Unisex", "Por definir", "Under Armor", "UA4612", 450.00, NULL, default, DEFAULT, "COD01", "SKU-01"),
 (default, "Polo Sport 125ml", "Por definir", "Ralph Lauren", "UA4613", 1599.00, NULL, default, DEFAULT, "COD02", "SKU-0"),
 (default, "Bufanda Chunky y Flecos", "Por definir", "Zara", "ZR34A3", 650.00, NULL, default, DEFAULT, "COD03", "SKU-03"),
 (default, "Boxer Plegado Cballero", "Por definir", "Under Armor", "UA5248", 732.00, NULL, default, DEFAULT, "COD04", "SKU-04");

-- Asociamos los productos a su categoria o categorias correspondientes para ello necesitamos poblar la tabla de productos_categporias
-- Para el producto 1, que es la gabardina sabemos que es una Prenda por la que pertenece a la categoria de ropa, al no decir genero se deduce que es unisex, por lo que estará asociado a la categoria padre "Ropa"
insert into productos_categoria values
(1,1,default, default);

-- Como no se tenia definido el estatus por defecto, este deverá ser actualizado de manera manual

-- Para el producto 2  que de igual manera no tine genero o edad definido la asociaremos a la categoria ropa
insert into productos_categoria values
(1,2,default, default);

-- Para el producto con id 3 en la fragancia de Polo Sport, es de la categori de Perfumeria (3)
insert into productos_categoria values
(3,3,default, default);

-- Para el producto de id 4 la Buffanda se´ra agregada para la categoria 2 (Accesorios)
insert into productos_categoria values
(2,4,default, default);

-- Para el producto 5 Boxer para Cballero, será el primer productos que asociaremos a 2 categorias, 1 ropa(1) y 2 Caballeros(6)
insert into productos_categoria values
(1,5,default, default),
(6,5,default, default);

-- Para poder cruzar informacuión a partir de llaves foraneas y poder conocer el nombre del producto la marac, el precio y su categoria volvemos a usar (join) que nos permite juntar datos de tablas diferentes que comprten una llave

select p.nombre, p.marca, p.precio_menudeo, c.nombre
from productos p
join productos_categoria pc on pc.producto_id = p.id
join categorias c on pc.categoria_id = c.id
order by c.nombre, p.nombre;

-- Para comensar con el tema de compras / ventas t demás proxcesos de comercio necesitaremos tener un un usuario al cual asociar estas actividades, sobretodo si pensamos en el ecommerce se realiza a traves de aplicaciones web, moviles de voz
-- Constriccion de la tabla de usuarios
create table usuarios (
id int unsigned primary key auto_increment,
persona_fisica_id int unsigned not null,
contrasena  varchar (300) not null,
fecha_registro datetime not null default now(),
fecha_ingreso datetime,
estatus enum("Activo", "Inactivo", "Bloqueado", "Cancelado") not null default "Activo",
constraint  fk_persona_fisica2 foreign key (persona_fisica_id) references persona_fisica(id));

-- Poblacion de tabala productos con los 20 productos (ropa para hombre) pertenientes a las categorias hombre y ropa
insert into productos values
 (default, "Pantalones Cortos Launch Run", "¿Qué necesitas de tus pantalones cortos para correr? Necesitan ser ligeros y elásticos para que te muevas, y tienen un forro para mantenerte seco. Listo. La tela tejida es ligera, cómoda y duradera. El forro interno de malla proporciona mayor cobertura y apoyo. El material absorbe el sudor y se seca muy rápido. Paneles de malla súper transpirables que proporcionan una mejor ventilación. Cintura de punto suave con cordón interno para máxima comodidad y un ajuste seguro. Bolsillos abiertos para las manos con bolsillo interno derecho para el teléfono. La tela del cuerpo principal contiene al menos un 90% de poliéster reciclado, excluyendo adornos y adornos. Logotipo reflectante. Entrepierna: 7 pulgadas. Bolsillos: sí. 100% poliéster.", "Under Armor", "MOD-TSH-A01", 401.92, NULL, default, DEFAULT, "7501234567001", "HM-TSH-001"),
 (default, "Conjunto de Playa de Verano", "Este conjunto vacacional para hombre está confeccionado en tela de lino de alta calidad, transpirable, ligera, microelástica, antiarrugas y absorbe la humedad, manteniéndote fresco y relajado todo el día.", "VIOPY", "MOD-JNS-B02", 267.23, NULL, default, DEFAULT, "7501234567018", "HM-JNS-002"),
 (default, "Camiseta Henley de Algodón y Lino", "Camisa de lino para hombre confeccionada con tela ligera, transpirable y suave al tacto, que no se encoge ni se decolora. Su diseño elegante de cuello Henley, corte slim fit y mangas largas enrollables la hace moderna y versátil. Es fácil de combinar con jeans, chinos o pantalones de vestir y es ideal para uso casual, trabajo o eventos informales en primavera y verano.", "COOFANDY", "MOD-CHQ-C03", 359.10, NULL, default, DEFAULT, "7501234567025", "HM-CHQ-003"),
 (default, "Playera Polo para Hombre Hollywood Knitted Polo", "La John Leopard Knitted Polo es una prenda imprescindible en el armario de cualquier hombre que valora la moda y la funcionalidad. Fabricada con materiales de alta calidad, ideal para quienes buscan una opción versátil para múltiples ocasiones. La tela, confeccionada 100% en bambú, ofrece una suavidad incomparable y es increíblemente ligera, perfecta para usar en cualquier época del año. El diseño ajustado y moderno en talla S proporciona un ajuste cómodo y elegante, permitiéndote lucir bien sin sacrificar la comodidad. El cuello clásico con botones refuerza el look formal, pero su versatilidad también permite llevarla con pantalones casuales, chinos o incluso jeans, brindando múltiples opciones de estilo. Cada polo está cuidadosamente diseñado para resistir el desgaste diario, manteniendo su forma y color lavado tras lavado. Además, su diseño inspirado en Hollywood aporta un aire de elegancia atemporal, perfecto para hombres con un gusto refinado en moda. Ya sea que la uses para un evento formal, una salida casual o una reunión, la John Leopard Knitted Polo te asegura que siempre estarás a la altura. Gracias a su fácil mantenimiento y durabilidad, esta prenda es perfecta para quienes buscan una inversión a largo plazo en su guardarropa. No importa la ocasión, la John Leopard Knitted Polo será tu primera elección.", "JOHN LEOPARD", "MOD-SWT-D04", 549.00, NULL, default, DEFAULT, "7501234567032", "HM-SWT-004"),
 (default, "Polo de algodón a rayas para hombre", "Este polo está hecho con material de buena calidad y diseñado para durar.", "Funny World", "MOD-PNT-E05", 491.23, NULL, default, DEFAULT, "7501234567049", "HM-PNT-005"),
 (default, "Abrigo Cálido a Prueba De Viento", "Chaqueta impermeable y térmica diseñada para mantenerte caliente, seco y cómodo en actividades al aire libre, fabricada con materiales resistentes y elásticos que ofrecen alta impermeabilidad y buena transpirabilidad; cuenta con forro polar, múltiples bolsillos funcionales, capucha protectora y ajustes en puños y cintura, lo que la hace ideal para senderismo, camping, esquí, trabajo y aventuras en cualquier clima.", "LAULY", "MOD-JKT-F06", 445.00, NULL, default, DEFAULT, "7501234567056", "HM-JKT-006"),
 (default, "Chamarra Para Hombre Chaqueta Piel Sintética Con Forro Polar Slim Fit", "Chamarra de moda casual. Mezcla perfecta y combina con pantalones y bermudas de mezclilla o de gabardina de colores, elegantes y clásicas. ", "Bobois", "MOD-TSH-G07", 1599.00, NULL, default, DEFAULT, "7501234567063", "HM-TSH-007"),
 (default, "Sudadera de vellón de manga larga con cuello redondo para hombre", "Amazon Essentials se centra en crear ropa de uso diario, accesible, de alta calidad y duradera. Nuestra línea de imprescindibles para hombre incluye camisas polo, pantalones chinos, shorts clásicos, camisas y camisetas de cuello redondo. Nuestro tamaño consistente elimina la incertudumbre durante las compras, y cada pieza se pone a prueba para mantener los más altos estándares de calidad y comodidad.", "Amazon Essentials", "MOD-JNS-H08", 367.59, NULL, default, DEFAULT, "7501234567070", "HM-JNS-008"),
 (default, "Suéter de retazos", "Suéter para hombre con diseño de bloqueo de color que aporta un estilo moderno y rompe con lo tradicional, ideal para crear combinaciones versátiles con camisas, chaquetas, pantalones o jeans. Es suave al tacto, transpirable y de ajuste regular con ligera elasticidad, ofreciendo comodidad durante todo el día; se recomienda lavar a mano en agua fría y secar en plano para conservar su calidad.", "GURUNVANI", "MOD-CHQ-I09", 720.39, NULL, default, DEFAULT, "7501234567087", "HM-CHQ-009"),
 (default, "Calzoncillos Tipo Calzones elásticos de algodón para Hombre", "Un icono de Calvin Klein. El calzoncillo de diseñador esencial reinventado en algodón elástico extra suave. Fabricado con absorción para mantenerte fresco y seco. Diseñado con la cintura original del logotipo de Calvin Klein, este es un aspecto deportivo que se siente sexy todos los días. Con una bolsa de apoyo y una línea de pierna más larga, este es nuestro estilo más vendido.", "Calvin Klein", "MOD-SWT-J10", 1332.00, NULL, default, DEFAULT, "7501234567094", "HM-SWT-010"),
 (default, "Calzoncillos Tipo Calzones de algodón elástico para Hombre", "Calzoncillos para hombre confeccionados en algodón elástico (95% algodón y 5% elastano) que ofrecen una sensación suave y cómoda, con interior cepillado en la cintura para evitar irritaciones. Cuentan con cintura elástica con logotipo Lacoste, pierna de longitud extendida para un ajuste seguro y soporte sin molestias; se recomienda pedir una talla más grande, son lavables a máquina y de fácil cuidado para el uso diario.", "Lacoste", "MOD-PNT-K11", 687.48, NULL, default, DEFAULT, "7501234567100", "HM-PNT-011"),
 (default, "Calzoncillos Calzones Megapack de algodón para Ropa Interior", "Calzoncillos tipo calzones de algodón peinado suave en un ajuste cómodo de la clásica ropa interior estadounidense Tommy Hilfiger.", "Tommy Hilfiger", "MOD-JKT-L12", 1042.59, NULL, default, DEFAULT, "7501234567117", "HM-JKT-012"),
 (default, "Pijama para Hombre", "Pijama para hombre confeccionada en 100% algodón orgánico certificado GOTS, ideal para climas cálidos gracias a su tejido transpirable que reduce la humedad y brinda frescura durante la noche. Su diseño funcional incluye costuras planas, cintura elástica ajustable, bolsillos laterales reforzados y corte recto para mayor comodidad. Es resistente a múltiples lavados, de secado rápido y versátil para dormir, descansar en casa, viajes cortos o actividades ligeras, con guía de tallas precisa y fácil mantenimiento.", "BigKing", "MOD-TSH-M13", 399.99, NULL, default, DEFAULT, "7501234567124", "HM-TSH-013"),
 (default, "Pijama de algodón 100% para hombre, con botones, manga corta y pantalones de dormir", "conjunto de pijama para hombre está hecho de 100% algodón. El pijama de algodón es suave, transpirable, agradable al tacto y duradero, lo que te proporciona una cómoda experiencia de ropa de dormir para hombre durante todo el añoCamisetas de manga corta: pijama de manga corta elegante para hombre con cuello abotonado para un aspecto clásico. El bolsillo en el pecho para el atractivo atemporal de los estilos de camisa de vestir. El diseño de ribetes de contraste añade un único, moderno y de alto grado", "COLORFULLEAF", "MOD-JNS-N14", 786.61, NULL, default, DEFAULT, "7501234567131", "HM-JNS-014"),
 (default, "Shorts de Pana Hombre Casual Pantalones Cortos Cargo Deportivos Cintura Elástica con Bolsillos Versátil", "Estos pantalones cortos de pana de hombre están hechos de 100% poliéster, suave y agradable a la piel, ligero y transpirable, que es una gran opción para los pantalones cortos de verano, con lo que la comodidad durante todo el día.", "LECOONMX", "MOD-CHQ-O15", 395.00, NULL, default, DEFAULT, "7501234567148", "HM-CHQ-015"),
 (default, "Chaqueta de forro polar de manga larga para hombre", "Esta chaqueta de forro polar de peso medio cuenta con dos bolsillos ribeteados y dos bolsillos con solapa en el pecho con cierre de botón.", "Amazon Essentials", "MOD-SWT-P16", 591.90, NULL, default, DEFAULT, "7501234567155", "HM-SWT-016"),
 (default, "Jeans Skinny Taper Hombre, Corte Clásico", "Pantalón, de mezclilla, skinny cintura media, corte ajustado en cadera y muslos. 81% algodón 17% polyester 2% elastano.", "Levi's", "MOD-PNT-Q17", 1082.92, NULL, default, DEFAULT, "7501234567162", "HM-PNT-017"),
 (default, "Aero Cargo Jogger Pant Pantalones Hombre", "Ofrece un aspecto resistente y un ajuste cómodo que te encanta.", "Aeropostale", "MOD-JKT-R18", 508.92, NULL, default, DEFAULT, "7501234567179", "HM-JKT-018"),
 (default, "Pantalones deportivos ajustados", "Pantalón deportivo de entrepierna de 28 pulgadas con diseño cónico y ajuste moderno, que se adapta cómodamente al cuerpo gracias a su cintura y tobillos elásticos. Está confeccionado con material ligero y elástico que facilita el movimiento durante el ejercicio, resalta la forma de las piernas y ofrece bolsillos prácticos para llevar objetos personales; se recomienda consultar la tabla de tallas y elegir la talla más pequeña si estás entre dos opciones.", "GINGTTO", "MOD-TSH-S19", 721.18, NULL, default, DEFAULT, "7501234567186", "HM-TSH-019"),
 (default, "Camisas Hombre Manga Corta Bolsillos Dobles Camisas para Hombre De Trabajo Botones Camisa Algodón Hombre Casual", "Camisa de manga corta para hombre Dubinik confeccionada en una mezcla de algodón y elastano que ofrece suavidad, transpirabilidad y elasticidad para una comodidad duradera. Presenta un diseño clásico de color sólido con botonadura frontal y bolsillos en el pecho, cuidada artesanía y ajuste preciso, ideal para primavera, verano y otoño. Es fácil de cuidar y perfecta para trabajo, viajes, reuniones o uso casual, con opción de elegir una talla más grande si se prefiere un ajuste holgado.", "Dubinik", "MOD-JNS-T20", 750.99, NULL, default, DEFAULT, "7501234567193", "HM-JNS-020");

-- Asignacion de categorias refrentes a los productos
insert into productos_categoria values
(1,6,default, default),
(1,7,default, default),
(1,8,default, default),
(1,9,default, default),
(1,10,default, default),
(1,11,default, default),
(1,12,default, default),
(1,13,default, default),
(1,14,default, default),
(1,15,default, default),
(1,16,default, default),
(1,17,default, default),
(1,18,default, default),
(1,19,default, default),
(1,20,default, default),
(1,21,default, default),
(1,22,default, default),
(1,23,default, default),
(1,24,default, default),
(1,25,default, default);

-- Crearemos un tabla BITACORA para llevar un registro de los cambios que sufre nuestros registros en la base de datos
create table bitacora (
id int unsigned primary key auto_increment,
tabla varchar(100) not null,
operacion enum("Insert", "Delete", "Update") not null,
usuario varchar(100) not null,
descripcion text,
fecha_hora datetime default now());

-- Insertamos un producto para verificar que el trigger funciona
insert into productos values (default, "Rompevientos para Dama", "Descripcion larga", "SHEIN", null, 549.50, null, "No perecedero", default, "KJHWEIRIU235255", "st2309201543181077");

-- 50 persona fisicas
insert into personas values
(default, "Fisica", default, default, "GASM980412A12", "MX"),
(default, "Fisica", default, default, "ROLM010923B45", "CO"),
(default, "Fisica", default, default, "HERC950305C78", "MX"),
(default, "Fisica", default, default, "JUPA020714D91", "AR"),
(default, "Fisica", default, default, "MAVA990821E33", "MX"),
(default, "Fisica", default, default, "COGL970110F56", "PE"),
(default, "Fisica", default, default, "AOMR040618G87", "MX"),
(default, "Fisica", default, default, "LOMA930902H19", "CL"),
(default, "Fisica", default, default, "FEHG880327J42", "ES"),
(default, "Fisica", default, default, "PEVR000514K64", "MX"),
(default, "Fisica", default, default, "RACT960830L85", "VE"),
(default, "Fisica", default, default, "SAMA030119M07", "MX"),
(default, "Fisica", default, default, "DOLC920406N28", "PE"),
(default, "Fisica", default, default, "COGL970110F56", "MX"),
(default, "Fisica", default, default, "NAGF010225P59", "CO"),
(default, "Fisica", default, default, "JUCM980911Q81", "MX"),
(default, "Fisica", default, default, "BEPR950703R14", "AR"),
(default, "Fisica", default, default, "MIAL040829S36", "MX"),
(default, "Fisica", default, default, "ALNU970504U79", "CL"),
(default, "Fisica", default, default, "YAZC020930V91", "EC"),
(default, "Fisica", default, default, "LUFM940812W23", "MX"),
(default, "Fisica", default, default, "ANRS010405X45", "GT"),
(default, "Fisica", default, default, "EDSM930726Y67", "MX"),
(default, "Fisica", default, default, "ITPG000118Z89", "CR"),
(default, "Fisica", default, default, "ROBM970909A10", "MX"),
(default, "Fisica", default, default, "LECV050222B32", "VE"),
(default, "Fisica", default, default, "ARHG910611C54", "MX"),
(default, "Fisica", default, default, "DAFR030918D76", "ES"),
(default, "Fisica", default, default, "OSCM890124E98", "MX"),
(default, "Fisica", default, default, "PATR020507F20", "PE"),
(default, "Fisica", default, default, "IVGS960314G41", "AR"),
(default, "Fisica", default, default, "XIME040801H63", "MX"),
(default, "Fisica", default, default, "JOSB920429J85", "CO"),
(default, "Fisica", default, default, "RACA010915K07", "MX"),
(default, "Fisica", default, default, "ELVM880606L29", "CL"),
(default, "Fisica", default, default, "NORM990721M50", "VE"),
(default, "Fisica", default, default, "MATO950110N72", "MX"),
(default, "Fisica", default, default, "ALEG030327P94", "EC"),
(default, "Fisica", default, default, "CESR910918Q16", "MX"),
(default, "Fisica", default, default, "LUPA980802R38", "PE"),
(default, "Fisica", default, default, "MELS970119T82", "MX"),
(default, "Fisica", default, default, "VICT920930U03", "CO"),
(default, "Fisica", default, default, "ILPR050214V25", "AR"),
(default, "Fisica", default, default, "SAMG990605W47", "MX"),
(default, "Fisica", default, default, "JEAR010821X69", "CR"),
(default, "Fisica", default, default, "TOMH930308Y80", "MX"),
(default, "Fisica", default, default, "MACT970415A11", "VE"),
(default, "Fisica", default, default, "JUPR020908B34", "ES"),
(default, "Fisica", default, default, "ARHJ010309E42", "MX"),
(default, "Fisica", default, default, "ARHJ010309E42", "CO");

insert into persona_fisica values
(1, "Ing.", "Gabriel", "Sánchez", "Martínez", "1998/04/12", "M"),
(2, "Lic.", "Rosa", "López", "Morales", "2001/09/23", "F"),
(3, "TSU.", "Héctor", "Ramírez", "Cruz", "1995/03/05", "M"),
(4, "Srta.", "Julia", "Pérez", "Aguilar", "2002/07/14", "F"),
(5, "Mtro.", "Manuel", "Vázquez", "Arias", "1999/08/21", "M"),
(6, "Ing.", "Carlos", "Gómez", "Luna", "1997/01/10", "M"),
(7, "TSU.", "Andrea", "Ortiz", "Muñoz", "1995/03/05", "F"),
(8, "Mtra.", "Lorena", "Morales", "Acosta", "1993/09/02", "F"),
(9, "Dr.", "Fernando", "Hernández", "Garcia", "1988/03/27", "M"),
(10, "Lic.", "Paola", "Vega", "Romero", "2000/05/14", "F"),
(11, "Ing.", "Ricardo", "Álvarez", "Torres", "1996/08/30", "M"),
(12, "Srta.", "Sofía", "Martínez", "Andrade", "2003/01/19", "F"),
(13, null, "Diego", "Olvera", "López", "1992/04/06", "M"),
(14, "Ing.", "Carlos", "Gómez", "Luna", "1997/01/10", "M"), 
(15, "Lic.", "Natalia", "Gonzáles", "Flores", "2001/02/25", "F"),
(16, "Arq.", "Juan", "Castillo", "Méndez", "1998/09/11", "M"),
(17, "Mtra.", "Brenda", "Pérez", "Ríos", "1995/07/03", "F"),
(18, "TSU.", "Miguel", "Ibáñez", "Lara", "2004/08/29", "M"),
(19, "Ing.", "Alan", "Núñez", "Urbina", "1997/05/04", "M"),
(20, "Srta.", "Yazmín", "Zúñiga", "Campos", "2002/09/30", "F"),
(21, "Ing.", "Luis", "Flores", "Medina", "1994/08/12", "M"),
(22, "Lic.", "Angélica", "Rojas", "Salas", "2001/04/05", "F"),
(23, "Dr.", "Eduardo", "Silva", "Moreno", "1993/07/26", "M"),
(24, "TSU.", "Itzel", "Pacheco", "Gómez", "2000/01/18", "F"),
(25, "Ing.", "Roberto", "Bautista", "Molina", "1997/09/09", "M"),
(26, "Srta.", "Leslie", "Cortés", "Valdez", "2005/02/22", "F"),
(27, "Dr.", "Arturo", "Hernández", "Gusmán", "1991/06/11", "M"),
(28, "Lic.", "Daniela", "Flores", "Ruiz", "2003/09/18", "F"),
(29, null, "Óscar", "Salgado", "Cruz", "1989/01/24", "M"),
(30, "Mtra.", "Patricia", "Torres", "Ramírez", "2002/05/07", "F"), 
(31, "Ing.", "Iván", "Gutiérrez", "Soto", "1996/03/14", "M"),
(32, "TSU.", "Ximena", "Méndez", "Estrada", "2004/08/01", "F"),
(33, "Lic.", "José", "Suárez", "Beltrán", "1992/04/29", "M"),
(34, "Sra.", "Raquel", "Cabrera", "Ávila", "2001/09/15", "F"),
(35, "Arq.", "Elías", "Villalobos", "Márquez", "1988/06/06", "M"),
(36, "Lic.", "Norma", "Ortega", "Ramos", "1999/07/21", "F"),
(37, "Ing.", "Marco", "Torres", "Ocampo", "1995/01/10", "M"),
(38, "Srta.", "Alejandra", "León", "Gallardo", "2003/03/27", "F"),
(39, "Mtro.", "César", "Rosales", "Nieto", "1991/09/18", "M"),
(40, "Srta.", "Lupita", "Padilla", "Arroyo", "1998/09/18", "F"),
(41, "Lic.", "Melissa", "Salinas", "Tapia", "1997/01/19", "F"),
(42, "Dr.", "Victor", "Cortés", "Trejo", "1992/09/30", "M"),
(43, "TSU.", "Iliana", "Prieto", "Rosas", "2005/02/14", "F"),
(44, "Ing.", "Samuel", "Galindo", "Vargas", "1999/06/05", "M"),
(45, "Lic.", "Jessica", "Espinoza", "Reyes", "2001/08/21", "F"),
(46, "Mtro.", "Tomás", "Herrera", "Jiménez", "1993/03/08", "M"),
(47, "Ing.", "Marina", "Castillo", "Torres", "1997/04/15", "F"), 
(48, "TSU.", "Julio", "Paredes", "Rojas", "2002/09/08", "M"),
(49, "Ing.", "Arturo", "Hernández", "Jiménez", "2001/03/09", "M"),
(50, "Lic.", "Laura", "Estrada", "Morales", "1994/07/22", "F");

insert into clientes values
(default, 1, default, default, default, default),
(default, 2, default, default, default, default),
(default, 3, default, default, default, default),
(default, 4, default, default, default, default),
(default, 5, default, default, default, default),
(default, 6, default, default, default, default),
(default, 7, default, default, default, default),
(default, 8, default, default, default, default),
(default, 9, default, default, default, default),
(default, 10, default, default, default, default),
(default, 11, default, default, default, default),
(default, 12, default, default, default, default),
(default, 13, default, default, default, default),
(default, 14, default, default, default, default),
(default, 15, default, default, default, default),
(default, 16, default, default, default, default),
(default, 17, default, default, default, default),
(default, 18, default, default, default, default),
(default, 19, default, default, default, default),
(default, 20, default, default, default, default),
(default, 21, default, default, default, default),
(default, 22, default, default, default, default),
(default, 23, default, default, default, default),
(default, 24, default, default, default, default),
(default, 25, default, default, default, default);

insert into proveedores values
(default, 1, "Mixto", default, default, default,default, null), -- DOBLE ROL
(default, 2, "Mayoreo", default, default, default,default, null),
(default, 3, "Menudeo", default, default, default,default, null),
(default, 4, "Mayoreo", default, default, default,default, null),
(default, 5, "Mixto", default, default, default,default, null),
(default, 26, "Mixto", default, default, default,default, null),-- PROVEEDORES PUROS
(default, 27, "Mayoreo", default, default, default,default, null),
(default, 28, "Menudeo", default, default, default,default, null),
(default, 29, "Mayoreo", default, default, default,default, null),
(default, 30, "Mixto", default, default, default,default, null),
(default, 31, "Mayoreo", default, default, default,default, null),
(default, 32, "Mixto", default, default, default,default, null),
(default, 33, "Mayoreo", default, default, default,default, null),
(default, 34, "Menudeo", default, default, default,default, null),
(default, 35, "Mayoreo", default, default, default,default, null),
(default, 36, "Mixto", default, default, default,default, null),
(default, 37, "Mayoreo", default, default, default,default, null),
(default, 38, "Mixto", default, default, default,default, null),
(default, 39, "Mayoreo", default, default, default,default, null),
(default, 40, "Mixto", default, default, default,default, null),
(default, 41, "Menudeo", default, default, default,default, null),
(default, 42, "Mixto", default, default, default,default, null),
(default, 43, "Mayoreo", default, default, default,default, null),
(default, 44, "Mixto", default, default, default,default, null),
(default, 45, "Mayoreo", default, default, default,default, null),
(default, 46, "Mixto", default, default, default,default, null),
(default, 47, "Mayoreo", default, default, default,default, null),
(default, 48, "Mixto", default, default, default,default, null),
(default, 49, "Menudeo", default, default, default,default, null),
(default, 50, "Menudeo", default, default, default,default, null);


SELECT 
    personas.rfc AS RFC,
    personas.nacionalidad AS Nacionalidad,
    pf.titulo_cortesia AS Titulo_Cortesia,
    pf.nombre AS Nombre,
    pf.primer_apellido AS Apellido_Paterno,
    pf.segundo_apellido AS Apellido_Materno,
    pf.fecha_nacimiento AS Fecha_Nacimiento,
    pf.genero AS Genero
FROM personas
INNER JOIN persona_fisica pf
    ON personas.id = pf.id;
    
-- 25 personas morales
insert into personas values
(default, "Moral", default, default, "CCP070615A21", "MX"),
(default, "Moral", default, default, "PIR900410B34", "MX"),
(default, "Moral", default, default, "GAR610820C56", "MX"),
(default, "Moral", default, default, "INN950112D78", "MX"),
(default, "Moral", default, default, "PIN960423E90", "MX"),
(default, "Moral", default, default, "ACA720310F12", "MX"),
(default, "Moral", default, default, "SHA030515G34", "MX"),
(default, "Moral", default, default, "CHA490908H56", "MX"),
(default, "Moral", default, default, "ATH940701J78", "MX"),
(default, "Moral", default, default, "NIK920220K90", "US"),
(default, "Moral", default, default, "ADI750808L12", "DE"),
(default, "Moral", default, default, "LEV660818M34", "US"),
(default, "Moral", default, default, "PUM480601N56", "DE"),
(default, "Moral", default, default, "HYM470410P78", "SE"),
(default, "Moral", default, default, "SHE080928Q90", "CN"),
(default, "Moral", default, default, "BEN651015R12", "IT"),
(default, "Moral", default, default, "FOR840401S34", "US"),
(default, "Moral", default, default, "DOL851010T56", "IT"),
(default, "Moral", default, default, "STR920615A89", "ES"),
(default, "Moral", default, default, "PUM480601N56", "DE"),
(default, "Moral", default, default, "BER680615V90", "US"),
(default, "Moral", default, default, "PUL720910W12", "US"),
(default, "Moral", default, default, "TOM850312X34", "US"),
(default, "Moral", default, default, "CAL680401Y56", "US"),
(default, "Moral", default, default, "GUE810505Z78", "US");

insert into persona_moral values
(51, "Cuidado con el Perro S.A. de C.V.", "Sociedad Anonima", DEFAULT, "2007/03/02", default, "Limitada al Capital Social", "Plena", "$250,000,000 MXN"),
(52, "Pirma S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1990/02/01", default, "Limitada para Accionistas", "Mercantil", "$180,000,000 MXN"),
(53, "Garcis S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1961/06/15", default, "Limitada para Accionistas", "Plena", "$120,000,000 MXN"),
(54, "Innovasport S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1994/11/05", default, "Limitada para Accionistas", "Mercantil", "$300,000,000 MXN"),
(55, "Pineda Covalín S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1996/02/10", default, "Limitada para Accionistas", "Plena", "$90,000,000 MXN"),
(56, "Aca Joe S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1972/01/20", default, "Limitada para Accionistas", "Mercantil", "$140,000,000 MXN"),
(57, "Shasa S.A. de C.V.", "Sociedad Anonima", DEFAULT, "2003/03/01", default, "Limitada para Accionistas", "Plena", "$110,000,000 MXN"),
(58, "Charly S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1949/07/12", default, "Limitada para Accionistas", "Mercantil", "$200,000,000 MXN"),
(59, "Atletica S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1994/05/20", default, "Limitada para Accionistas", "Plena", "$95,000,000 MXN"),
(60, "Nike de Mexico S.A. de R.L. de C.V.", "Sociedad Responsable Limitada", DEFAULT, "1992/01/10", default, "Limitada para Accionistas", "Mercantil", "$500,000,000 MXN"),
(61, "Adidas de Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1975/06/01", default, "Limitada para Accionistas", "Plena", "$650,000,000 MXN"),
(62, "Levi Strauss de Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1966/07/01", default, "Limitada para Accionistas", "Mercantil", "$420,000,000 MXN"),
(63, "Puma Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1948/05/15", default, "Limitada para Accionistas", "Plena", "$380,000,000 MXN"),
(64, "H&M Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1947/02/01", default, "Limitada para Accionistas", "Mercantil", "$700,000,000 MXN"),
(65, "Shein Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "2008/07/15", default, "Limitada para Accionistas", "Plena", "$900,000,000 MXN"),
(66, "Benetton Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1965/09/01", default, "Limitada para Accionistas", "Mercantil", "$260,000,000 MXN"),
(67, "Forever 21 S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1984/03/10", default, "Limitada para Accionistas", "Plena", "$210,000,000 MXN"),
(68, "Dolce & Gabbana Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1985/08/01", default, "Limitada para Accionistas", "Mercantil", "$320,000,000 MXN"),
(69, "Ermenegildo Zegna N.V.", "Sociedad Anonima", DEFAULT, "1910/05/11", default, "Limitada para Accionistas", "Plena", "$20,000,000,000 MXN"),
(70, "Stradivarius Mexico S.A. de R.L. de C.V.", "Sociedad Responsable Limitada", DEFAULT, "1992/04/01", default, "Limitada al Capital Social", "Mercantil", "$420,000,000 MXN"),
(71, "Bershka Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1975/04/01", default, "Limitada al Capital Social", "Plena", "$800,000,000 MXN"),
(72, "Polo Ralph Lauren Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1972/07/01", default, "Limitada para Accionistas", "Plena", "$410,000,000 MXN"),
(73, "Tommy Hilfinger Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1985/02/01", default, "Limitada para Accionistas", "Plena", "$390,000,000 MXN"),
(74, "Calvin Klein Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1968/02/10", default, "Limitada para Accionistas", "Plena", "$360,000,000 MXN"),
(75, "Guess Mexico S.A. de C.V.", "Sociedad Anonima", DEFAULT, "1981/03/01", default, "Limitada para Accionistas", "Mercantil", "$280,000,000 MXN");



SELECT 
    personas.rfc AS RFC,
    personas.nacionalidad AS Nacionalidad,
    pm.razon_social AS Nombre,
    pm.tipo AS Tipo,
    pm.fecha_creación AS Fecha,
    pm.responsabilidad AS Responsabilidad,
    pm.capacidad_juridica AS Cp,
    pm.patrimonio AS Patrimonio
FROM personas
INNER JOIN persona_moral pm
    ON personas.id = pm.id;
    
insert into clientes values
(default, 51, default, default, default, default),
(default, 52, default, default, default, default),
(default, 53, default, default, default, default),
(default, 54, default, default, default, default),
(default, 55, default, default, default, default),
(default, 56, default, default, default, default),
(default, 57, default, default, default, default),
(default, 58, default, default, default, default),
(default, 59, default, default, default, default),
(default, 60, default, default, default, default),
(default, 61, default, default, default, default),
(default, 62, default, default, default, default),
(default, 63, default, default, default, default),
(default, 64, default, default, default, default),
(default, 65, default, default, default, default);

insert into proveedores values
(default, 66, "Mixto", default, default, default,default, null),
(default, 67, "Mayoreo", default, default, default,default, null),
(default, 68, "Menudeo", default, default, default,default, null),
(default, 69, "Mayoreo", default, default, default,default, null),
(default, 70, "Mixto", default, default, default,default, null),
(default, 71, "Mayoreo", default, default, default,default, null),
(default, 72, "Mixto", default, default, default,default, null),
(default, 73, "Mayoreo", default, default, default,default, null),
(default, 74, "Menudeo", default, default, default,default, null),
(default, 75, "Mayoreo", default, default, default,default, null);

select
TRIGGER_NAME,
EVENT_MANIPULATION,
EVENT_OBJECT_TABLE,
ACTION_TIMING
from information_schema.TRIGGERS
WHERE TRIGGER_SCHEMA = "ecommerce_230173";

insert into persona_fisica values
(83, "Ing.", "Gabriel", "Sánchez", "Martínez", "1998/04/12", "M");
insert into persona_moral values
(84, "Cuidado con el Perro S.A. de C.V.", "Sociedad Anonima", DEFAULT, "2007/03/02", default, "Limitada al Capital Social", "Plena", "$250,000,000 MXN");
insert into proveedores values
(default, 83, "Mixto", default, default, default,default, null),
(default, 84, "Mixto", default, default, default,default, null);

insert into clientes values
(default, 83, default, default, default, default),
(default, 84, default, default, default, default);

select lower(elimina_caracteres_especiales(concat(substring(p.nombre,1,1), ".", p.primer_apellido))) as nickname from persona_fisica p;

-- creando una sesion para poder realizar un carrito de compras
insert into sesiones values
(default, 1, "Plataforma", "Smart Phone", "¡OS", "MX", "2026-02-23 10:00:50", "2026-02-23 10:00:50", "2026-02-23 11:15:05", "Finalizada");

insert into sesiones values
(default, 1, "Plataforma", "Smart Phone", "¡OS", "MX", "2026-02-23 10:00:50", "2025-02-23 10:00:50", "2026-02-23 11:15:05", "Finalizada");

alter table sesiones
add constraint chk_fechas check
(fecha_inicio >= fecha_registro);

delete from sesiones;
alter table sesiones auto_increment = 1;
delete from bitacora where tabla ="sesiones";

delete from carrito;
alter table carrito auto_increment = 1;

SHOW CREATE TABLE sesiones;

SELECT * FROM ecommerce_230173.sesiones;
-- agrupamiento de datos (group by)

-- que pasa si queremos saber cuantas de las 5000 sesiones  simuladas po pais
select codigo_pais, count(*)
from sesiones
group by codigo_pais;

-- ver 5000 sesiones
select count(*) from sesiones;

-- agrupar sesiones por año de registro
select year(fecha_registro) as anio, count(*) total_sesiones
from sesiones
group by year(fecha_registro)
order by anio;

-- Agrupar por lapso de tiempo entre el registro de la sesion y el inicio de sesion
select case
     when delay_seg = 0 then "Inmediata"
     when delay_seg between 1 and 60 then "Menos de 1 minuto"
     when delay_seg between 61 and 120 then "Entre 1 y 2 minutos"
     when delay_seg > 120 then "Mas de 2 minutos"
     end as rango_retraso,
     count(*) as Total_Sesiones
from 
    (select timestampdiff(second, s.fecha_registro, s.fecha_inicio) as delay_seg
    from sesiones s) t
group by rango_retraso;

-- Agrupar la duracion de la sesion
select case 
     when duracion_seg is null then "Sesiones Concluidas"
     when duracion_seg = 0 then "Nula"
     when duracion_seg between 1 and 300 then "Rapida (Menos de 5 minutos)"
     when duracion_seg between 301 and 600 then "Navegacion Promedio (5 a 10 minutos)"
     when duracion_seg between 601 and 1200 then "Busqueda Extendida (10 a 20 minutos)"
     when duracion_seg > 1200 then "Usuario Indeciso (+20 minutos)"
     else "Sesiones No Concluidas"
     end as rango_duracion,
     count(*) as Total_Sesiones
from
    (select timestampdiff(second, s.fecha_inicio, s.fecha_fin) as duracion_seg
    from sesiones s) t
group by rango_duracion;

SELECT elige_sesion();
SELECT elige_divisa();

select calcula_edad ("2005-09-03");

CALL actualizar_fechas_personas();

delete from carrito;
alter table carrito auto_increment = 1;
delete from bitacora where tabla ="carrito";
alter table bitacora auto_increment = 2038278;

-- Test 1: Elige un producto de cualquier categoria
select elige_producto(null);

-- Test 2: Agrega los datos del producto elegido
set @id_producto = elige_producto(null); -- asignar el id del producto elegido a una variable se sesion
select @id_producto; -- verificamos el valor de la variable
select * from productos where id = @id_producto; -- buscamos a que categoria pertenece
select p.nombre, c.nombre from productos p
join productos_categorias pc on p.id = pc.producto_id
join categorias c on pc.categoria_id = c.id
where p.id = @id_producto;

-- Test 3: Buscar un producto de la categoria Ropa
-- asignar el id del producto elegido a una variable de sesion
set @id_producto_ropa = elige_producto("Ropa");
-- verificamos el valor de a variable
select @id_producto_ropa;
-- buscamos la categoria pertenece el producto elegido aleatoriamente
select p.nombre, c.nombre from productos p
join productos_categoria pc on p.id = pc.producto_id
join categorias c on pc.categoria_id = c.id
where p.id = @id_producto_ropa;
 
 -- Test 4: Buscar un producto de la categoria Ropa
 -- asignar el id del producto elegido a una variable de sesion
 set @id_producto_verdura = elige_producto("Verduras");
 -- verificamos el valor de las variable
 select @id_producto_verdura;
 -- buscamos a que categoria pertenece el producto elegido aleatoriamente
 select p.nombre, c.nombre from productos p
 join productos_categoria pc on p.id = pc.producto_id
 join categorias c on pc.categoria_id = c.id
 where p.id = @id_producto_verdura;
 
 delete from carrito_detalle;
 delete from carrito;
 alter table carrito auto_increment = 1;
 delete from bitacora where tabla in ("carrito", "carrito_detalle");
 
 -- Test 5: simular un carrito con productos o varios productos
 -- call simula_carritos(1,null,null);
 
 -- Test 6: simular 10 carritos con 1 producto de cualquier categoria
-- call simula_carritos(10,1,null);
 
 -- Test 07: simular 50 carritos con 2 productos de su categoria asignada;
 -- call simula_carritos(50,2,"Ropa")
 
 select c.id, count(*) as total_productos
 from carrito c
 join carrito_detalle cd on cd.id_carrito = c.id
 group by c.id;
 
 -- importacion parcial de productos y productos categoria
 select count(*) from productos;
 select count(*) from productos_categorias;
 
 -- Test 1: Simlar un carrito con sus detalles, no importando el total de productos, ni la categoria
 call simula_carrito(1,null,null);
 -- Test 2: Simular 10 carritos de 2 productos de cualquier categoria
 call simula_carrito(10,2,null);
 -- Test 3: Simular 20 carritos de 3 productos de la categoria "Ropa"
 call simula_carrito(20,3,"Ropa");
 -- Test 4: Simular 1 carrito de 10 productos de la categoria "SexToys"
 call simula_carrito(1,10,"SexToys");
 -- Test 5: Simular 50 carritos de 5 productos de la categoria de Bebés
 call simula_carrito(50,5,"Bebés");
 -- Test 6: Simular 100 carritos de 1 producto de la categoria zapateria
 call simula_carrito(100,1,"Zapateria");
 -- Test 7: Simular 250 carritos de productos aleatorios  de productos internacionales
 call simula_carrito(250,null,"Internacional");
 -- Test 8: Simular 250 carritos de productos aleatorios  de productos importacion
 call simula_carrito(250,null,"Importaciones");
 -- Test 9: Simular 1000 carritos de productos aleatorios de la categoria Mujeres
 call simula_carrito(1000,null,"Mujeres");
  -- Test 10: Simular 1000 carritos de productos aleatorios de cualquier categoria
 call simula_carrito(10000,null,null);
 
 
 -- Consultar los 10 productos mas atractivos (aquellos que han sido agregados mas veces a un carrito daddo que no tenemos pedidos, ni pagos)
 select cd.id_producto, p.nombre, count(cd.id_producto) as total_agregaciones
 from carrito_detalle cd
 join productos p on p.id = cd.id_producto
 group by id_producto
 order by total_agregaciones desc
 limit 10;
 

delete from carrito_detalle;
delete from carrito;
alter table carrito auto_increment = 1;
delete from bitacora where tabla in ("carrito", "carrito_detalle");
delete from sesiones;
alter table sesiones auto_increment = 1;
delete from bitacora where tabla ="sesiones";
delete from pedidos;
alter table bitacora auto_increment = 1;
delete from bitacora where tabla = "pedido";

select duracion_sesion(1);

SELECT 
    id AS id_sesion,
    duracion_sesion(id) AS tiempo_transcurrido
FROM sesiones;

call simula_carrito(1,10,null);

-- LIMPIEZA DE DATOS PARA EXPLICAR EL TEST 08
delete from carrito_detalle;
delete from carrito;
delete from sesiones;
alter table carrito AUTO_INCREMENT = 1;
alter table sesiones AUTO_INCREMENT = 1;
delete from bitacora where tabla in ("carrito", "carrito_detalle");

 -- COMENZAMOS CON LA UNA NUEVA SIMULACION
 call simula_sesiones(1);
 call simula_carrito(1,10,null);
 
 -- Indices
 -- Sesiones
 CREATE INDEX idx_sesiones_usuario 
ON sesiones(id);

CREATE INDEX idx_sesiones_fechas 
ON sesiones(fecha_registro, fecha_inicio, fecha_fin);

SHOW INDEX FROM sesiones;

-- Carritos
CREATE INDEX idx_carritos_sesion 
ON carrito(sesion_id);

CREATE INDEX idx_carritos_fecha 
ON carrito(fecha_creacion);

SHOW INDEX FROM carrito;

-- Carrito Detalle
CREATE INDEX idx_detalle_carrito2 
ON carrito_detalle(carrito_id);

CREATE INDEX idx_detalle_producto 
ON carrito_detalle(producto_id);

SHOW INDEX FROM carrito_detalle;

-- Pedidos
CREATE INDEX idx_pedidos_carrito 
ON pedidos(carrito_id);

CREATE INDEX idx_pedidos_fecha 
ON pedidos(fecha_registro);

SHOW INDEX FROM pedidos;

-- Transacciones Financieras
CREATE INDEX idx_transacciones_pedido 
ON transacciones_financieras(id);

CREATE INDEX idx_transacciones_fecha 
ON transacciones_financieras(fecha_registro);

SHOW INDEX FROM transacciones_financieras;

-- Usuarios
CREATE INDEX idx_usuarios_nickname 
ON usuarios(nickname);

SHOW INDEX FROM usuarios;

-- Todos los indices
SELECT 
    TABLE_NAME,
    INDEX_NAME,
    COLUMN_NAME
FROM INFORMATION_SCHEMA.STATISTICS
WHERE TABLE_SCHEMA = 'ecommerce_230173';

call simula_carrito(5,null,null);
call simula_carrito(1,2,null);
call simula_carrito(5,2,"Ropa");

CALL simula_pedidos(100,1,10,2026);
call simula_compras(10,1,10);

-- Limpieza de tablas para los test
delete from transacciones_financieras;
delete from metodos_pago;
alter table transacciones_financieras AUTO_INCREMENT = 1;
alter table metodos_pago AUTO_INCREMENT = 1;
delete from bitacora where tabla in ("metodos de pago", "transacciones financieras");

delete from carrito_detalle;
delete from pedidos;
delete from carrito;
delete from sesiones;
alter table carrito AUTO_INCREMENT = 1;
alter table pedidos AUTO_INCREMENT = 1;
alter table sesiones AUTO_INCREMENT = 1;
delete from bitacora where tabla in ("carrito", "carrito_detalle", "pedidos");

-- Se crean 100 sesiones
call simula_sesiones(100);

-- TEST 1: Generar 1 compra completa: Carrito → Detalle → Pedido → Transacción financiera
call simula_carrito(1,null,null);
call simula_pedidos(1,1,1,null);
call simula_compras(1,1,1);

-- TEST 2: Generar 10 compras de productos de la categoría “Perfumería”
call simula_carrito(10,null,"Perfumeria");
call simula_pedidos(10,2,11,null);
call simula_compras(10,2,11);

-- TEST 3: Generar 100 compras en el año 2026
call simula_carrito(100,null,null);
call simula_pedidos(100,12,111,2026);
call simula_compras(100,12,111);

-- TEST 4: Generar 1000 compras de la categoría “Ropa para mujer”
call simula_carrito2(1000,null,"Ropa","Mujer");
call simula_pedidos(1000,112,1111,null);
call simula_compras(1000,112,1111);

-- TEST 5: Generar 500 compras de la categoría “Ropa para hombre”
call simula_carrito2(500,null,"Ropa","Hombre");
call simula_pedidos(500,1112,1611,null);
call simula_compras(500,1112,1611);

-- TEST 6: Generar 10,000 compras en general
call simula_carrito(10000,null,null);
call simula_pedidos(10000,1612,11611,null);
call simula_compras(10000,1612,11611);

-- TEST 7: Vista 
CREATE OR REPLACE VIEW vista_proceso_compra_completo AS
SELECT 
    CONCAT(pf.nombre, ' ', pf.primer_apellido, ' ', IFNULL(pf.segundo_apellido, '')) AS nombre_completo_comprador,
    s.fecha_inicio AS fecha_sesion,
    TIMESTAMPDIFF(MINUTE, s.fecha_inicio, s.fecha_fin) AS duracion_sesion_minutos,
    c.fecha_creacion AS fecha_creacion_carrito,
    c.total_productos AS total_productos_carrito,
    c.monto_aproximado AS monto_estimado_carrito,
    pe.fecha_registro AS fecha_pedido,
    pe.total_productos AS total_productos_pedido,
    pe.importe_total AS importe_total_pedido,
    pe.estatus AS estatus_pedido,
    tf.fecha_autorizacion AS fecha_pago,
    tf.monto AS importe_pago,
    tf.origen AS origen_pago,
    TIMESTAMPDIFF(MINUTE, s.fecha_inicio, tf.fecha_autorizacion) AS tiempo_total_proceso_minutos
FROM carrito c
INNER JOIN sesiones s ON c.sesion_id = s.id
INNER JOIN usuarios u ON u.persona_fisica_id = s.usuario_id
INNER JOIN persona_fisica pf ON pf.id = u.persona_fisica_id
LEFT JOIN pedidos pe ON pe.carrito_id = c.id
LEFT JOIN transacciones_financieras tf ON tf.monto = pe.importe_total 
    AND tf.fecha_autorizacion >= pe.fecha_registro
    AND tf.tipo = 'Compra'
-- WHERE c.estatus = 'Convertido'  -- COMENTA ESTO TEMPORALMENTE
ORDER BY c.fecha_creacion DESC;

-- Test 8: Linea de tiempo
SELECT 
    c.id AS carrito_id,
    p.nombre AS producto,
    p.marca,
    p.modelo,
    cd.cantidad,
    cd.precio_unitario,
    (cd.cantidad * cd.precio_unitario) AS subtotal,
    cd.fecha_registro AS fecha_agregado,
    ROW_NUMBER() OVER (ORDER BY cd.fecha_registro ASC) AS orden_seleccion,
    TIMESTAMPDIFF(SECOND, 
        (SELECT MIN(fecha_registro) FROM carrito_detalle WHERE carrito_id = 3222), 
        cd.fecha_registro
    ) AS segundos_desde_primero
FROM carrito_detalle cd
INNER JOIN carrito c ON cd.carrito_id = c.id
INNER JOIN productos p ON cd.producto_id = p.id
WHERE c.id = 1000
ORDER BY cd.fecha_registro ASC;

-- Test 9: Metricas de tiempo
SELECT 
    c.id AS carrito_id,
    c.estatus,
    c.fecha_creacion,
    CONCAT(pf.nombre, ' ', pf.primer_apellido) AS comprador,
    s.fecha_inicio,
    s.fecha_fin,
    TIMESTAMPDIFF(MINUTE, s.fecha_inicio, s.fecha_fin) AS duracion_sesion_minutos
FROM carrito c
INNER JOIN sesiones s ON c.sesion_id = s.id
INNER JOIN usuarios u ON u.persona_fisica_id = s.usuario_id
INNER JOIN persona_fisica pf ON pf.id = u.persona_fisica_id
-- WHERE c.estatus = 'Convertido'  -- COMENTA ESTO TEMPORALMENTE
ORDER BY c.id DESC;

-- Test 10
CREATE VIEW vista_origen_pagos AS
SELECT 
    origen AS metodo_pago,
    COUNT(*) AS total_usuarios
FROM transacciones_financieras
GROUP BY origen;