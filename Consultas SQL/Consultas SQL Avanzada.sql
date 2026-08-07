--numero 14 LEFT JOIN - Sin reseñas (Incluye nu
select 
	a.accommodation_id,
    a.name AS accommodation_name,
    r.review_id
FROM accommodations a
LEFT JOIN reviews r ON a.accommodation_id = r.accommodation_id
WHERE r.review_id IS NULL;

--numero15. LEFT JOIN - Sin reservas (Filtrar null)
SELECT 
    g.guest_id,
    g.first_name,
    g.last_name,
    g.email
FROM guests g
LEFT JOIN bookings b ON g.guest_id = b.guest_id
WHERE b.booking_id IS NULL; -- Si el ID de reserva es NULL, significa que nunca reservó

--numero16. AGG - Total ingresos (SUM)
SELECT SUM(amount) AS total_ingresos_completados
FROM payments
WHERE payment_status = 'Completado';

--numero17. AGG - Promedio rating (AVG)
SELECT AVG(rating) AS promedio_puntuacion_global
FROM reviews;

--numero18. AGG - Top alojamientos (COUNT + LIMIT)
--alojamiento con mayor cantidad de reserva registrada
SELECT 
    accommodation_id,
    COUNT(booking_id) AS total_reservas
FROM bookings
GROUP BY accommodation_id
ORDER BY total_reservas DESC
LIMIT 3;

--numero19. HAVING - Más de 3 reservas (GROUP BY + HAVING)
--Filtra y Seleciona por huesped,loc clientes frecuentes que tiene mas de 3 reservaciones
SELECT 
    guest_id,
    COUNT(booking_id) AS total_reservas
FROM bookings
GROUP BY guest_id
HAVING COUNT(booking_id) > 3;

--numero20. Subconsulta - Alojamiento más caro (Subquery)
--subconsulta de forma dinamica el registro que iguale el precio mas alto, sin escribir el numero
SELECT 
    accommodation_id,
    name AS accommodation_name,
    base_price_per_night,
    currency_code
FROM accommodations
WHERE base_price_per_night = (
    SELECT MAX(base_price_per_night) 
    FROM accommodations
);









