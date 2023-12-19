use master
create database Estudiantes
use Estudiantes

-- Creación de la tabla 'profesor'
create table profesor(
    idProfesor int primary key identity, -- Clave primaria, autoincremental
    nombreProfesor varchar(100), -- Campo para el nombre del profesor
    correoProfesor varchar(100), -- Campo para el correo electrónico del profesor
    contraProfesor varchar(500) -- Campo para la contraseña del profesor
)

-- Creación de la tabla 'estudiante'
create table estudiante(
    idEstudiante int primary key identity, -- Clave primaria, autoincremental
    nombreEstudiante varchar(100), -- Campo para el nombre del estudiante
    apellidoEstudiante varchar(100) -- Campo para el apellido del estudiante
)

-- Creación de la tabla 'materia'
create table materia(
    idMateria int primary key identity, -- Clave primaria, autoincremental
    nombreMateria varchar(20) -- Campo para el nombre de la materia
)

-- Creación de la tabla 'estudiantesMaterias', que relaciona estudiantes con materias
create table estudiantesMaterias(
    idEstudianteMaterias int Primary Key identity, -- Clave primaria, autoincremental
    FK_idEstudiante int not null foreign key references estudiante(idEstudiante), -- Clave foránea que referencia 'idEstudiante' de la tabla 'estudiante'
    FK_idMateria int not null foreign key references materia(idMateria), -- Clave foránea que referencia 'idMateria' de la tabla 'materia'
 )


-- Creación del procedimiento almacenado para el login de la app
--registrar usuarios 
create procedure regUsuarios(
@nombreProfesor varchar(100),
@correoProfesor varchar(100),
@contraProfesor varchar(500),
@registrado bit output,
@mensaje varchar(100) output
)
as 
begin 
if (not exists(select * from profesor where correoProfesor = @correoProfesor))
begin 
insert into profesor(nombreProfesor, correoProfesor, contraProfesor) values (@nombreProfesor, @correoProfesor, @contraProfesor)
set @registrado = 1
set @mensaje = 'Usuario registrado'
end 
else
begin
set @registrado = 0
set @mensaje = 'Usuario ya existe'
end
end

--Valida si existe el usuario en la base de datos si no es encontrado retorna el 0
Create procedure valUsuario(
@correoProfesor varchar (100),
@contraProfesor varchar (500)
)
as begin
if(exists(select * from profesor where correoProfesor = @correoProfesor and contraProfesor = @contraProfesor))
select idProfesor from profesor where correoProfesor = @correoProfesor and contraProfesor = @contraProfesor
else 
select '0' 
end





