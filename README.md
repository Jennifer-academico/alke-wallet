# Alke Wallet

Proyecto integrador del Bootcamp Full Stack Java: una billetera digital simple, desarrollada en dos módulos independientes — frontend y base de datos — como parte de distintas evaluaciones del bootcamp.

## Estructura del repositorio

```
alke-wallet/
├── Frontend/         → Interfaz web de la wallet (Módulo 2)
└── Base_Datos/        → Base de datos relacional (Módulo 3)
```

## Módulo 1 — Frontend

Interfaz web funcional que simula una billetera digital: inicio de sesión, consulta de saldo, depósitos, envío de dinero a contactos e historial de movimientos.

**Tecnologías:** HTML5, CSS3, Bootstrap 5.3, jQuery 3.6, JavaScript, LocalStorage.

**Funcionalidades principales:**
- Inicio de sesión con validación de credenciales.
- Visualización y actualización del saldo disponible.
- Depósito de dinero con validación de monto.
- Envío de dinero a contactos, con validación de saldo suficiente.
- Registro y búsqueda de contactos (nombre, CBU, alias, banco).
- Historial de movimientos filtrable por tipo.
- Persistencia de datos en el LocalStorage del navegador.

Detalle completo, credenciales de prueba y estructura de archivos en [`Frontend/README.md`](Frontend/README.md).

## Módulo 2 — Base de Datos

Diseño e implementación de una base de datos relacional en MySQL 8 para gestionar usuarios, monedas y transacciones de la wallet, incluyendo modelo entidad-relación, script DDL/DML y consultas SQL.

**Tecnologías:** MySQL 8, MySQL Workbench.

**Contenido:**
- Modelo de 3 entidades: `usuario`, `moneda`, `transaccion`, relacionadas mediante claves foráneas.
- Script completo de creación de base de datos, tablas, datos de prueba y consultas.
- Diagrama entidad-relación generado desde MySQL Workbench.
- Consultas de lectura, modificación (`UPDATE`) y eliminación (`DELETE`) de datos.

Detalle completo, diagrama ER y guía de ejecución en [`Base_Datos/README.md`](Base_Datos/README.md).

## Sobre este proyecto

Ambos módulos representan etapas distintas de un mismo proyecto conceptual — la wallet digital "Alke Wallet" — desarrolladas de forma independiente como evaluaciones separadas del bootcamp. Actualmente no están conectados entre sí (el frontend usa LocalStorage, no la base de datos); la integración entre ambos correspondería a un módulo de backend futuro.

## Autora

Jennifer Pérez — Bootcamp Full Stack Java.
