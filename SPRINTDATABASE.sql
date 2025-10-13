drop database if exists nh3;
CREATE DATABASE nh3;
USE nh3;



CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
CNPJ CHAR(14) UNIQUE NOT NULL,
nomeFantasia VARCHAR(60) NOT NULL,
razãoSocial VARCHAR(80) UNIQUE NOT NULL,
telefone VARCHAR(14),
statusEmpresa TINYINT DEFAULT 1
);

CREATE TABLE Funcionario (
idFuncionario INT AUTO_INCREMENT,
email VARCHAR(50) UNIQUE NOT NULL,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
telefone CHAR(13) UNIQUE NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL ,
statusFuncionario TINYINT DEFAULT 1,
PRIMARY KEY(idFuncionario , fkEmpresa),
fkEmpresa INT NOT NULL,
CONSTRAINT fkEmpresaFuncionario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
codSerie INT NOT NULL UNIQUE,
statusSensor TINYINT DEFAULT 1 NOT NULL,
dtInstalacao DATE,
localSensor VARCHAR(45),
fkEmpresa INT,
CONSTRAINT fkLocalEmpresa FOREIGN KEY (fkEmpresa) 
		REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Leitura (
	idLeitura INT NOT NULL AUTO_INCREMENT,
    dataHora  DATETIME DEFAULT CURRENT_TIMESTAMP,
    valorPPM  DECIMAL (5,2) NOT NULL,
	fkSensor INT NOT NULL,
	PRIMARY KEY(idLeitura, fkSensor),
    CONSTRAINT fkLeituraSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);



CREATE TABLE Pagamento (
idPagamento INT AUTO_INCREMENT,
fkPlano INT,
dtVencimento DATE NOT NULL,
valorPlano DECIMAL (7,2) NOT NULL,
tipoPlano VARCHAR(15) NOT NULL,
PRIMARY KEY (idPagamento , fkPlano),
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
	CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chkTipoPlano
	CHECK (tipoPlano IN ('semestral','anual')),
fkEmpresa INT,
CONSTRAINT fkEmpresaPagamento FOREIGN KEY(fkEmpresa) REFERENCES Empresa (idEmpresa)
);

INSERT INTO Empresa (CNPJ, nomeFantasia ,razãoSocial, telefone) VALUES
('42599543000117', 'Itau' , 'Itau Unibanco',  '11957451375'),
('84224447000134', 'Casas Bahia' , 'Casas Bahia', '11959441622'),
('00000000000001', 'Btg Pactual' ,'Btg Pactual',  '11932111611'),
('00000000000002', 'Americanas' ,'Americanas', '11955555637'),
('00000000000003', 'Avanade' , 'Avanade', '11999991637');
    
SELECT * FROM Empresa; 

INSERT INTO Funcionario (fkEmpresa, email, nome, senha, telefone, cpf) VALUES
(1,'eduardo.nascimento@sptech.school', 'Eduardo Nascimento', 'Urubu100', '11937061684', '33688622666'),
(1,'lucas.peres@sptech.school', 'Lucas Peres', 'Lp_2006', '11973239898', '55708075856'),
(1,'arthur.rfreitas@sptech.school', 'Arthur Rodrigues', 'test0000', '11000000000', '10000000000'),
(2,'cintia.azevedo@sptech.school', 'Cintia Miranda', 'test0001', '11000000001', '10000000001'),
(2,'everton.silva@sptech.school', 'Everton Barbosa', 'test0002', '11000000002', '10000000002'),
(3,'igor.fonseca@sptech.school', 'Igor Ruy', 'test0003', '11000000003', '10000000003');

SELECT * FROM Funcionario; 

INSERT INTO Sensor(codSerie , dtInstalacao , localSensor)VALUES
(111322 , '2024-09-11', 'camara Fria 1'),
(111333 , '2024-10-21', 'camara Fria 1'),
(111334 , '2024-12-30', 'camara Fria 2'),
(112111 , '2025-04-25', 'camara Fria 2');

SELECT * FROM Sensor;

INSERT INTO Leitura(valorPPM, fkSensor) VALUES
(11 , 1),
(22 , 1),
(42 , 2),
(52 , 2),
(02 , 1);

SELECT * FROM Leitura;


INSERT INTO Pagamento (fkPlano,  formaPagamento , fkEmpresa , dtVencimento, tipoPlano, valorPlano)VALUES
(1,'transferencia' , 1 , '2026-12-30' , 'Anual' , 1000),
(2,'pix' , 2 , '2025-12-10' , 'Anual' , 1000),
(1,'credito' , 3 , '2026-01-12' , 'Anual' , 1000),
(1,'transferencia' , 4 , '2025-10-10' , 'Anual' , 1000),
(2,'transferencia' , 4 , '2025-10-15' , 'Anual' , 1000);

SELECT * FROM Pagamento;


