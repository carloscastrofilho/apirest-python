
CREATE DATABASE agendai ;

USE agendai;

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

CREATE TABLE contacts (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    apelido VARCHAR(30) NOT NULL,
    email VARCHAR(250) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    active BIT DEFAULT(1),
    CONSTRAINT pk_contacts_id PRIMARY KEY (id)
);

