-- PROYECTO: ALKE WALLET


-- 1. CREACIÓN DE LA BD (DDL)

CREATE DATABASE AlkeWallet;
USE AlkeWallet;

SHOW DATABASES;

-- 2. CREACIÓN DE TABLAS (DDL)

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

-- transaccion ahora incluye currency_id: en qué moneda ocurrió el movimiento
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

SHOW TABLES;
DESCRIBE usuario;
DESCRIBE moneda;
DESCRIBE transaccion;

-- 3. INSERCIÓN DE DATOS DE PRUEBA (DML)

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

-- 4. CONSULTAS SQL SOLICITADAS

-- 4.1 Nombre de la moneda elegida por un usuario específico (user_id = 1)
SELECT u.user_id, u.nombre, m.currency_name
FROM usuario u
INNER JOIN moneda m ON u.currency_id = m.currency_id
WHERE u.user_id = 1;

-- 4.2 Todas las transacciones registradas (con símbolo de moneda)
SELECT t.transaction_id, t.sender_user_id, t.receiver_user_id,
       t.importe, m.currency_symbol, t.transaction_date
FROM transaccion t
INNER JOIN moneda m ON t.currency_id = m.currency_id;

-- 4.3 Todas las transacciones de un usuario específico (user_id = 1), con moneda
SELECT t.transaction_id, t.sender_user_id, t.receiver_user_id,
       t.importe, m.currency_symbol, t.transaction_date
FROM transaccion t
INNER JOIN moneda m ON t.currency_id = m.currency_id
WHERE t.sender_user_id = 1 OR t.receiver_user_id = 1;

-- 4.4 DML: modificar el correo electrónico de un usuario específico (user_id = 1)
UPDATE usuario
SET correo_electronico = 'Gandalf.elblanco@correo.com'
WHERE user_id = 1;

SELECT user_id, nombre, correo_electronico FROM usuario WHERE user_id = 1;

-- 4.5 Eliminar los datos de una transacción específica (transaction_id = 2)
DELETE FROM transaccion
WHERE transaction_id = 2;

SELECT * FROM transaccion;

-- 5. CONSULTA EXTRA: total enviado por cada usuario
SELECT u.nombre, SUM(t.importe) AS total_enviado
FROM usuario u
INNER JOIN transaccion t ON u.user_id = t.sender_user_id
GROUP BY u.user_id, u.nombre;