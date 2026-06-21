# Alke Wallet

Proyecto frontend desarrollado para una evaluación del Módulo 2 del Bootcamp Full Stack Java. La aplicación simula una billetera digital simple, permitiendo iniciar sesión, consultar saldo, depositar dinero, enviar dinero a contactos y revisar los últimos movimientos.

## Objetivo del proyecto

Construir una interfaz web funcional usando HTML, CSS, Bootstrap 5, jQuery y JavaScript, aplicando validaciones de formularios, manipulación del DOM y persistencia en el navegador con LocalStorage.

## Tecnologías utilizadas

- HTML5
- CSS3
- Bootstrap 5.3
- jQuery 3.6
- JavaScript
- LocalStorage

## Credenciales de prueba

- Email: admin@wallet.com
- Contraseña: 1234

## Flujo de uso

1. Ingresar a `index.html` e iniciar sesión con las credenciales de prueba.
2. Desde el menú principal se puede:
   - Depositar dinero a la cuenta.
   - Enviar dinero a un contacto registrado.
   - Revisar los últimos movimientos.
3. El saldo, los contactos y los movimientos quedan guardados en el LocalStorage del navegador.

## Funcionalidades

- Inicio de sesión con validación de credenciales.
- Visualización del saldo disponible.
- Depósito de dinero con validación de monto.
- Envío de dinero a contactos con validación de saldo suficiente.
- Registro de contactos con nombre, CBU, alias y banco.
- Búsqueda de contactos por nombre o alias.
- Historial de movimientos filtrable por tipo.
- Persistencia de saldo y movimientos en LocalStorage.

## Estructura del proyecto# alke-wallet
Proyecto final frontend bootcamp Java 

alke-wallet/

├── css/

│   └── styles.css

├── js/

│   ├── login.js

│   ├── menu.js

│   ├── deposit.js

│   ├── sendmoney.js

│   └── transactions.js

├── img/

│   └── logo.png

├── index.html

├── menu.html

├── deposit.html

├── sendmoney.html

└── transactions.html

## Consideraciones

El proyecto usa LocalStorage para guardar el saldo y los movimientos. Se recomienda abrirlo desde un servidor local o GitHub Pages para evitar restricciones del navegador al trabajar con archivos locales.

## Autora

Jennifer Pérez - Evaluación Módulo 2 Frontend, Bootcamp Full Stack Java.
