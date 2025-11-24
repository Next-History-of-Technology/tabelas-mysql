DROP DATABASE IF EXISTS nh3;
CREATE DATABASE nh3;
USE nh3;

CREATE TABLE plano (
idPlano INT AUTO_INCREMENT PRIMARY KEY,
dtVencimentoPlano DATE NOT NULL,
valorPlano DECIMAL (7,2) NOT NULL,
tipoPlano VARCHAR(15) NOT NULL,
CONSTRAINT chkTipoPlano
CHECK (tipoPlano IN ('semestral','anual')),
formaPagamento VARCHAR(30) NOT NULL,
CONSTRAINT chkFormaPagamento
CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
dtPagamento DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO plano VALUES
(default, '2025-11-14', '75.000', 'semestral', 'boleto', default);

CREATE TABLE empresa (
	idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
	CNPJ CHAR(14) NOT NULL UNIQUE,
	nomeFantasia VARCHAR(60),
	razaoSocial VARCHAR(80),
	telefone VARCHAR(14),
	statusEmpresa TINYINT DEFAULT 1,
	codigoEmpresa CHAR(5) NOT NULL UNIQUE,
    fkPlano INT,
    CONSTRAINT chkFkPlano 
    FOREIGN KEY (fkPlano)
    REFERENCES plano (idPlano)
);

INSERT INTO empresa VALUES
(default, '20420001461278', 'JBS', 'JBS Ltda', '11 987654532', default, '12345', 1);

CREATE TABLE cadastroFuncionario (
idFuncionario INT AUTO_INCREMENT,
fkEmpresa INT NOT NULL,
CONSTRAINT chkfkEmpresaFuncionario 
FOREIGN KEY (fkEmpresa) 
REFERENCES empresa(idEmpresa),
CONSTRAINT pkCompostaFuncionarioEmpresa
PRIMARY KEY(idFuncionario, fkEmpresa),
email VARCHAR(50) UNIQUE NOT NULL,
nome VARCHAR(60) NOT NULL,
senha VARCHAR(100) NOT NULL,
telefone CHAR(15) UNIQUE NOT NULL,
cpf VARCHAR(14) UNIQUE NOT NULL ,
statusFuncionario TINYINT DEFAULT 1
);

INSERT INTO cadastroFuncionario VALUES
(1, 1, 'amandha@jbs.com', 'Amandha', 'amandhajbs123', '11 965432524', '09854327689', default);



CREATE TABLE camaraFria (
idCamaraFria INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(45),
status TINYINT DEFAULT 1,
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) 
REFERENCES empresa(idEmpresa)
);

INSERT INTO camaraFria VALUES 
(default, 'Câmara Bovinos', default, 1);

CREATE TABLE localSensor (
idLocalSensor INT PRIMARY KEY AUTO_INCREMENT,
nomeLocal VARCHAR(45) NOT NULL,
statusSensor TINYINT DEFAULT 1,
fkCamaraFria INT NOT NULL,
CONSTRAINT chkfkLocalCamaraFria
FOREIGN KEY (fkCamaraFria) 
REFERENCES camaraFria(idCamaraFria),
fkEmpresa INT,
FOREIGN KEY (fkEmpresa) 
REFERENCES empresa(idEmpresa)
);
select * from localSensor;

INSERT INTO localSensor VALUES 
(default, 'evaporador', default, 1, 1),
(default, 'compressor', default, 1, 1),
(default, 'condensador', default, 1, 1),
(default, 'válvula de expansão', default, 1, 1);

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
codSerie INT,
dtInstalacao DATE,
fklocalSensor INT,
CONSTRAINT fkLocalSensorEmpresa
	FOREIGN KEY (fkLocalSensor) 
		REFERENCES localSensor(idLocalSensor)
);

INSERT INTO sensor VALUES 
(default, 234567, '2025-11-14', 1),
(default, 234568, '2025-11-14', 2),
(default, 234569, '2025-11-14', 3),
(default, 234560, '2025-11-14', 4);

CREATE TABLE leitura (
idLeitura INT AUTO_INCREMENT,
fkSensor INT NOT NULL,
CONSTRAINT fkSensorLeitura
FOREIGN KEY (fkSensor) 
REFERENCES sensor(idSensor),
CONSTRAINT pkCompostaLeituraSensor
PRIMARY KEY(idLeitura, fkSensor),
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
valorPPM DECIMAL(5,2)
);

INSERT INTO leitura VALUES
(default, 1, default, 7),
(default, 2, default, 8),
(default, 3, default, 9),
(default, 4, default, 10);


select * from empresa join cadastroFuncionario as func on func.fkEmpresa = empresa.idEmpresa join plano on empresa.fkPlano = plano.idPlano
join localSensor as local on local.fkEmpresa = empresa.idEmpresa join sensor on sensor.fklocalSensor = local.idLocalSensor
join leitura on leitura.fkSensor = sensor.idSensor join camaraFria as camara on camara.fkEmpresa = empresa.idEmpresa;

select empresa.nomeFantasia,
		empresa.codigoEmpresa,
        func.nome,
        func.email,
        plano.valorPlano,
        plano.tipoPlano,
        plano.formaPagamento,
        plano.dtVencimentoPlano,
        local.nomeLocal,
        camara.nome,
        leitura.dataHora,
        leitura.valorPPM
from empresa join cadastroFuncionario as func on func.fkEmpresa = empresa.idEmpresa join plano on empresa.fkPlano = plano.idPlano
join localSensor as local on local.fkEmpresa = empresa.idEmpresa join sensor on sensor.fklocalSensor = local.idLocalSensor
join leitura on leitura.fkSensor = sensor.idSensor join camaraFria as camara on camara.fkEmpresa = empresa.idEmpresa;



select * from leitura;

select * from cadastrofuncionario;

SELECT idEmpresa, CNPJ, nomeFantasia, razaoSocial, telefone, statusEmpresa, codigoEmpresa, fkPlano FROM empresa;