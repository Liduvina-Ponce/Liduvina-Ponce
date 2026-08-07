# Sistema de Gestión de Alojamientos Turistico

Este repositorio contiene el script final en lenguaje SQL para la creación, inserción y consulta de datos en un sistema relacional de control de propiedades, huéspedes, reservaciones y pagos.

## 🛠️ Motor de Base de Datos Utilizado
* **Motor de Base de Datos:** PostgreSQL
* **Versión del Servidor:** PostgreSQL 14 / 15 / 16 (Relational DBMS)
* **Herramienta de Administración:** pgAdmin 4
* **Dialecto SQL:** Estándar ANSI SQL / PostgreSQL Dialect (Uso de funciones nativas de tiempo como `NOW()`).

---

## 🗺️ Esquema de la Base de Datos

El diseño lógico del sistema está estructurado formalmente por **14 tablas relacionales**, distribuidas estratégicamente según su función:

### 1. Tablas Maestras e Independientes (Catálogos)
* **`owners`**: Almacena los registros informativos y de contacto de los propietarios de los inmuebles.
* **`guests`**: Registra los datos de identificación de los huéspedes (Nombre, apellido, pasaporte, y nacionalidad almacenada como texto directo).
* **`accommodation_types`**: Catálogo que define la clasificación de la propiedad (ej: Casa, Apartamento, Habitación Privada).
* **`booking_statuses`**: Tabla de estados para las reservas (ej: ID 1 = Confirmado, ID 2 = Cancelado).
* **`locations`**: Almacena de forma segregada la ubicación geográfica de los alojamientos (País, estado, ciudad, dirección exacta y coordenadas de latitud/longitud).
* **`amenities`**: Catálogo global de servicios o comodidades disponibles en el sistema (ej: Wifi, Piscina, Aire Acondicionado).
* **`staff_users`**: Registra las cuentas del personal interno técnico o administrativo con acceso al sistema.

### 2. Tablas Principales (Entidades Operativas Co-dependientes)
* **`accommodations`**: Entidad central que unifica las propiedades físicas. Se vincula obligatoriamente mediante llaves foráneas (`FK`) a un propietario (`owner_id`), un tipo de alojamiento y una ubicación geográfica.
* **`rooms`**: Define de forma específica la distribución interna de habitaciones, camas y espacios disponibles dentro de cada alojamiento hospedado.
* **`bookings`**: Gestiona las transacciones de reservación. Captura fechas estrictas de estancia (`check_in_date`, `check_out_date`) amarrando en una sola entidad al huésped, el alojamiento y su estado actual.
* **`payments`**: Registra la trazabilidad financiera del negocio (Montos decimales, métodos y estados del cobro). Depende estrictamente de un `booking_id` activo.
* **`reviews`**: Recopila la experiencia del cliente almacenando el título, texto descriptivo y una valoración numérica (`rating` tipo entero) posterior a su viaje.

### 3. Tablas de Asociación Muchos a Muchos (N:M)
* **`accommodation_amenities`**: Tabla intermedia que rompe la relación de muchos a muchos existente entre las propiedades (`accommodations`) y sus múltiples servicios (`amenities`).
* **`booking_guests`**: Tabla intermedia diseñada para asociar dinámicamente a más de un huésped a una única reservación principal.
