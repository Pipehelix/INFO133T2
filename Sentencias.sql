
-- Consulta pregunta 1
(SELECT e.nombre, e.apellido, e.sueldo, cast(a.id_curso AS varchar) AS id_curso  FROM profesor p, empleado e, asumir a
WHERE p.rut_profesor = e.rut AND p.rut_profesor = a.rut_profesor)

UNION

(SELECT e.nombre, e.apellido, e.sueldo, 'No es p. jefe' AS id_curso
FROM profesor p, empleado e
WHERE p.rut_profesor = e.rut
    AND p.rut_profesor NOT IN (SELECT rut_profesor FROM asumir));
    
-- Consulta pregunta 2
   
SELECT a.rut_alumno, a.nombre, a.apellido, 
    (SELECT SUM(inasistencia) FROM asistir asi WHERE asi.rut_alumno = a.rut_alumno) cant_asistencias,
    (SELECT año FROM curso c, pertenecer p WHERE p.id = c.id AND p.rut_alumno = a.rut_alumno) AS año_curso,
    (SELECT grupo FROM curso c, pertenecer p WHERE p.id = c.id AND p.rut_alumno = a.rut_alumno) AS grupo_curso
FROM alumno a
ORDER BY cant_asistencias DESC;

-- Consulta 3
SELECT e.rol, e.comuna, e.sueldo
FROM empleado e
ORDER BY e.comuna, e.sueldo;

--Consulta 4
SELECT c.año,c.grupo,
    (SELECT COUNT(*) FROM pertenecer p WHERE p.id = c.id) cantidad_alumnos
FROM curso c
GROUP BY c.año, c.grupo, c.id
ORDER BY cantidad_alumnos DESC
LIMIT 1;
--Consulta 5
SELECT a.rut_alumno, a.nombre, a.apellido, c.año, c.grupo
FROM alumno a, curso c, pertenecer p
WHERE  a.rut_alumno = p.rut_alumno AND p.id = c.id AND a.rut_alumno NOT IN (
        SELECT asi.rut_alumno
        FROM asistir asi
        WHERE asi.rut_alumno = a.rut_alumno AND asi.inasistencia = 0
    )
GROUP BY a.rut_alumno, a.nombre, a.apellido, c.año, c.grupo;
--Consulta 6
SELECT p.rut_profesor,e.nombre,e.apellido,e.sueldo,
COUNT(en.id_clases) horas_clases
FROM profesor p,empleado e,ensenar en
WHERE p.rut_profesor = e.rut AND p.rut_profesor = en.rut_profesor
GROUP BY p.rut_profesor, e.nombre, e.apellido, e.sueldo
ORDER BY horas_clases DESC
LIMIT 1;
--Consulta 7
SELECT p.rut_profesor,e.nombre,e.apellido,e.sueldo,
COUNT(en.id_clases) horas_clases
FROM profesor p,empleado e,ensenar en
WHERE p.rut_profesor = e.rut AND p.rut_profesor = en.rut_profesor
GROUP BY p.rut_profesor, e.nombre, e.apellido, e.sueldo
ORDER BY horas_clases ASC
LIMIT 1;
--Consulta 8
SELECT a.rut_alumno,a.nombre AS nombre_alumno,p.id AS id_curso,c.año AS año_curso, c.grupo
FROM alumno a, curso c, pertenecer p, "responsable de" r, apoderado ap
WHERE a.rut_alumno = p.rut_alumno AND p.id = c.id AND a.rut_alumno = r.rut_alumno AND r.rut_apoderado = ap.rut_apoderado AND r.relacion NOT IN ('Padre', 'Madre');
--Consulta 9
SELECT c.nombre AS nombre_colegio, AVG(asi.inasistencia) promedio_asistencia
FROM colegio c, curso cu, pertenecer p, asistir asi
WHERE c.id = cu.id_colegio AND cu.id = p.id AND  p.rut_alumno = asi.rut_alumno AND cu.año = 2019
GROUP BY c.nombre
ORDER BY promedio_asistencia DESC
LIMIT 1;
--Consulta 10
SELECT c.nombre,cu.año AS año,
COUNT(p.rut_alumno) cantidad_alumnos
FROM colegio c, curso cu, pertenecer p
WHERE c.id = cu.id_colegio AND cu.id = p.id
GROUP BY c.nombre, cu.año
ORDER BY c.nombre ASC, cantidad_alumnos DESC;
