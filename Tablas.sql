CREATE TABLE public.colegio (
	nombre varchar NULL,
	id serial4 NOT NULL,
	direccion varchar NULL,
	CONSTRAINT colegio_pk PRIMARY KEY (id)
);
COMMENT ON TABLE public.colegio IS 'Colegio sobre el cual se almacenan datos';

-- Column comments

COMMENT ON COLUMN public.colegio.nombre IS 'Nombre del colegio';
COMMENT ON COLUMN public.colegio.id IS 'Identificador único del colegio';
COMMENT ON COLUMN public.colegio.direccion IS 'Dirección de la calle donde se encuentra el colegio';


CREATE TABLE public.empleado (
	rut int4 NOT NULL,
	"numero identificador" int4 NULL,
	comuna varchar NULL,
	nombre varchar NULL,
	apellido varchar NULL,
	id_colegio serial4 NOT NULL,
	rol varchar NULL,
	sueldo int4 NULL,
	CONSTRAINT empleado_pk PRIMARY KEY (rut),
	CONSTRAINT empleado_colegio_fk FOREIGN KEY (id_colegio) REFERENCES public.colegio(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
COMMENT ON TABLE public.empleado IS 'Empleado que es contratado por un colegio';

-- Column comments

COMMENT ON COLUMN public.empleado.rut IS 'Rut del empleado sin numero identificador';
COMMENT ON COLUMN public.empleado."numero identificador" IS 'Numero identificador del rut del empleado';
COMMENT ON COLUMN public.empleado.comuna IS 'Comuna en la que reside el empleado';
COMMENT ON COLUMN public.empleado.nombre IS 'Nombre del empleado';
COMMENT ON COLUMN public.empleado.apellido IS 'Apellido del empleado';
COMMENT ON COLUMN public.empleado.id_colegio IS 'Clave foranea del colegio';
COMMENT ON COLUMN public.empleado.rol IS 'Trabajo que realiza el empleado';
COMMENT ON COLUMN public.empleado.sueldo IS 'Sueldo del empleado mensual en CLP';



CREATE TABLE public.alumno (
	rut_alumno int4 NOT NULL,
	nombre varchar NULL,
	apellido varchar NULL,
	comuna varchar NULL,
	"numero identificador" varchar NULL,
	CONSTRAINT alumno_pk PRIMARY KEY (rut_alumno)
);
COMMENT ON TABLE public.alumno IS 'Alumno que asiste a clases';

-- Column comments

COMMENT ON COLUMN public.alumno.rut_alumno IS 'Rut del alumno como identificador';
COMMENT ON COLUMN public.alumno.nombre IS 'Nombre del alumno';
COMMENT ON COLUMN public.alumno.apellido IS 'Apellido del alumno';
COMMENT ON COLUMN public.alumno.comuna IS 'Comuna en la que reside el alumno';
COMMENT ON COLUMN public.alumno."numero identificador"  IS 'Codigo identificador del rut del alumno';



CREATE TABLE public.apoderado (
	rut_apoderado int4 NOT NULL,
	nombre varchar NULL,
	apellido varchar NULL,
	dirección varchar NULL,
	"numero identificador" varchar NULL,
	CONSTRAINT apoderado_pk PRIMARY KEY (rut_apoderado)
);
COMMENT ON TABLE public.apoderado IS 'Apoderado responsable de uno o más alumnos';

-- Column comments

COMMENT ON COLUMN public.apoderado.rut_apoderado IS 'Rut identifiador del apoderado';
COMMENT ON COLUMN public.apoderado.nombre IS 'Nombre del apoderado';
COMMENT ON COLUMN public.apoderado.apellido IS 'Apellido del apoderado';
COMMENT ON COLUMN public.apoderado.dirección IS 'Dirección de la calle en la que reside el apoderado';
COMMENT ON COLUMN public.apoderado."numero identificador" IS 'codigo identificador del rut del apoderado';


CREATE TABLE public."responsable de" (
	rut_alumno int4 NOT NULL,
	rut_apoderado int4 NOT NULL,
	relacion varchar NULL,
	CONSTRAINT responsable_de_pk PRIMARY KEY (rut_alumno,rut_apoderado),
	CONSTRAINT responsable_de_alumno_fk FOREIGN KEY (rut_alumno) REFERENCES public.alumno(rut_alumno) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
	CONSTRAINT responsable_de_apoderado_fk FOREIGN KEY (rut_apoderado) REFERENCES public.apoderado(rut_apoderado) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
COMMENT ON TABLE public."responsable de" IS 'Relación entre un alumno y un apoderado';

-- Column comments

COMMENT ON COLUMN public."responsable de".rut_alumno IS 'Rut del alumno sin codigo identificador';
COMMENT ON COLUMN public."responsable de".rut_apoderado IS 'Rut del apoderado sin codigo identificador';
COMMENT ON COLUMN public."responsable de".relacion IS 'Que es el apoderado para el alumno (padre, hermano, etc.)';


CREATE TABLE public.profesor (
	rut_profesor int4 NOT NULL,
	CONSTRAINT profesor_pk PRIMARY KEY (rut_profesor),
	CONSTRAINT profesor_empleado_fk FOREIGN KEY (rut_profesor) REFERENCES public.empleado(rut)
);
COMMENT ON TABLE public.profesor IS 'Empleado que es profesor del colegio';

-- Column comments

COMMENT ON COLUMN public.profesor.rut_profesor IS 'Rut del profesor sin codigo identificador como clave foranea de la tabla Empleado';


CREATE TABLE public.curso (
	año int4 NULL,
	id serial4 NOT NULL,
	grupo varchar NULL,
	nivel varchar NULL,
	CONSTRAINT curso_pk PRIMARY KEY (id)
);
COMMENT ON TABLE public.curso IS 'Curso del cual son parte los alumnos y un profesor jefe';

-- Column comments

COMMENT ON COLUMN public.curso.año IS 'Año en que se rigió el curso';
COMMENT ON COLUMN public.curso.id IS 'Identificador de un curso particular';
COMMENT ON COLUMN public.curso.grupo IS 'Grupo alfabético del curso';
COMMENT ON COLUMN public.curso.nivel IS 'Nivel del curso (B5=5to basico, M2=2do medio)';
ALTER TABLE public.curso ADD id_colegio serial4 NOT NULL;
COMMENT ON COLUMN public.curso.id_colegio IS 'Identificador del colegio al que corresponde el curso';
ALTER TABLE public.curso ADD CONSTRAINT curso_colegio_fk FOREIGN KEY (id_colegio) REFERENCES public.colegio(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT;



CREATE TABLE public.pertenecer (
	id serial4 NOT NULL,
	rut_alumno int4 NOT NULL,
	CONSTRAINT pertenecer_pk PRIMARY KEY (id,rut_alumno),
	CONSTRAINT pertenecer_alumno_fk FOREIGN KEY (rut_alumno) REFERENCES public.alumno(rut_alumno) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
	CONSTRAINT pertenecer_curso_fk FOREIGN KEY (id) REFERENCES public.curso(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
COMMENT ON TABLE public.pertenecer IS 'Relación entre un alumno y un curso';

-- Column comments

COMMENT ON COLUMN public.pertenecer.id IS 'Identificador del curso';
COMMENT ON COLUMN public.pertenecer.rut_alumno IS 'Rut del alumno sin numero identificador';


CREATE TABLE public.clases (
	id serial4 NOT NULL,
	materia varchar NULL,
	dia varchar NULL,
	inicio time NULL,
	salida time NULL,
	CONSTRAINT clases_pk PRIMARY KEY (id)
);
COMMENT ON TABLE public.clases IS 'Clases a la que asisten alumnos en el colegio';

-- Column comments

COMMENT ON COLUMN public.clases.id IS 'Identificador de una clase en particular';
COMMENT ON COLUMN public.clases.materia IS 'Materia que se enseña en la clase';
COMMENT ON COLUMN public.clases.dia IS 'Dia de la semana, de lunes a viernes, en que se realiza la clase';
COMMENT ON COLUMN public.clases.inicio IS 'Hora de inicio de una clase';
COMMENT ON COLUMN public.clases.salida IS 'Hora de salida de una clase';


CREATE TABLE public.asistir (
	rut_alumno int4 NOT NULL,
	id_clases serial4 NOT NULL,
	inasistencia int4 NOT NULL,
	CONSTRAINT asistir_pk PRIMARY KEY (rut_alumno,id_clases),
	CONSTRAINT asistir_clases_fk FOREIGN KEY (id_clases) REFERENCES public.clases(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
	CONSTRAINT asistir_alumno_fk FOREIGN KEY (rut_alumno) REFERENCES public.alumno(rut_alumno) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
COMMENT ON TABLE public.asistir IS 'Relación entre un alumno y una clase';

-- Column comments

COMMENT ON COLUMN public.asistir.rut_alumno IS 'Rut del alumno sin numero identificador';
COMMENT ON COLUMN public.asistir.id_clases IS 'Identificador de una clase en especifico';
COMMENT ON COLUMN public.asistir.inasistencia IS 'Contador de cuántas veces un alumno faltó a una clase en particular';


CREATE TABLE public.asumir (
	rut_profesor int4 NOT NULL,
	id_curso serial4 NOT NULL,
	CONSTRAINT asumir_pk PRIMARY KEY (rut_profesor,id_curso),
	CONSTRAINT asumir_curso_fk FOREIGN KEY (id_curso) REFERENCES public.curso(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
	CONSTRAINT asumir_profesor_fk FOREIGN KEY (rut_profesor) REFERENCES public.profesor(rut_profesor) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
COMMENT ON TABLE public.asumir IS 'Relación entre un profesor y un curso, donde el profesor tendría la jefatura de éste';

-- Column comments

COMMENT ON COLUMN public.asumir.rut_profesor IS 'Rut del profesor sin numero identificador';
COMMENT ON COLUMN public.asumir.id_curso IS 'Identificador de un curso en particular';


CREATE TABLE public.ensenar (
	rut_profesor int4 NOT NULL,
	id_clases serial4 NOT NULL,
	CONSTRAINT ensenar_pk PRIMARY KEY (rut_profesor,id_clases),
	CONSTRAINT ensenar_profesor_fk FOREIGN KEY (rut_profesor) REFERENCES public.profesor(rut_profesor) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
	CONSTRAINT ensenar_clases_fk FOREIGN KEY (id_clases) REFERENCES public.clases(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT
);
COMMENT ON TABLE public.ensenar IS 'Relación que tiene un profesor con una clase, donde el profesor enseña a los alumnos en dicha clase';

-- Column comments

COMMENT ON COLUMN public.ensenar.rut_profesor IS 'Rut del profesor sin codigo identificador';
COMMENT ON COLUMN public.ensenar.id_clases IS 'Identificador de una clase en particular';


CREATE TABLE public.corresponder (
	id_curso serial4 NOT NULL,
	id_clases serial4 NOT NULL,
	CONSTRAINT corresponder_pk PRIMARY KEY (id_curso,id_clases),
	CONSTRAINT corresponder_clases_fk FOREIGN KEY (id_clases) REFERENCES public.clases(id) ON DELETE SET DEFAULT ON UPDATE SET DEFAULT,
	CONSTRAINT corresponder_curso_fk FOREIGN KEY (id_curso) REFERENCES public.curso(id)
);
COMMENT ON TABLE public.corresponder IS 'Relación entre un curso y una clase, donde a un curso le corresponde una clase en específico';

-- Column comments

COMMENT ON COLUMN public.corresponder.id_curso IS 'Identificador de un curso';
COMMENT ON COLUMN public.corresponder.id_clases IS 'Identificador de una clase';
