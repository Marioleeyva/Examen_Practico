#### TEST - Verificacion de pruebas.

#### Objetivo General
Documentar todas las pruebas realizadas para validar el correcto funcionamiento del flujo de compra en la base de datos del comercio electrónico **Style Boutique**.

Se ejecutaron simulaciones de diferentes volúmenes y escenarios para verificar la integridad, rendimiento y coherencia de los datos.

#### Prueba  Descripción                                             Cantidad             Resultado
01 -    Generar 1 compra completa                                       1                   Completada
02 -    Generar 10 compras de Perfumería                                10                  Completada
03 -    Generar 100 compras en el año 2026                              100                 Completada
04 -    Generar 1000 compras de Ropa para mujer                         1000                Completada
05 -    Generar 500 compras de Ropa para hombre                         500                 Completada
06 -    Generar 10,000 compras generales                                10,000              Completada
07 -    Consulta integral,Vista del proceso completo                                        Completada

#### Herramientas Utilizadas

- MySQL 8.0+
- MySQL Workbench
- Procedimientos Almacenados
- Triggers
- Funciones
- Índices
- Vistas
- GitHub


#### Resultados Principales

- Flujo completo de compra funcional (Carrito → Pedido → Pago)
- Soporte probado hasta 10,000 registros simulados
- Integridad de datos mantenida mediante triggers
- Simulaciones temporales realistas implementadas
- Auditoría automática en tabla de bitácora

---

#### Pruebas

#### TEST 01 – Generar 1 compra completa

**Descripción:**  

Generar 1 compra completa:  
**Carrito → Detalle → Pedido → Transacción financiera**

**Comandos ejecutados:**

CALL simula_carrito(1, null, null);
CALL simula_pedidos(1, 1, 1, null);
CALL simula_compras(1, 1, 1);

**Evidencias:**
![Test 01 - Generar 1 compra completa](TEST 1_1)
![Test 01 - Generar 1 compra completa](TEST 1_2)
![Test 01 - Generar 1 compra completa](TEST 1_3)
![Test 01 - Generar 1 compra completa](TEST 1_4)
![Test 01 - Generar 1 compra completa](TEST 1_5)
![Test 01 - Generar 1 compra completa](TEST 1_6)
![Test 01 - Generar 1 compra completa](TEST 1_7)

#### Estatus:
Exitoso.


#### TEST 02 – Generar 10 compras de productos de la categoría “Perfumería”

**Descripción:**

Generar 10 compras enfocadas en productos de la categoría “Perfumería”


**Comandos principales:**

SQLCALL simula_carrito(10, null, "Perfumeria");
CALL simula_pedidos(10, 2, 11, null);
CALL simula_compras(10, 2, 11);


**Evidencias:**
![Test 02 - Generar 10 compras de productos](TEST 2_1)
![Test 02 - Generar 10 compras de productos](TEST 2_2)
![Test 02 - Generar 10 compras de productos](TEST 2_3)
![Test 02 - Generar 10 compras de productos](TEST 2_4)
![Test 02 - Generar 10 compras de productos](TEST 2_5)
![Test 02 - Generar 10 compras de productos](TEST 2_6)
![Test 02 - Generar 10 compras de productos](TEST 2_7)
![Test 02 - Generar 10 compras de productos](TEST 2_8)

#### Estatus: 
Exitoso.


### TEST 03 – Generar 100 compras en el año 2026

**Descripción:**

Generar 100 compras con fecha en el año 2026

**Comandos principales:**
SQLCALL simula_carrito(100, null, null);
CALL simula_pedidos(100, 12, 111, 2026);
CALL simula_compras(100, 12, 111);

**Evidencias:**
![Test 03 - Generar 100 compras](TEST 3_1)
![Test 03 - Generar 100 compras](TEST 3_2)
![Test 03 - Generar 100 compras](TEST 3_3)
![Test 03 - Generar 100 compras](TEST 3_4)
![Test 03 - Generar 100 compras](TEST 3_5)
![Test 03 - Generar 100 compras](TEST 3_6)
![Test 03 - Generar 100 compras](TEST 3_7)
![Test 03 - Generar 100 compras](TEST 3_8)


#### Estatus: 
Exitoso.

#### Prueba 04 – Generar 1000 compras de la categoría “Ropa para mujer”

**Descripción:**

Generar 1000 compras de la categoría “Ropa” para género “Mujer”

**Comandos principales:**
SQLCALL simula_carrito2(1000, null, "Ropa", "Mujer");
CALL simula_pedidos(1000, 112, 1111, null);
CALL simula_compras(1000, 112, 1111);

**Evidencias:**
![Test 04 - Generar 10 compras de productos](TEST 4_1)
![Test 04 - Generar 10 compras de productos](TEST 4_2)
![Test 04 - Generar 10 compras de productos](TEST 4_3)
![Test 04 - Generar 10 compras de productos](TEST 4_4)
![Test 04 - Generar 10 compras de productos](TEST 4_5)
![Test 04 - Generar 10 compras de productos](TEST 4_6)
![Test 04 - Generar 10 compras de productos](TEST 4_7)
![Test 04 - Generar 10 compras de productos](TEST 4_8)

#### Estatus: 
Exitoso.


#### TEST 05 – Generar 500 compras de la categoría “Ropa para hombre”

**Descripción:**

Generar 500 compras de la categoría “Ropa” para género “Hombre”

**Comandos principales:**
SQLCALL simula_carrito2(500, null, "Ropa", "Hombre");
CALL simula_pedidos(500, 1112, 1611, null);
CALL simula_compras(500, 1112, 1611);

**Evidencias:**
![Test 05 - Generar 500 compras](TEST 5_1)
![Test 05 - Generar 500 compras](TEST 5_2)
![Test 05 - Generar 500 compras](TEST 5_3)
![Test 05 - Generar 500 compras](TEST 5_4)
![Test 05 - Generar 500 compras](TEST 5_5)
![Test 05 - Generar 500 compras](TEST 5_6)
![Test 05 - Generar 500 compras](TEST 5_7)
![Test 05 - Generar 500 compras](TEST 5_8)

#### Estatus: 
Exitoso.


#### TEST 06 – Generar 10.000 compras en general

**Descripción:**

Prueba de estrés: Generar 10,000 compras generales

**Comandos principales:**
SQLCALL simula_carrito(10000, null, null);
CALL simula_pedidos(10000, 1612, 11611, null);
CALL simula_compras(10000, 1612, 11611);

**Evidencias:**
![Test 06 - Generar 10,000 compras de productos](TEST 6_1)
![Test 06 - Generar 10,000 compras de productos](TEST 6_2)
![Test 06 - Generar 10,000 compras de productos](TEST 6_3)
![Test 06 - Generar 10,000 compras de productos](TEST 6_4)
![Test 06 - Generar 10,000 compras de productos](TEST 6_5)
![Test 06 - Generar 10,000 compras de productos](TEST 6_6)
![Test 06 - Generar 10,000 compras de productos](TEST 6_7)
![Test 06 - Generar 10,000 compras de productos](TEST 6_8)

#### Estatus: 
Exitoso.


#### Prueba 07 – Consulta integral (Vista)

**Descripción:**

Generar una consulta o vista que muestre el proceso completo de compra con la siguiente información:

- Nombre completo del comprador
- Fecha de sesión
- Duración de la sesión
- Fecha de creación del carrito
- Total de productos del carrito
- Monto estimado del carrito
- Fecha del pedido
- Total de productos del pedido
- Importe total del pedido
- Estado del pedido
- Fecha de pago
- Importe del pago
- Origen del pago
- Tiempo total del proceso de compra

**Evidencias:**
![Test 07 - Consulta integral](TEST 7)
![Test 07 - Consulta integral](TEST 8)
![Test 07 - Consulta integral](TEST 9)
![Test 07 - Consulta integral](TEST 10)


#### Estatus: 
Exitoso.