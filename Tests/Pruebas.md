#### TEST - Verificacion de pruebas.

#### Objetivo General
Documentar todas las pruebas realizadas para validar el correcto funcionamiento del flujo de compra en la base de datos del comercio electrónico **Style Boutique**.

Se ejecutaron simulaciones de diferentes volúmenes y escenarios para verificar la integridad, rendimiento y coherencia de los datos.

|#### Prueba  | Descripción                                             | Cantidad             | Resultado
|-------------|---------------------------------------------------------|----------------------|--------
|    01 -     | Generar 1 compra completa                               |      1               |   Completada
|    02 -     | Generar 10 compras de Perfumería                        |      10              |   Completada
|    03 -     | Generar 100 compras en el año 2026                      |      100             |   Completada
|    04 -     | Generar 1000 compras de Ropa para mujer                 |      1000            |   Completada
|    05 -     | Generar 500 compras de Ropa para hombre                 |      500             |   Completada
|    06 -     | Generar 10,000 compras generales                        |      10,000          |   Completada
|    07 -     | Consulta integral,Vista del proceso completo            |                      |    Completada

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
|------------------------------------|
|CALL simula_carrito(1, null, null); |
|CALL simula_pedidos(1, 1, 1, null); |
|CALL simula_compras(1, 1, 1);       |

**Evidencias:**
![TEST - Verificacion de pruebas](TEST%201_1.png)
![TEST - Verificacion de pruebas](TEST%201_2.png)
![TEST - Verificacion de pruebas](TEST%201_3.png)
![TEST - Verificacion de pruebas](TEST%201_4.png)
![TEST - Verificacion de pruebas](TEST%201_5.png)
![TEST - Verificacion de pruebas](TEST%201_6.png)
![TEST - Verificacion de pruebas](TEST%201_7.png)

#### Estatus:
Exitoso.


#### TEST 02 – Generar 10 compras de productos de la categoría “Perfumería”

**Descripción:**

Generar 10 compras enfocadas en productos de la categoría “Perfumería”


**Comandos principales:**
|-------------------------------------------------|
|SQLCALL simula_carrito(10, null, "Perfumeria");  |
|CALL simula_pedidos(10, 2, 11, null);            |
|CALL simula_compras(10, 2, 11);                  |
  

**Evidencias:**
![TEST - Verificacion de pruebas](TEST%202_1.png)
![TEST - Verificacion de pruebas](TEST%202_2.png)
![TEST - Verificacion de pruebas](TEST%202_3.png)
![TEST - Verificacion de pruebas](TEST%202_4.png)
![TEST - Verificacion de pruebas](TEST%202_5.png)
![TEST - Verificacion de pruebas](TEST%202_6.png)
![TEST - Verificacion de pruebas](TEST%202_7.png)
![TEST - Verificacion de pruebas](TEST%202_8.png)

#### Estatus: 
Exitoso.


### TEST 03 – Generar 100 compras en el año 2026

**Descripción:**

Generar 100 compras con fecha en el año 2026

**Comandos principales:**
|------------------------------------------|
|SQLCALL simula_carrito(100, null, null);  |
|CALL simula_pedidos(100, 12, 111, 2026);  |
|CALL simula_compras(100, 12, 111);        |

**Evidencias:**
![TEST - Verificacion de pruebas](TEST%203_1.png)
![TEST - Verificacion de pruebas](TEST%203_2.png)
![TEST - Verificacion de pruebas](TEST%203_3.png)
![TEST - Verificacion de pruebas](TEST%203_4.png)
![TEST - Verificacion de pruebas](TEST%203_5.png)
![TEST - Verificacion de pruebas](TEST%203_6.png)
![TEST - Verificacion de pruebas](TEST%203_7.png)
![TEST - Verificacion de pruebas](TEST%203_8.png)


#### Estatus: 
Exitoso.

#### Prueba 04 – Generar 1000 compras de la categoría “Ropa para mujer”

**Descripción:**

Generar 1000 compras de la categoría “Ropa” para género “Mujer”

**Comandos principales:**
|------------------------------------------------------ |
|SQLCALL simula_carrito2(1000, null, "Ropa", "Mujer");  |
|CALL simula_pedidos(1000, 112, 1111, null);|           |
|CALL simula_compras(1000, 112, 1111);                  |

**Evidencias:**
![TEST - Verificacion de pruebas](TEST%204_1.png)
![TEST - Verificacion de pruebas](TEST%204_2.png)
![TEST - Verificacion de pruebas](TEST%204_3.png)
![TEST - Verificacion de pruebas](TEST%204_4.png)
![TEST - Verificacion de pruebas](TEST%204_5.png)
![TEST - Verificacion de pruebas](TEST%204_6.png)
![TEST - Verificacion de pruebas](TEST%204_7.png)
![TEST - Verificacion de pruebas](TEST%204_8.png)

#### Estatus: 
Exitoso.


#### TEST 05 – Generar 500 compras de la categoría “Ropa para hombre”

**Descripción:**

Generar 500 compras de la categoría “Ropa” para género “Hombre”

**Comandos principales:**
|-------------------------------------------------------|
|SQLCALL simula_carrito2(500, null, "Ropa", "Hombre");  |
|CALL simula_pedidos(500, 1112, 1611, null);            |
|CALL simula_compras(500, 1112, 1611);                  |

**Evidencias:**
![TEST - Verificacion de pruebas](TEST%205_1.png)
![TEST - Verificacion de pruebas](TEST%205_2.png)
![TEST - Verificacion de pruebas](TEST%205_3.png)
![TEST - Verificacion de pruebas](TEST%205_4.png)
![TEST - Verificacion de pruebas](TEST%205_5.png)
![TEST - Verificacion de pruebas](TEST%205_6.png)
![TEST - Verificacion de pruebas](TEST%205_7.png)
![TEST - Verificacion de pruebas](TEST%205_8.png)

#### Estatus: 
Exitoso.


#### TEST 06 – Generar 10.000 compras en general

**Descripción:**

Prueba de estrés: Generar 10,000 compras generales

**Comandos principales:**
|-----------------------------------------------|
|SQLCALL simula_carrito(10000, null, null);     |
|CALL simula_pedidos(10000, 1612, 11611, null);||
|CALL simula_compras(10000, 1612, 11611);       |

**Evidencias:**
![TEST - Verificacion de pruebas](TEST%206_1.png)
![TEST - Verificacion de pruebas](TEST%206_2.png)
![TEST - Verificacion de pruebas](TEST%206_3.png)
![TEST - Verificacion de pruebas](TEST%206_4.png)
![TEST - Verificacion de pruebas](TEST%206_5.png)
![TEST - Verificacion de pruebas](TEST%206_6.png)
![TEST - Verificacion de pruebas](TEST%206_7.png)
![TEST - Verificacion de pruebas](TEST%206_8.png)

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
![TEST - Verificacion de pruebas](TEST%207.png)
![TEST - Verificacion de pruebas](TEST%208.png)
![TEST - Verificacion de pruebas](TEST%209.png)
![TEST - Verificacion de pruebas](TEST%2010.png)


#### Estatus: 
Exitoso.
