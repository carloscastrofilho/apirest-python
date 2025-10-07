
USE mysql;

DROP DATABASE clinicapets;

CREATE DATABASE clinicapets;

USE clinicapets;

CREATE TABLE users (
    id INT NOT NULL AUTO_INCREMENT,
    login VARCHAR(60) NOT NULL UNIQUE,
    password VARCHAR(250) NOT NULL,
    name VARCHAR(100) NULL,
    active BIT DEFAULT(1),
    CONSTRAINT pk_users_id PRIMARY KEY (id)
);

CREATE TABLE roles (
    id INT NOT NULL AUTO_INCREMENT,
    role VARCHAR(15) NOT NULL UNIQUE,
    active BIT DEFAULT(1),
    CONSTRAINT pk_roles_id PRIMARY KEY (id)
);

CREATE TABLE users_roles (
    idrole INT NOT NULL,
    iduser INT NOT NULL,
    active BIT DEFAULT(1),
    CONSTRAINT pk_users_roles_ids PRIMARY KEY (idrole, iduser),
    CONSTRAINT fk_users_role_idrole FOREIGN KEY (idrole) REFERENCES roles (id),
    CONSTRAINT fk_users_role_iduser FOREIGN KEY (iduser) REFERENCES users (id)
);


CREATE TABLE veterinarios (
    id int NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NULL,
    email VARCHAR(80) NULL,
    crm VARCHAR(10) NULL,
    CONSTRAINT veterinarios_id PRIMARY KEY (id) 
);


CREATE TABLE especialidades (
    id int NOT NULL AUTO_INCREMENT,
    especilidade VARCHAR(60) NOT NULL,
    CONSTRAINT especialidades_id PRIMARY KEY (id)    
);


CREATE TABLE veterinarios_especialidades (
    id_veterinario int NOT NULL,
    id_especialidade int NOT NULL,
    principal BIT NOT NULL DEFAULT(1),   
    CONSTRAINT veterinarios_especialidades_id PRIMARY KEY (id_veterinario,id_especialidade)    
);

ALTER TABLE veterinarios_especialidades 
ADD CONSTRAINT fk_veterinarios_especialidades_id_veterinario FOREIGN KEY (id_veterinario) REFERENCES veterinarios (id);


ALTER TABLE veterinarios_especialidades 
ADD CONSTRAINT fk_veterinarios_especialidades_id_especialidade FOREIGN KEY (id_especialidade) REFERENCES especialidades (id);


CREATE TABLE racas (
 id INT NOT NULL AUTO_INCREMENT,
    raca VARCHAR(50) NOT NULL,
    CONSTRAINT pk_raca_id PRIMARY KEY (id)
);

CREATE TABLE especies (
    id INT NOT NULL AUTO_INCREMENT,
    especie VARCHAR(30) NOT NULL,
    CONSTRAINT pk_epecies_id PRIMARY KEY(id)
);

CREATE TABLE donos (
 id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NULL,
    email VARCHAR(80) NULL,
    CONSTRAINT pk_donos_id PRIMARY KEY (id)
);

CREATE TABLE animais (
 id INT NOT NULL  AUTO_INCREMENT,
    animal VARCHAR(30) NOT NULL,
    idade INT NOT NULL DEFAULT(0),
    id_dono INT NOT NULL,
    id_raca INT NOT NULL,
    id_especie INT NOT NULL,
    CONSTRAINT pk_animais_id PRIMARY KEY (id),    
    CONSTRAINT fk_animais_dono FOREIGN KEY (id_dono) REFERENCES donos (id),
    CONSTRAINT fk_animais_raca FOREIGN KEY (id_raca) REFERENCES racas (id),
    CONSTRAINT fk_animais_especies FOREIGN KEY (id_especie) REFERENCES especies (id)    
); 



CREATE TABLE laboratorios (
    id INT NOT NULL AUTO_INCREMENT,
    laboratorio VARCHAR(60) NOT NULL,
    telefone VARCHAR(15) NULL,
    CONSTRAINT pk_laboratorios_id PRIMARY KEY (id)
);


CREATE TABLE remedios (
	id INT NOT NULL AUTO_INCREMENT,
    remedio VARCHAR(80) NOT NULL,
    id_laboratorio INT NOT NULL,
    CONSTRAINT pk_remedios_id PRIMARY KEY (id),
    CONSTRAINT fk_remedios_laboratorios_id_laboratorio FOREIGN KEY (id_laboratorio) REFERENCES laboratorios (id)
);


CREATE TABLE atendimentos (
	id INT NOT NULL AUTO_INCREMENT,
    data_atendimento DATETIME NOT NULL,
    id_animal INT NOT NULL, 
    id_veterinario INT NOT NULL,
    CONSTRAINT pk_atendimentos_id PRIMARY KEY (id),
    CONSTRAINT fk_atendimentos_animal FOREIGN KEY ( id_animal ) REFERENCES animais (id),
    CONSTRAINT fk_atendimentos_veterinario FOREIGN KEY ( id_veterinario ) REFERENCES veterinarios (id)    
);

CREATE TABLE atendimentos_tratamentos (
    id INT NOT NULL AUTO_INCREMENT,
    dose VARCHAR(10) NOT NULL default '1',
    inicio VARCHAR(20) NULL,
    fim VARCHAR(20) NULL,
    id_remedio INT NOT NULL,
    id_atendimento INT NOT NULL,  
    CONSTRAINT pk_atendimentos_trata_id PRIMARY KEY (id),
    CONSTRAINT fk_atendimentos_trata_remedio_id_remedio FOREIGN KEY (id_remedio) REFERENCES remedios (id),
    CONSTRAINT fk_atendimentos_trata_atendi_id_atendimento FOREIGN KEY (id_atendimento) REFERENCES atendimentos (id)    
);

INSERT INTO users ( login, password , name )  VALUES
( 'teste1@teste','123456','teste inclusão via sql' ) ,
( 'teste2@teste','123456','teste inclusão via sql' ) ,
( 'teste3@teste','123456','teste inclusão via sql' ) ,
( 'teste4@teste','123456','teste inclusão via sql' ) ,
( 'teste5@teste','123456','teste inclusão via sql' ) ,
( 'teste6@teste','123456','teste inclusão via sql' ) ,
( 'teste7@teste','123456','teste inclusão via sql' ) ,
( 'teste8@teste','123456','teste inclusão via sql' ) ,
( 'teste9@teste','123456','teste inclusão via sql' ) ;


 INSERT INTO roles ( role )  VALUES 
 ( 'SUPER-ADMIN' ),
 ( 'ADMIN' ),
 ( 'SUPERVISOR' ),
 ( 'ATENTENDE' ),
 ( 'MEDICO' ),
 ( 'CLIENT' ) ;

 INSERT INTO users_roles ( idrole, iduser ) VALUES 
 ( 1,1),
 ( 2,2),
 ( 3,3),
 ( 4,4),
 ( 4,5),
 ( 5,6),
 ( 5,7),
 ( 5,8),
 ( 5,9);


INSERT INTO donos ( nome, telefone , email )  VALUES 
( 'José Marcos Silva','(16) 9.9999-1112','josemsilva@teste.com'),
( 'Marcos Rodrigues Oliveira','(16) 9.9998-1112','marcosroliveira@teste.com'),
( 'Maria Aparecida Silva','(16) 9.9199-1112','mariaapsilvateste.com'),
( 'Mario Marcos Alencar','(16) 9.9999-3112','mariamarcosalencar@teste.com'),
( 'Fatima Silva Jaguar','(16) 9.9992-2221','fatimasilvajaguar@teste.com') ;


INSERT INTO racas ( raca ) VALUES 
( 'cães' ),
( 'gatos' ),
( 'aranhas'),
( 'aves' ),
( 'ratos' );

INSERT INTO especies (especie) VALUES
('chiuao'),
('ciames'),
('caranguegeira'),
('papagaio'),
('ratão do Rio');


INSERT INTO animais ( animal , idade , id_dono , id_raca , id_especie ) VALUES 
( 'lukinha', '4', 1 , 1, 1),
( 'paquita', '2', 2 , 2, 2),
( 'xuxa', '3', 3 , 3, 3),
( 'pipoca', '1', 4 , 4, 4),
( 'latinha', '4', 5 , 1, 1);


INSERT INTO laboratorios ( laboratorio, telefone ) VALUES
('EMS', '(11) 3578-5885'),
('Hypera Pharma', '(31) 3578-3185'),
('Eurofarma', '(49) 3578-5849'),
('Aché','(11) 3278-2285'),
('Cimed', '(21) 3378-1455'),
('Libbs', '(21) 3578-4881');

INSERT INTO especialidades ( especilidade ) VALUES
('cardiologia'), 
('dermatologia'), 
('oncologia') ,
('oftalmologia' ),
('cirúrgicas'), 
('anestesiologia');

INSERT INTO remedios ( remedio, id_laboratorio) VALUES
('Capstar', 1),
('Bravecto', 2), 
('Drontal',3), 
('Chemital', 4), 
('Doxiciclina',1), 
('Firocoxib', 5),
('Ampicilina', 6)


INSERT INTO veterinarios ( nome, telefone, email , crm ) VALUES
('Miguel Junior', '(14)9.9999-1455', 'migueljunior@teste.com','794949'),
('Juliana Maria', '(14)9.9914-1987', 'julianamaria8890@teste.com','163466'),
('Fatima Rosalina', '(14)9.9998-1785', 'fatimaroalinhas863@teste.com', '47844'),
('João Plasmingo', '(14)9.9933-1785', 'joaoplasmingo32@teste.com', '1476521'),
('Murilo Rosa', '(14)9.9949-1455', 'murilorosadr@teste.com', '14747885');

INSERT INTO veterinarios_especialidades ( id_veterinario, id_especialidade , principal ) VALUES 
( 1, 1, 1),
( 2, 1, 1),
( 3, 1, 1),
( 4, 1, 1),
( 5, 1, 0),
( 1, 2, 0),
( 1, 3, 0),
( 4, 4, 0),
( 5, 2, 1),
( 3, 4, 0);


INSERT INTO atendimentos ( data_atendimento , id_animal , id_veterinario ) VALUES 
( '2025-10-07 19:00:00' , 1 , 1),
( '2025-10-07 19:00:00' , 2 , 1),
( '2025-10-07 17:00:00' , 2 , 2),
( '2025-10-07 18:00:00' , 3 , 3),
( '2025-10-07 12:00:00' , 4 , 2),
( '2025-10-07 11:00:00' , 5 , 3),
( '2025-10-07 10:00:00' , 2 , 1),
( '2025-10-07 13:00:00' , 3 , 3),
( '2025-10-07 14:00:00' , 4 , 4),
( '2025-10-07 15:00:00' , 5 , 4);

INSERT INTO atendimentos_tratamentos (  id_atendimento, id_remedio ,  dose, inicio, fim ) VALUES
( 1 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 1 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 2 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 2 , 5 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 3 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 3 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 3 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 4 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 4 , 4 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 4 , 5 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 4 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 5 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 5 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 6 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 6 , 5 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 7 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 7 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 7 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 8 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 8 , 4 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 8 , 5 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 9 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 9 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 9 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 9 , 5 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 10 , 1 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 10 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 10 , 3 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 1 , 2 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 2 , 4 , '200mlx4dd', '07/10/2025', '15/10/2025'),
( 3 , 5 , '200mlx4dd', '07/10/2025', '15/10/2025');

