-- Query 5a: All work items for a given customer (Berger, Franz)
SELECT o.order_no, o.date, v.plate, w.description, w.hours
FROM customer c
JOIN "order" o ON c.cust_no = o.cust_no
JOIN vehicle v ON o.plate = v.plate
JOIN work_item w ON o.order_no = w.order_no
WHERE c.cust_name = 'Berger, Franz'
ORDER BY o.date, w.item_no;


-- Query 5b: Total hours per mechanic in March 2026
SELECT m.mech_name,
       ROUND(SUM(w.hours), 1) AS total_hours,
       COUNT(DISTINCT w.order_no) AS orders
FROM mechanic m
JOIN work_item w ON m.mech_id = w.mech_id
JOIN "order" o ON w.order_no = o.order_no
WHERE o.date BETWEEN '2026-03-01' AND '2026-03-31'
GROUP BY m.mech_id
ORDER BY total_hours DESC;


-- Query 5c-1: Vehicles with no repair order (EXCEPT)
SELECT plate, model FROM vehicle
EXCEPT
SELECT v.plate, v.model
FROM vehicle v
JOIN "order" o ON v.plate = o.plate;


-- Query 5c-2: Vehicles with no repair order (NOT EXISTS)
SELECT v.plate, v.model
FROM vehicle v
WHERE NOT EXISTS (
    SELECT 1
    FROM "order" o
    WHERE o.plate = v.plate
);
