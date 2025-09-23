DROP DATABASE IF EXISTS Projeto;
CREATE DATABASE Projeto;

USE Projeto;

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
CNPJ CHAR(14) UNIQUE NOT NULL,
nomeFantasia VARCHAR(60) NOT NULL,
razãoSocial VARCHAR(80) UNIQUE NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
statusUsuario TINYINT DEFAULT 1
);

CREATE TABLE Usuario (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
email VARCHAR(50) UNIQUE NOT NULL,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
telefone CHAR(13) UNIQUE NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
statusUsuario TINYINT DEFAULT 1,
fkEmpresa INT UNIQUE,
CONSTRAINT fkEmpresaUsuario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
dtRegistro DATE DEFAULT (CURRENT_DATE),
hrRegistro TIME DEFAULT (CURRENT_TIME),
niveldePPM FLOAT,
identificador INT NOT NULL,
localSensor VARCHAR(30) NOT NULL,
ppmMininmo INT,
ppmMaximo INT
);

CREATE TABLE Pagamento (
idPagamento INT PRIMARY KEY AUTO_INCREMENT,
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
	CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
fkUsuario INT,
CONSTRAINT fkUsuarioPagamento FOREIGN KEY(fkUsuario) REFERENCES Usuario (idUsuario)  
);

CREATE TABLE Plano (
idPlano INT PRIMARY KEY AUTO_INCREMENT,
statusPlano VARCHAR(15),
CONSTRAINT chkStatusPlano
	CHECK (statusPlano IN ('pago', 'pendente', 'atrasado')),
    
tipoPlano VARCHAR(15),
CONSTRAINT chkTipoPlano
	CHECK (tipoPlano IN ('mensal', 'semestral','anual')),

dtVencimento DATE,
valorPlano DECIMAL (7,2),
fkUsuario INT,
CONSTRAINT fkUsuarioPlano FOREIGN KEY (fkUsuario) REFERENCES Usuario(idUsuario)
);

CREATE TABLE Alerta(
idAlerta INT PRIMARY KEY AUTO_INCREMENT,
dtAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
motivoAlerta VARCHAR(100),
statusResolvido VARCHAR(20),
CONSTRAINT chkStatusResolvido
	CHECK (statusResolvido IN ('Resolvido','Não resolvido', 'Outros')),
fkSensor INT,
CONSTRAINT fkSensorAlerta FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
fkEmpresa INT,
CONSTRAINT fkEmpresaAlerta FOREIGN KEY(fkEmpresa) REFERENCES Empresa (idEmpresa)  
);


INSERT INTO Empresa (CNPJ, nomeFantasia ,razãoSocial, email) VALUES
	('42599543000117', 'Itau' , 'Itau Unibanco', 'itaubanco@empresarial'),
    ('84224447000134', 'Casas Bahia' , 'Casas Bahia', 'casasbahia@vendas'),
    ('00000000000001', 'Btg Pactual' ,'Btg Pactual', 'btgpactual@empresarial'),
    ('00000000000002', 'Americanas' ,'Americanas', 'americanas@vendas'),
    ('00000000000003', 'Avanade' , 'Avanade', 'avanade@empresarial');
    
SELECT * FROM Empresa; 

INSERT INTO Usuario (email, nome, senha, telefone, cpf) VALUES
	('eduardo.nascimento@sptech.school', 'Eduardo Nascimento', 'Urubu100', '11937061684', '33688622666'),
    ('lucas.peres@sptech.school', 'Lucas Peres', 'Lp_2006', '11973239898', '55708075856'),
    ('arthur.rfreitas@sptech.scholl', 'Arthur Rodrigues', 'test0000', '11000000000', '10000000000'),
    ('cintia.azevedo@sptech.scholl', 'Cintia Miranda', 'test0001', '11000000001', '10000000001'),
    ('everton.silva@sptech.scholl', 'Everton Barbosa', 'test0002', '11000000002', '10000000002'),
    ('igor.fonseca@sptech.scholl', 'Igor Ruy', 'test0003', '11000000003', '10000000003');

SELECT * FROM Usuario; 

INSERT INTO sensor (niveldePPM, identificador, localSensor) VALUES
	(20, 1, 'Camera fria 15, parede 2'),
	(50, 2, 'Camera fria 12, parede 1'),
	(30, 3, 'Camera fria 09, parede 3'),
	(22, 1, 'Camera fria 15, parede 2'),
	(51, 2, 'Camera fria 12, parede 1'),
	(37, 3, 'Camera fria 09, parede 3'),
	(24, 1, 'Camera fria 15, parede 2'),
	(52, 2, 'Camera fria 12, parede 1'),
	(44, 3, 'Camera fria 09, parede 3'),
    (26, 1, 'Camera fria 15, parede 2'),
	(53, 2, 'Camera fria 12, parede 1'),
	(51, 3, 'Camera fria 09, parede 3');

SELECT * FROM Sensor;

INSERT INTO Pagamento VALUES
(DEFAULT, 'pix', '2025-09-20 12:00:00'),
(DEFAULT, 'credito', '2025-12-02 13:10:00'),
(DEFAULT, 'transferencia', '2025-07-06 10:20:00'),
(DEFAULT, 'boleto', '2025-04-10 09:30:00'),
(DEFAULT, 'pix', '2025-11-15 11:00:00'),
(DEFAULT, 'boleto', '2025-08-11 15:45:00'),
(DEFAULT, 'credito', '2025-05-03 16:00:00'),
(DEFAULT, 'transferencia', '2025-06-02 17:28:00');

SELECT * FROM Pagamento;

INSERT Plano VALUES
(DEFAULT, 'pago','mensal','2025-10-08',10000.00),
(DEFAULT,'pendente','mensal','2025-06-10',1274.00),
(DEFAULT,'atrasado','anual','2025-05-10',18000.00),
(DEFAULT,'atrasado','mensal','2025-08-27',10000.00),
(DEFAULT,'pendente','anual','2025-01-04',14678.00),
(DEFAULT,'pago','mensal','2025-12-27',19000.00),
(DEFAULT,'pago','mensal','2025-07-18',10000.00),
(DEFAULT,'pendente','anual','2025-01-01',2810.00),
(DEFAULT,'pago','anual','2025-11-07',2190.00);
    
SELECT * FROM Plano;

INSERT INTO Alerta (motivoAlerta , statusResolvido , idUsuario) VALUES
('PPM do gas de amonia 28%', 'Resolvido' , 1),
('PPM do gas de amonia 58%', 'Resolvido' , 1),
('PPM do gas de amonia 23%', 'Resolvido' , 1),
('PPM do gas de amonia 28%', 'Resolvido' , 1);

SELECT * FROM Alerta;

/*
SELECT nome AS 'Nome completo',
		email AS 'Email cadastrado',
        telefone AS 'Telefone cadastrado',
        cpf AS 'CPF cadastrado'
        FROM Usuario
        ORDER BY nome;
        
SELECT * FROM Usuario
	WHERE cpf = '55708075856';
    
SELECT * FROM Usuario
	WHERE telefone = '11937061684';

-- ---------------------------------- --
 
SELECT * FROM Empresa;

SELECT idEmpresa AS 'Número de cadastro',
		CNPJ AS 'CNPJ da empresa',
		razãoSocial AS 'Razão Social da empresa',
		email AS 'Email cadastrado'
        FROM empresa;
        
SELECT * FROM empresa
	WHERE email LIKE '%@empresarial';
    
SELECT * FROM empresa
	WHERE email LIKE '%@vendas';

-- ----------------------------- --
    
SELECT * FROM sensor;
    
SELECT * FROM sensor;
SELECT dtRegistro AS 'Data e hora do registro',
		niveldePPM AS 'Concentração do gás em PPM',
        identificador AS 'Identificador do Sensor',
        localSensor AS 'Local do Sensor'
        FROM sensor;

SELECT * FROM sensor
	WHERE dtRegistro > '2025-08-28 00:00:00' AND dtRegistro < '2025-08-29 00:00:00';
    
SELECT * FROM sensor
	WHERE identificador = 1;
    
SELECT * FROM sensor
	WHERE identificador = 2;
    
SELECT * FROM sensor
	WHERE identificador = 3;
    
SELECT niveldePPM AS 'Concentração do gás em PPM',
		dtRegistro AS 'Data e hora do registro',
        identificador AS 'Identificador do Sensor',
        localSensor AS 'Local do Sensor'
        FROM sensor
        WHERE niveldePPM >= 50;
        
SELECT  identificador AS 'Identificador do Sensor',
		dtRegistro AS 'Data e hora do registro',
        localSensor AS 'Local do Sensor',
        niveldePPM AS 'Concentração do gás em PPM',
        CASE
			WHEN niveldePPM = 0  THEN 'Zero'
			WHEN niveldePPM > 0 AND niveldePPM < 25 THEN 'Baixo'
			WHEN niveldePPM >= 25 AND niveldePPM < 50 THEN 'Médio'
			WHEN niveldePPM >= 50 AND niveldePPM < 100 THEN 'Alto'
			WHEN niveldePPM >= 100 AND niveldePPM < 500 THEN 'Crítico'
			WHEN niveldePPM >= 500 THEN 'Fatal'
		END as 'Classificação'
        FROM sensor;
            
-- ------------------------------ --
*/
    