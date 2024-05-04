/*CONSULTAS UNIVERSIDAD*/
/*1*/SELECT apellido1, apellido2, nombre, tipo FROM persona WHERE tipo like 'alumno' ORDER BY apellido1, apellido2, nombre ASC;
/*2*/SELECT nombre, apellido1, apellido2, tipo, telefono = null FROM persona WHERE tipo LIKE 'alumno';
/*3*/SELECT * FROM persona WHERE YEAR (fecha_nacimiento) = 1999 AND tipo = 'alumno';--- muestra los registros null
/*4*/SELECT * FROM persona WHERE tipo LIKE 'profesor' AND telefono is null AND nif LIKE '%k'; -- muestra los registros null
/*5*/SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
/*6*/SELECT apellido1, persona.apellido2, persona.nombre, departamento.nombre FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON departamento.id = profesor.id_departamento WHERE persona.tipo = 'profesor' ORDER BY persona.apellido1, persona.apellido2, persona.nombre ASC;
/*7*/SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona JOIN alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_alumno = persona.id JOIN asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN curso_escolar ON curso_escolar.id = asignatura.curso WHERE nif LIKE '26902806M'; -- He puesto que muestre el nif porque asi era mas facil verificar que correspondia al nif pedido, sino habria que solo quitar persona.nif
/*8*/SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON profesor.id_departamento = departamento.id JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON asignatura.id_grado = grado.id WHERE grado.nombre LIKE '%Grado en Ingeniería Informática (Plan 2015)%';
/*9*/SELECT DISTINCT persona.*, curso_escolar.anyo_inicio, curso_escolar.anyo_fin FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.anyo_inicio = 2018 AND curso_escolar.anyo_fin = 2019;

/*LEFT JOIN y RIGHT JOIN*/
/*1*/SELECT departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE tipo = 'profesor' ORDER BY departamento.nombre, persona.apellido1, persona.apellido2, persona.nombre ASC;
/*2*/SELECT * FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor WHERE persona.tipo = 'profesor' AND profesor.id_departamento IS NULL;-- Listado con todos los datos de persona profesor
/*3*/SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL;
/*4*/SELECT * FROM persona LEFT JOIN asignatura ON asignatura.id_profesor = persona.id WHERE asignatura.id_profesor IS NULL AND persona.tipo = 'profesor'; -- Listado con todos los datos de persona profesor
/*5*/SELECT asignatura.nombre FROM asignatura LEFT JOIN profesor ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL;
/*6*/SELECT departamento.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor LEFT JOIN curso_escolar ON asignatura.curso = curso_escolar.id WHERE asignatura.curso IS NULL;

/*CONSULTAS RESUMEN UNIVERSIDAD*/
/*1*/SELECT COUNT(*) FROM persona WHERE tipo = 'alumno'; 
/*2*/SELECT COUNT(*) FROM persona WHERE YEAR (fecha_nacimiento) = 1999;
/*3*/SELECT COUNT(*), departamento.nombre FROM profesor JOIN departamento ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre ORDER BY COUNT(*) DESC;
/*4*/SELECT COUNT(profesor.id_profesor), departamento.nombre FROM profesor RIGHT JOIN departamento ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre; -- poniendo solo el * en el count contaba los null como 1 en lso departamento que no tenia profesores asociados.
/*5*/SELECT COUNT(asignatura.id), grado.nombre FROM asignatura RIGHT JOIN grado ON grado.id = asignatura.id_grado GROUP BY grado.nombre ORDER BY COUNT(*) DESC;
/*6*/SELECT COUNT(asignatura.id), grado.nombre FROM grado LEFT JOIN asignatura ON grado.id = asignatura.id_grado GROUP BY grado.nombre HAVING COUNT(asignatura.id) > 40;
/*7*/SELECT grado.nombre AS 'Grado', asignatura.nombre AS 'Asignatura', asignatura.creditos FROM asignatura JOIN grado ON grado.id = asignatura.id_grado GROUP BY asignatura.nombre ORDER BY asignatura.creditos DESC; -- inclui dentro del listado los null, si solo se quisiera ver los que no
/*8*/SELECT COUNT(*) AS 'Total alumnos', curso_escolar.anyo_inicio AS 'Año de inicio' FROM alumno_se_matricula_asignatura JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar GROUP BY curso_escolar.anyo_inicio;
/*9*/SELECT COUNT(*) AS 'Total asignaturas', persona.id, persona.nombre, persona.apellido1, persona.apellido2 FROM asignatura JOIN persona ON persona.id = asignatura.id_profesor GROUP BY persona.id, persona.nombre, persona.apellido1, persona.apellido2;
/*10*/SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);
/*11*/SELECT * FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.id_profesor IS NULL AND persona.tipo = 'profesor'; 

/*CONSULTA TIENDA*/
/*1*/SELECT nombre FROM producto;
/*2*/SELECT nombre, precio FROM producto;
/*3*/SELECT * FROM producto;
/*6*/SELECT UPPER(nombre), precio FROM producto;
/*7*/SELECT LOWER(nombre), precio FROM producto;
/*8*/SELECT nombre, UPPER(LEFT(nombre, 2)) FROM fabricante;
/*9*/SELECT nombre, ROUND(precio) FROM producto;
/*10*/SELECT nombre, TRUNCATE(precio, 0) FROM producto; 
/*11*/SELECT fabricante.codigo FROM fabricante JOIN producto ON producto.codigo_fabricante = fabricante.codigo;
/*12*/SELECT DISTINCT fabricante.codigo FROM fabricante JOIN producto ON producto.codigo_fabricante = fabricante.codigo; 
/*13*/SELECT nombre FROM fabricante ORDER BY nombre ASC;
/*14*/SELECT nombre FROM fabricante ORDER BY nombre DESC;
/*15*/SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC;
/*16*/SELECT * FROM fabricante LIMIT 5;
/*17*/SELECT * FROM fabricante LIMIT 2 OFFSET 3;
/*18*/SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
/*19*/SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
/*20*/SELECT nombre, codigo_fabricante FROM producto WHERE codigo_fabricante = 2; -- inclui codigo para realizar la comprobacion
/*21*/SELECT producto.nombre AS 'Nombre producto', producto.precio, fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*22*/SELECT producto.nombre AS 'Nombre producto', producto.precio, fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;
/*23*/SELECT producto.codigo AS 'Codigo producto', producto.nombre AS 'Nombre producto', fabricante.codigo AS 'Codigo fabricante', fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;
/*24*/SELECT producto.nombre AS 'Nombre producto', producto.precio, fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio ASC LIMIT 1;
/*25*/SELECT producto.nombre AS 'Nombre producto', producto.precio, fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY precio DESC LIMIT 1;
/*26*/SELECT producto.nombre AS 'Nombre producto' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE 'Lenovo';
/*27*/SELECT producto.nombre AS 'Nombre producto' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio > 200 AND fabricante.nombre LIKE 'Crucial';
/*28*/SELECT producto.nombre AS 'Nombre producto' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE 'Asus' OR fabricante.nombre LIKE 'Hewlett-Packard' OR fabricante.nombre LIKE 'Seagate';
/*29*/SELECT producto.nombre AS 'Nombre producto' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre IN ('Asus', 'Hewlett-Packard', 'Seagate');
/*30*/SELECT producto.nombre AS 'Nombre producto', producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';
/*31*/SELECT producto.nombre AS 'Nombre producto', producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';
/*32*/SELECT producto.nombre AS 'Nombre producto', producto.precio, fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio > 180 ORDER BY producto.precio DESC, producto.nombre ASC;
/*33*/SELECT DISTINCT fabricante.codigo AS 'Codigo fabricante', fabricante.nombre AS 'Nombre fabricante' FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.codigo_fabricante IS NOT NULL;
