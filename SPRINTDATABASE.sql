DROP DATABASE IF EXISTS ProjetoModelo;
CREATE DATABASE ProjetoModelo;

USE ProjetoModelo;

CREATE TABLE Empresa (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
CNPJ CHAR(14) UNIQUE NOT NULL,
nomeFantasia VARCHAR(60) NOT NULL,
razãoSocial VARCHAR(80) UNIQUE NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
telefone VARCHAR(14),
statusEmpresa TINYINT DEFAULT 1
);

CREATE TABLE Funcionario (
idFuncionario INT PRIMARY KEY AUTO_INCREMENT,
email VARCHAR(50) UNIQUE NOT NULL,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
telefone CHAR(13) UNIQUE NOT NULL,
cpf VARCHAR(11) UNIQUE NOT NULL,
statusFuncionario TINYINT DEFAULT 1,
fkEmpresa INT UNIQUE,
CONSTRAINT fkEmpresaFuncionario FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);

CREATE TABLE localMonitoramento (
	idLocal INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    setor VARCHAR(45) NOT NULL,
    fkEmpresa INT,
    CONSTRAINT fkLocalEmpresa FOREIGN KEY (fkEmpresa) 
		REFERENCES empresa(idEmpresa)
);

CREATE TABLE Sensor(
idSensor INT PRIMARY KEY AUTO_INCREMENT,
codSerie INT NOT NULL,
statusSensor TINYINT DEFAULT 1,
dtInstalacao DATE,
fkLocal INT,
    CONSTRAINT fkLocal FOREIGN KEY (fkLocal) 
		REFERENCES localMonitoramento(idLocal)
);

CREATE TABLE leitura (
	idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    dataHora  DATETIME DEFAULT CURRENT_TIMESTAMP,
    valorPPM  DECIMAL (5,2) NOT NULL,
	fkSensor INT,
    CONSTRAINT fkLeituraSensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

CREATE TABLE Plano (
idPlano INT PRIMARY KEY AUTO_INCREMENT,
dtVencimento DATE,
valorPlano DECIMAL (7,2),
tipoPlano VARCHAR(15),
statusPlano VARCHAR(15),
CONSTRAINT chkStatusPlano
	CHECK (statusPlano IN ('pago', 'pendente', 'atrasado')),
CONSTRAINT chkTipoPlano
	CHECK (tipoPlano IN ('mensal', 'semestral','anual')),
fkEmpresa INT,
CONSTRAINT fkEmpresaPlano FOREIGN KEY (fkEmpresa) REFERENCES Empresa(idEmpresa)
);


CREATE TABLE Pagamento (
idPagamento INT PRIMARY KEY AUTO_INCREMENT,
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
	CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME DEFAULT CURRENT_TIMESTAMP,
fkEmpresa INT,
CONSTRAINT fkEmpresaPagamento FOREIGN KEY(fkEmpresa) REFERENCES Empresa (idEmpresa)  
);


INSERT INTO Empresa (CNPJ, nomeFantasia ,razãoSocial, email, telefone) VALUES
('42599543000117', 'Itau' , 'Itau Unibanco', 'itaubanco@empresarial', '11957451375'),
('84224447000134', 'Casas Bahia' , 'Casas Bahia', 'casasbahia@vendas', '11959441622'),
('00000000000001', 'Btg Pactual' ,'Btg Pactual', 'btgpactual@empresarial', '11932111611'),
('00000000000002', 'Americanas' ,'Americanas', 'americanas@vendas', '11955555637'),
('00000000000003', 'Avanade' , 'Avanade', 'avanade@empresarial', '11999991637');
    
SELECT * FROM Empresa; 

INSERT INTO Funcionario (email, nome, senha, telefone, cpf) VALUES
('eduardo.nascimento@sptech.school', 'Eduardo Nascimento', 'Urubu100', '11937061684', '33688622666'),
('lucas.peres@sptech.school', 'Lucas Peres', 'Lp_2006', '11973239898', '55708075856'),
('arthur.rfreitas@sptech.scholl', 'Arthur Rodrigues', 'test0000', '11000000000', '10000000000'),
('cintia.azevedo@sptech.scholl', 'Cintia Miranda', 'test0001', '11000000001', '10000000001'),
('everton.silva@sptech.scholl', 'Everton Barbosa', 'test0002', '11000000002', '10000000002'),
('igor.fonseca@sptech.scholl', 'Igor Ruy', 'test0003', '11000000003', '10000000003');

SELECT * FROM Funcionario; 

INSERT INTO localMonitoramento(nome, setor, fkEmpresa)VALUES
('Tunel' , 'Setor Norte' , 1),
('Sala das Maquina' , 'Setor Norte' , 2),
('Sala Principal' , 'Setor Norte' , 2),
('Tunel' , 'Setor Sul' , 3);

SELECT * FROM localMonitoramento;

INSERT INTO Sensor(codSerie , dtInstalacao , fkLocal)VALUES
(111322 , '2024-09-11', 1),
(111333 , '2024-10-21', 2),
(111334 , '2024-12-30', 1),
(112111 , '2025-04-25', 3);

SELECT * FROM Sensor;


INSERT INTO Leitura(valorPPM, fkSensor) VALUES
(11 , 1),
(22 , 1),
(42 , 2),
(52 , 2),
(02 , 1);

SELECT * FROM Leitura;

INSERT Plano (dtVencimento, valorPlano, tipoPlano, statusPlano, fkEmpresa) VALUES
('2025-12-30' , 10000 , 'anual' , 'pago' , 1),
('2026-02-20' , 15000 , 'anual' , 'pago' , 2),
('2026-01-10' , 12000 , 'anual' , 'pago' , 3),
('2025-09-30' , 7000 , 'semestral' , 'pendente' , 4),
('2025-09-20' , 3000 , 'mensal' , 'atrasado' , 5);

SELECT * FROM Plano;


INSERT INTO Pagamento (formaPagamento , fkEmpresa)VALUES
('transferencia' , 1),
('pix' , 2),
('credito' , 3),
('transferencia' , 4),
('transferencia' , 4);

SELECT * FROM Pagamento;


    