INSERT INTO public.colegio (nombre, direccion)
VALUES ('Colegio Ejemplo', 'Calle Principal #123, Santiago');

INSERT INTO public.curso (año, grupo, nivel, id_colegio)
VALUES (2024, 'A', 'B5', 1);


-- Agregar dos empleados que son profesores
INSERT INTO public.empleado (rut, comuna, nombre, apellido, id_colegio, rol, sueldo)
VALUES
    (12345678, 'Santiago', 'Juan', 'Pérez', 1, 'Auxiliar', 2000000),
    (23456789, 'Santiago', 'María', 'González', 1, 'Profesor', 1800000);

-- Agregar al último empleado como profesor jefe de un curso
INSERT INTO public.profesor (rut_profesor)
VALUES
    (34567890),  -- Suponiendo que el último empleado es un profesor jefe
	(23456789);
-- Asignar al último empleado como profesor jefe de un curso
INSERT INTO public.asumir (rut_profesor, id_curso)
VALUES
    (34567890, 1);  -- Suponiendo que el id del curso al que está asignado el profesor jefe es 1
INSERT INTO public.empleado (rut, comuna, nombre, apellido, id_colegio, rol, sueldo)
values
	(34567890, 'Santiago', 'Pedro', 'Rodríguez', 1, 'Profesor', 2200000);
	

INSERT INTO public.alumno (rut_alumno, nombre, apellido, comuna, "numero identificador") 
VALUES 
	(123456789, 'Juan', 'Pérez', 'Santiago', '9'),
 	(856473927, 'Camilo', 'Moreno', 'Valparaiso','k'),
  	(056473927, 'Camila', 'Rei', 'Santiago','k');
 
INSERT INTO public.pertenecer (rut_alumno, id)
VALUES (123456789, 1),  
       (856473927, 1);
INSERT INTO public.pertenecer (rut_alumno, id)
VALUES (056473927, 1);
INSERT INTO public.clases (materia, dia, inicio, salida) 
VALUES 
	('Matemáticas', 'Lunes', '08:00:00', '09:45:00'),
	('Lenguaje', 'Lunes', '10:00:00', '12:45:00'),
	('Matemáticas', 'Martes', '08:00:00', '09:45:00'),
	('Lenguaje', 'Martes', '10:00:00', '12:45:00'),
	('Matemáticas', 'Miercoles', '08:00:00', '09:45:00');
	
INSERT INTO public.asistir (rut_alumno, id_clases, inasistencia) 
VALUES 
	(123456789, 1, 1),
	(123456789, 2, 0),
	(123456789, 3, 1),
	(123456789, 4, 1),
	(123456789, 5, 1),
	(856473927, 1, 1),
	(856473927, 2, 0),
	(856473927, 3, 0),
	(856473927, 4, 1),
	(856473927, 5, 1),
	(056473927, 1, 1),
	(056473927, 2, 1),
	(056473927, 3, 1),
	(056473927, 4, 1),
	(056473927, 5, 1); 
INSERT INTO public.asistir (rut_alumno, id_clases, inasistencia) 
VALUES 	(056473927, 1, 1),
	(056473927, 2, 1),
	(056473927, 3, 1),
	(056473927, 4, 1),
	(056473927, 5, 1); 
INSERT INTO public.ensenar  (rut_profesor , id_clases) 
VALUES 
	(23456789,2),
	(23456789,4),
	(34567890,1),
	(34567890,3),
	(34567890,5);
INSERT INTO public.apoderado (rut_apoderado, nombre, apellido, dirección, "numero identificador") 
VALUES
	(888888888, 'Marcelo', 'Robles', 'Avenida siempre viva 123', '2'),
	(888888889, 'Marcelina', 'Gutierrez', 'Avenida siempre viva 122', '2');
INSERT INTO public."responsable de"  (rut_alumno, rut_apoderado, relacion) 
VALUES
	(056473927, 888888888, 'Tio'),
	(856473927, 888888889, 'Madre');
INSERT INTO public.curso (año, grupo, nivel, id_colegio)
VALUES 
	(2019, 'A', 'B8', 1),
	(2019, 'A', 'B4', 2),
	(2019, 'A', 'B7', 3);
INSERT INTO public.alumno (rut_alumno, nombre, apellido, comuna, "numero identificador") 
VALUES 
	(111111111, 'Jjjj', 'Pérez', 'Santiago', '9'),
 	(111111112, 'Cccc', 'Moreno', 'Valparaiso','k'),
  	(111111113, 'Cccc', 'Rei', 'Santiago','k');
 INSERT INTO public.pertenecer (rut_alumno, id)
VALUES (111111111, 4),  
       (111111112, 5),
       (111111113, 6);
 INSERT INTO public.asistir (rut_alumno, id_clases, inasistencia) 
VALUES 
	(111111111, 1, 1),
	(111111111, 2, 1),  
	(111111111, 3, 1),
	(111111111, 4, 0),
	(111111111, 5, 0),  
    (111111112, 1, 0),
    (111111112, 2, 0),
    (111111112, 3, 0),
    (111111112, 4, 0),  
    (111111112, 5, 1),
    (111111113, 1, 0),
    (111111113, 2, 0),  
    (111111113, 3, 0),
    (111111113, 4, 0),
    (111111113, 5, 0);