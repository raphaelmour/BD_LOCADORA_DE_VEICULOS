#CRIAÇÃO DO BANCO DE DADOS
CREATE DATABASE locadora_veiculos;
USE locadora_veiculos;

#CRIANDO AS TABELAS DO BANCO DE DADOS

CREATE TABLE usuarios (
id_usuario INT AUTO_INCREMENT,
nome VARCHAR(30) NOT NULL,
sobrenome VARCHAR(50) NOT NULL,
data_nasc DATE NOT NULL,
email VARCHAR(320) NOT NULL,


CONSTRAINT Pk_usuario_id_usuario PRIMARY KEY (id_usuario)
);

CREATE TABLE enderecos (
id_endereco INT AUTO_INCREMENT,
rua VARCHAR(40) NOT NULL,
n° INT NOT NULL,
bairro VARCHAR(50) NOT NULL,
cidade VARCHAR(50) NOT NULL,
estado VARCHAR(50) NOT NULL,
id_usuario INT,

CONSTRAINT Pk_endereco_id_endereco PRIMARY KEY (id_endereco),

CONSTRAINT Fk_endereco_id_usuario FOREIGN KEY (id_usuario)
	REFERENCES usuarios (id_usuario)
);

CREATE TABLE marcas (
id_marca INT AUTO_INCREMENT,
nome_marca VARCHAR(50) NOT NULL,

CONSTRAINT Pk_marcas_id_marca PRIMARY KEY (id_marca)
);

CREATE TABLE modelos (
id_modelo INT AUTO_INCREMENT,
nome_modelo VARCHAR(50) NOT NULL,
id_marca INT,

CONSTRAINT Pk_modelos_id_modelo PRIMARY KEY (id_modelo),

CONSTRAINT FK_modelos_id_marca FOREIGN KEY (id_marca)
	REFERENCES marcas (id_marca)
);

CREATE TABLE categoria (
id_categoria INT AUTO_INCREMENT,
nome VARCHAR(50) NOT NULL,

CONSTRAINT Pk_categoria_id_categoria PRIMARY KEY (id_categoria)
);

CREATE TABLE status_veiculo (
id_status_veiculo INT AUTO_INCREMENT,
nome_status VARCHAR(30),

CONSTRAINT Pk_statusVeiculo_id_status_veiculo PRIMARY KEY (id_status_veiculo)
);

CREATE TABLE veiculo (
id_veiculo INT AUTO_INCREMENT,
id_marca INT,
id_modelo INT,
id_categoria INT,
id_status_veiculo INT,
ano INT NOT NULL,
km INT NOT NULL,

CONSTRAINT Pk_veiculo_id_veiculo PRIMARY KEY (id_veiculo),

CONSTRAINT Fk_veiculo_id_marca FOREIGN KEY (id_marca)
	REFERENCES marcas (id_marca),
    
CONSTRAINT Fk_veiculo_id_modelo FOREIGN KEY (id_modelo)
	REFERENCES modelos (id_modelo),
    
CONSTRAINT Fk_veiculo_id_categoria FOREIGN KEY (id_categoria)
	REFERENCES categoria (id_categoria),
    
CONSTRAINT Fk_veiculo_id_status_veiculo FOREIGN KEY (id_status_veiculo)
	REFERENCES status_veiculo (id_status_veiculo)
);

CREATE TABLE reservas (
id_reserva INT AUTO_INCREMENT,
data_retirada DATE NOT NULL,
data_entrega DATE NOT NULL,
id_usuario INT,
id_veiculo INT,
valor_reserva DECIMAL,

CONSTRAINT Pk_reservas_id_reserva PRIMARY KEY (id_reserva),

CONSTRAINT Fk_reservas_id_usuario FOREIGN KEY (id_usuario)
	REFERENCES usuarios (id_usuario),
    
CONSTRAINT Fk_reservas_id_veiculo FOREIGN KEY (id_veiculo)
	REFERENCES veiculo (id_veiculo)
);

CREATE TABLE pagamento (
id_pagamento INT AUTO_INCREMENT,
nome_pagamento VARCHAR(50) NOT NULL,
status_pagamento VARCHAR(30),
id_reserva INT,

CONSTRAINT Pk_pagamento_id_pagamento PRIMARY KEY (id_pagamento),

CONSTRAINT Fk_pagamento_id_reserva FOREIGN KEY (id_reserva)
	REFERENCES reservas (id_reserva)
);


#INSERINDO DADOS NA TABLEA USUARIO && ENDERECO
INSERT INTO usuarios
VALUES (DEFAULT, 'Raphael', 'Moura', '1997/05/30', 'raphael.mourab@gmail.com');

INSERT INTO usuarios
VALUES (DEFAULT, 'João Gabriel', 'Barros', '2001/02/16', 'joaogabriel@yahoo.com');

INSERT INTO usuarios
VALUES (DEFAULT, 'Vanessa', 'Pereira Barcelos', '1985/10/05', 'vanessa@hotmail.com');


INSERT INTO enderecos (rua, n°, bairro, cidade, estado, id_usuario)
VALUES ('Formosa', 2, 'Figueira', 'Duque de Caxias', 'Rio de Janeiro', 1);

INSERT INTO enderecos (rua, n°, bairro, cidade, estado, id_usuario)
VALUES ('Formosa', 2, 'Figueira', 'Duque de Caxias', 'Rio de Janeiro', 1);

INSERT INTO enderecos (rua, n°, bairro, cidade, estado, id_usuario)
VALUES ('Panorama', 15, 'Barro Branco', 'Santa Cruz da Serra', 'Rio de Janeiro', 2);

INSERT INTO enderecos (rua, n°, bairro, cidade, estado, id_usuario)
VALUES ('Oscar Niemeyer', 225, 'Almirante da Paz', 'Suzano', 'São Paulo', 3);

INSERT INTO enderecos (rua, n°, bairro, cidade, estado)
VALUES ('Onze', '7', 'Jardim Rotsen', 'Nova Iguaçu', 'Rio de Janeiro');

INSERT INTO enderecos (rua, n°, bairro, cidade, estado)
VALUES ('Das Flores', '797', 'Jardins', 'Belo Horizonte', 'Minas Gerais');

INSERT INTO enderecos (rua, n°, bairro, cidade, estado)
VALUES ('Zelinho de Souza', '25', 'Figueira', 'Duque de Caxias', 'Rio de Janeiro');


#UPDATE NA TABELA ENDERECOS

UPDATE enderecos
SET rua = 'Av. Jornalista Sandro Moreyra', n° = 27, bairro = 'Jardim Primavera', id_usuario = 1
WHERE id_endereco = 2;


#DELETANDO REGISTRO NA TABELA ENDERECOS

DELETE
FROM enderecos
WHERE id_endereco = 5;


#SELECIONANDO DADOS NA TABELA ENDERECOS

SELECT *
FROM enderecos
WHERE id_usuario IS NOT NULL;



#Projeto Locadora de Veiculos
#Foi desenvolvido um BD para uma locadora de veículos, para ter um controle total de todos seus clientes que realizarem ou não uma reserva.
#Regras/Utilização:
#1° - O cliente pode se cadastrar sem ter a necessidade de realizar uma reserva.
#2° - Cada usuário precisa ter um endereço cadastrado, porém se quiser pode cadastrar outros.
#3° - O cliente pode fazer 1 ou várias reservas, porém cada reserva só pode ter 1 veículo.
#4° - Os veículos são separados por categorias, modelos e marcas.
#5° - Antes de ser feito a reserva, é checado o status do veículo requisitado (Disponível ou Indisponível).
#6° - Caso o veículo esteja disponível é liberado o pagamento da reserva.
#7° - Todo pagamento é verificado se está aprovado ou não. Sendo aprovado a reserva é confirmada, e o contrário também é válido, ou seja, se for reprovado a reserva não é liberada.