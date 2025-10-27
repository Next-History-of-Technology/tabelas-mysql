DROP DATABASE IF EXISTS nh3;
CREATE DATABASE nh3;
USE nh3;

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	CNPJ CHAR(14) NOT NULL UNIQUE,
	nomeFantasia VARCHAR(60),
	razaoSocial VARCHAR(80),
	telefone VARCHAR(14),
	statusEmpresa TINYINT DEFAULT 1,
	codigoEmpresa CHAR(5) NOT NULL UNIQUE
);

INSERT INTO empresa (CNPJ, nomeFantasia, razaoSocial, telefone, codigoEmpresa) VALUES
('42599543000117', 'Swift' , 'JBS S/A',  '11957451375', '10000'),
('84224447000134', 'Friboi' , 'Friboi', '11959441622', '10001'),
('00000000000001', 'Seara' ,'Seara Alimentos Ltda.',  '11932111611', '10002'),
('00000000000002', 'Perdigão' ,'PERDIGÃO AGROINDUSTRIAL S.A.', '11955555637', '10003'),
('00000000000003', 'Aurora' , 'COOPERATIVA CENTRAL AURORA ALIMENTOS', '11999991637', '10004'); 

SELECT * FROM empresa;

--
CREATE TABLE cadastroFuncionario (
idFuncionario INT AUTO_INCREMENT,
email VARCHAR(50) UNIQUE NOT NULL,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
telefone CHAR(13) UNIQUE NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL ,
statusFuncionario TINYINT DEFAULT 1,
fkEmpresa INT NOT NULL,
PRIMARY KEY(idFuncionario, fkEmpresa),
CONSTRAINT fkEmpresaFuncionario 
	FOREIGN KEY (fkEmpresa) 
		REFERENCES empresa(idEmpresa)
);

INSERT INTO cadastroFuncionario (fkEmpresa, email, nome, senha, telefone, cpf) VALUES
(1,'eduardo.nascimento@sptech.school', 'Eduardo Nascimento', 'Urubu100', '11937061684', '33688622666'),
(1,'lucas.peres@sptech.school', 'Lucas Peres', 'Lp_2006', '11973239898', '55708075856'),
(1,'arthur.rfreitas@sptech.school', 'Arthur Rodrigues', 'test0000', '11000000000', '10000000000'),
(2,'cintia.azevedo@sptech.school', 'Cintia Miranda', 'test0001', '11000000001', '10000000001'),
(2,'everton.silva@sptech.school', 'Everton Barbosa', 'test0002', '11000000002', '10000000002'),
(3,'igor.fonseca@sptech.school', 'Igor Ruy', 'test0003', '11000000003', '10000000003');

SELECT * FROM cadastroFuncionario;

-- 
CREATE TABLE plano (
idPagamento INT AUTO_INCREMENT PRIMARY KEY,
dtVencimentoPlano DATE NOT NULL,
valorPlano DECIMAL (7,2) NOT NULL,
tipoPlano VARCHAR(15) NOT NULL,
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
	CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chkTipoPlano
	CHECK (tipoPlano IN ('semestral','anual')),
fkEmpresa INT,
CONSTRAINT fkEmpresaPagamento 
	FOREIGN KEY(fkEmpresa) 
		REFERENCES empresa(idEmpresa)
);

INSERT INTO plano (formaPagamento , fkEmpresa , dtVencimentoPlano, tipoPlano, valorPlano)
VALUES
('transferencia', 1 , '2026-12-30', 'Anual' , 1000),
('pix', 2 , '2025-12-10', 'Anual', 1000),
('credito', 3 , '2026-01-12', 'Anual' , 1000),
('transferencia', 4 , '2025-10-10', 'Anual' , 1000),
('transferencia', 5 , '2025-10-15', 'Anual' , 1000);

SELECT * FROM plano;

-- 
CREATE TABLE camaraFria (
	idCamaraFria INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(45),
	status TINYINT DEFAULT 1,
	fkEmpresa INT,
	FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO camaraFria (nome, fkEmpresa) VALUES
('Câmara Fria 1', 1),
('Câmara Fria 2', 1),
('Câmara Fria 1', 2),
('Câmara Fria 1', 3),
('Câmara Fria 1', 4),
('Câmara Fria 1', 5);

SELECT * FROM camaraFria;

--
CREATE TABLE localSensor (
idLocalSensor INT PRIMARY KEY AUTO_INCREMENT,
nomeLocal VARCHAR(45) NOT NULL,
statusSensor TINYINT DEFAULT 1,
fkCamaraFria INT NOT NULL,
CONSTRAINT fkLocalCamaraFria
 FOREIGN KEY (fkCamaraFria) 
	REFERENCES camaraFria(idCamaraFria)
);

INSERT INTO localSensor (nomeLocal, fkCamaraFria) VALUES
('Compressor', 1),
('Evaporador', 1),
('Condensador', 1),
('Válvula de Expansão', 1),

('Compressor', 2),
('Evaporador', 2),
('Condensador', 2),
('Válvula de Expansão', 2),

('Compressor', 3),
('Evaporador', 3),
('Condensador', 3),
('Válvula de Expansão', 3),

('Compressor', 4),
('Evaporador', 4),
('Condensador', 4),
('Válvula de Expansão', 4),

('Compressor', 5),
('Evaporador', 5),
('Condensador', 5),
('Válvula de Expansão', 5);

SELECT * FROM localSensor;

-- 
CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
codSerie INT,
dtInstalacao DATE,
fklocalSensor INT,
CONSTRAINT fkLocalSensorEmpresa
	FOREIGN KEY (fkLocalSensor) 
		REFERENCES localSensor(idLocalSensor)
);

INSERT INTO sensor(codSerie, dtInstalacao, fkLocalSensor) VALUES
(111111, '2024-09-11', 1),
(222222, '2024-10-21', 2),
(333333, '2024-12-30', 3),
(444444, '2025-04-25', 4);

INSERT INTO  sensor(codSerie, dtInstalacao, fkLocalSensor) VALUES
(555555, '2024-09-11', 5),
(666666, '2024-10-21', 6),
(777777, '2024-12-30', 7),
(888888, '2025-04-25', 8);

INSERT INTO  sensor(codSerie, dtInstalacao, fkLocalSensor) VALUES
(999999, '2024-09-11', 9),
(101010, '2024-10-21', 10),
(110110, '2024-12-30', 11),
(121212, '2025-04-25', 12);

INSERT INTO  sensor(codSerie, dtInstalacao, fkLocalSensor) VALUES
(131313, '2024-09-11', 13),
(141414, '2024-10-21', 14),
(151515, '2024-09-03', 15),
(161616, '2025-04-25', 16);

SELECT * FROM sensor;

-- 

CREATE TABLE leitura (
idLeitura INT AUTO_INCREMENT,
dataHora DATETIME,
valorPPM DECIMAL(5,2),
PRIMARY KEY(idLeitura, fkSensor),
fkSensor INT NOT NULL,
CONSTRAINT fkSensorLeitura
	FOREIGN KEY (fkSensor) 
		REFERENCES sensor(idSensor)
);

INSERT INTO leitura (valorPPM, fksensor) VALUES
(3 , 1),
(2 , 2),
(2 , 3),
(5 , 4);

SELECT * FROM leitura;


