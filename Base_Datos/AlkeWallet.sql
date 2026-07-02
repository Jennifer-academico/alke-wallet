# Alke Wallet — Base de Datos

Diseño e implementación de una base de datos relacional para gestionar una wallet digital: usuarios, monedas disponibles y transacciones entre usuarios.

**Motor:** MySQL 8
**Herramienta de ejecución:** MySQL Workbench
**Nivel:** Trainee

## Contenido de esta carpeta

| Archivo | Descripción |
|---|---|
| `AlkeWallet.sql` | Script completo: creación de la base de datos, tablas, datos de prueba y consultas |
| `Diagrama_ER.png` | Diagrama entidad-relación, generado desde MySQL Workbench (Reverse Engineer) |
| `screenshots/` | Capturas de ejecución de cada consulta en MySQL Workbench |

## Diagrama entidad-relación

![Diagrama ER de Alke Wallet](Diagrama_ER.png)

## Modelo de datos

El sistema se compone de tres entidades:

**usuario** — cada persona registrada en la wallet. Tiene una moneda preferida asociada.
- `user_id` (PK)
- `nombre`
- `correo_electronico`
- `contrasena`
- `saldo`
- `currency_id` (FK → moneda)

**moneda** — las monedas disponibles para operar en la wallet.
- `currency_id` (PK)
- `currency_name`
- `currency_symbol`

**transaccion** — cada movimiento de dinero entre dos usuarios, en una moneda específica.
- `transaction_id` (PK)
- `sender_user_id` (FK → usuario)
- `receiver_user_id` (FK → usuario)
- `importe`
- `currency_id` (FK → moneda)
- `transaction_date`

### Relaciones

- Una moneda puede ser elegida por muchos usuarios (**1:N**).
- Un usuario puede enviar muchas transacciones (**1:N**).
- Un usuario puede recibir muchas transacciones (**1:N**).
- Una moneda puede estar asociada a muchas transacciones (**1:N**).

## Cómo ejecutar el script

1. Abrir **MySQL Workbench** y conectarse a un servidor MySQL 8 local.
2. Abrir una nueva pestaña de consulta (Query Tab).
3. Pegar el contenido de `AlkeWallet.sql`.
4. Ejecutar el script completo.
5. Verificar en el panel de resultados que todas las acciones se ejecuten sin errores.

El script crea la base de datos `AlkeWallet` desde cero, incluyendo datos de prueba, por lo que no requiere ningún paso adicional.

## Creación de la base de datos y tablas (DDL)

```sql
CREATE DATABASE AlkeWallet;
USE AlkeWallet;

CREATE TABLE moneda (
    currency_id     INT AUTO_INCREMENT PRIMARY KEY,
    currency_name   VARCHAR(50) NOT NULL,
    currency_symbol VARCHAR(5)  NOT NULL
);

CREATE TABLE usuario (
    user_id             INT AUTO_INCREMENT PRIMARY KEY,
    nombre              VARCHAR(100) NOT NULL,
    correo_electronico  VARCHAR(100) NOT NULL,
    contrasena          VARCHAR(255) NOT NULL,
    saldo               DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    currency_id         INT NOT NULL,
    CONSTRAINT fk_usuario_moneda
        FOREIGN KEY (currency_id) REFERENCES moneda(currency_id)
);

CREATE TABLE transaccion (
    transaction_id    INT AUTO_INCREMENT PRIMARY KEY,
    sender_user_id     INT NOT NULL,
    receiver_user_id   INT NOT NULL,
    importe            DECIMAL(12,2) NOT NULL,
    currency_id        INT NOT NULL,
    transaction_date   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaccion_sender
        FOREIGN KEY (sender_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_transaccion_receiver
        FOREIGN KEY (receiver_user_id) REFERENCES usuario(user_id),
    CONSTRAINT fk_transaccion_moneda
        FOREIGN KEY (currency_id) REFERENCES moneda(currency_id)
);
```

**Verificación de la estructura creada**

Tablas creadas dentro de `AlkeWallet`:
![Tablas creadas](screenshots/01-crear-tablas.png)

Estructura de `usuario`:
![Estructura de usuario](screenshots/02-describe-usuario.png)

Estructura de `moneda`:
![Estructura de moneda](screenshots/03-describe-moneda.png)

Estructura de `transaccion`:
![Estructura de transaccion](screenshots/04-describe-transaccion.png)

## Inserción de datos de prueba (DML)

```sql
INSERT INTO moneda (currency_name, currency_symbol) VALUES
('Peso Chileno', 'CLP'),
('Dólar Estadounidense', 'USD'),
('Euro', 'EUR'),
('Real Brasileño', 'BRL');

INSERT INTO usuario (nombre, correo_electronico, contrasena, saldo, currency_id) VALUES
('Gandalf El Gris','Gandalf.elgris@correo.com','clave1357', 150000.00, 1),
('Legolas Hojaverde','legolas.hojaverde@correo.com','clave7901', 80000.00,  2),
('Frodo Bolson','frodo.bolson@correo.com','clave3579', 500.00,    3),
('Aragorn II','aragorn.ii@correo.com','clave2468', 100000.00, 4);

INSERT INTO transaccion (sender_user_id, receiver_user_id, importe, currency_id) VALUES
(1, 2, 20000.00, 1),
(2, 3, 15.50, 2),
(3, 4, 40000.00, 4);
```

## Consultas SQL solicitadas

**1. Nombre de la moneda elegida por un usuario específico**

```sql
SELECT u.user_id, u.nombre, m.currency_name
FROM usuario u
INNER JOIN moneda m ON u.currency_id = m.currency_id
WHERE u.user_id = 1;
```
![Consulta de moneda](screenshots/05-consulta-moneda-usuario.png)

**2. Todas las transacciones registradas**

```sql
SELECT t.transaction_id, t.sender_user_id, t.receiver_user_id,
       t.importe, m.currency_symbol, t.transaction_date
FROM transaccion t
INNER JOIN moneda m ON t.currency_id = m.currency_id;
```
![Todas las transacciones](screenshots/06-todas-transacciones.png)

**3. Todas las transacciones realizadas por un usuario específico**

```sql
SELECT t.transaction_id, t.sender_user_id, t.receiver_user_id,
       t.importe, m.currency_symbol, t.transaction_date
FROM transaccion t
INNER JOIN moneda m ON t.currency_id = m.currency_id
WHERE t.sender_user_id = 1 OR t.receiver_user_id = 1;
```
![Transacciones del usuario 1](screenshots/07-transacciones-usuario1.png)

**4. Modificar el correo electrónico de un usuario específico (DML)**

```sql
UPDATE usuario
SET correo_electronico = 'Gandalf.elblanco@correo.com'
WHERE user_id = 1;

SELECT user_id, nombre, correo_electronico FROM usuario WHERE user_id = 1;
```
![Actualización de correo](screenshots/08-update-correo.png)

**5. Eliminar los datos de una transacción específica (DML)**

```sql
DELETE FROM transaccion
WHERE transaction_id = 2;

SELECT * FROM transaccion;
```
![Eliminación de transacción](screenshots/09-delete-transaccion.png)

**Extra: total enviado por cada usuario**

```sql
SELECT u.nombre, SUM(t.importe) AS total_enviado
FROM usuario u
INNER JOIN transaccion t ON u.user_id = t.sender_user_id
GROUP BY u.user_id, u.nombre;
```
![Total enviado por usuario](screenshots/10-consulta-extra-sum.png)


## Decisiones de diseño

- La moneda de cada usuario (`usuario.currency_id`) representa su moneda **preferida**, mientras que la moneda de cada transacción (`transaccion.currency_id`) representa la moneda **real en la que ocurrió ese movimiento** — ambas pueden diferir, por lo que se modelaron como relaciones independientes.
- `saldo` tiene un valor por defecto de `0.00`, para que ningún usuario nuevo quede con saldo indefinido.
- Los correos y contraseñas son campos obligatorios (`NOT NULL`), ya que son datos esenciales para el acceso a la cuenta.