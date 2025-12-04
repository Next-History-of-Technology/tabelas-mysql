DROP DATABASE IF EXISTS nh3;
CREATE DATABASE nh3;
USE nh3;

CREATE TABLE plano (
    idPlano INT AUTO_INCREMENT PRIMARY KEY,
    dtVencimentoPlano DATE NOT NULL,
    valorPlano DECIMAL(10,2) NOT NULL,
    tipoPlano VARCHAR(15) NOT NULL,
    CONSTRAINT chkTipoPlano CHECK (tipoPlano IN ('semestral','anual')),
    formaPagamento VARCHAR(30) NOT NULL,
    CONSTRAINT chkFormaPagamento CHECK (formaPagamento IN ('boleto', 'credito', 'pix', 'transferencia')),
    dtPagamento DATETIME DEFAULT CURRENT_TIMESTAMP
);


INSERT INTO plano VALUES
(default, '2025-11-14', 75000.00, 'semestral', 'boleto', default),
(default, '2025-06-10', 135000.00, 'anual', 'pix', default);

CREATE TABLE empresa (
    idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    nomeFantasia VARCHAR(60),
    razaoSocial VARCHAR(80),
    telefone VARCHAR(14),
    statusEmpresa TINYINT DEFAULT 1,
    codigoEmpresa CHAR(5) NOT NULL UNIQUE
);


INSERT INTO empresa VALUES
(default, '20420001461278', 'JBS', 'JBS Ltda', '11 987654532', default, '12345'),
(default, '11222333444455', 'Seara', 'Seara Alimentos SA', '11 999988777', default, 'SEAR1'),
(default, '99887766554433', 'Friboi', 'Friboi Carnes LTDA', '11 988776655', default, 'FRIB1');

CREATE TABLE empresa_plano (
    idEmpresaPlano INT PRIMARY KEY AUTO_INCREMENT,
    fkEmpresa INT,
    fkPlano INT,
    dataAdesao DATE,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    FOREIGN KEY (fkPlano) REFERENCES plano(idPlano)
);

INSERT INTO empresa_plano VALUES
(default, 1, 1, '2024-12-01'),
(default, 2, 1, '2024-12-02'),
(default, 3, 2, '2024-12-02');

CREATE TABLE cadastroFuncionario (
    idFuncionario INT AUTO_INCREMENT,
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa),
    PRIMARY KEY(idFuncionario, fkEmpresa),
    email VARCHAR(50) UNIQUE NOT NULL,
    nome VARCHAR(60) NOT NULL,
    senha VARCHAR(100) NOT NULL,
    telefone CHAR(15) UNIQUE NOT NULL,
    cpf VARCHAR(14) UNIQUE NOT NULL,
    statusFuncionario TINYINT DEFAULT 1,
    tipo VARCHAR(45) NOT NULL
);

ALTER TABLE cadastroFuncionario 
    ADD CONSTRAINT chkTipo CHECK(tipo IN ('suporte','funcionario'));

INSERT INTO cadastroFuncionario VALUES
(1, 1, 'amandha@jbs.com', 'Amandha', 'amandhajbs123', '11 965432524', '09854327689', default, 'suporte');


CREATE TABLE camaraFria (
    idCamaraFria INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(45),
    status TINYINT DEFAULT 1,
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO camaraFria VALUES 
(default, 'Câmara Bovinos', default, 1),
(default, 'Câmara Aves', default, 1),
(default, 'Câmara Suíno', default, 1);

CREATE TABLE localSensor (
    idLocalSensor INT PRIMARY KEY AUTO_INCREMENT,
    nomeLocal VARCHAR(45) NOT NULL,
    statusSensor TINYINT DEFAULT 1,
    fkCamaraFria INT NOT NULL,
    FOREIGN KEY (fkCamaraFria) REFERENCES camaraFria(idCamaraFria),
    fkEmpresa INT NOT NULL,
    FOREIGN KEY (fkEmpresa) REFERENCES empresa(idEmpresa)
);

INSERT INTO localSensor VALUES 
(default, 'evaporador', default, 1, 1),
(default, 'compressor', default, 1, 1),
(default, 'condensador', default, 1, 1),
(default, 'válvula de expansão', default, 1, 1),

(default, 'evaporador', default, 2, 1),
(default, 'compressor', default, 2, 1),
(default, 'condensador', default, 2, 1),
(default, 'válvula de expansão', default, 2, 1);

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    codSerie INT,
    dtInstalacao DATE,
    fklocalSensor INT,
    FOREIGN KEY (fklocalSensor) REFERENCES localSensor(idLocalSensor)
);

INSERT INTO sensor VALUES 
(default, 234567, '2025-11-14', 1),
(default, 234568, '2025-11-14', 2),
(default, 234569, '2025-11-14', 3),
(default, 234560, '2025-11-14', 4),
(default, 234560, '2025-11-14', 5),
(default, 234560, '2025-11-14', 6),
(default, 234560, '2025-11-14', 7),
(default, 234560, '2025-11-14', 8);

CREATE TABLE leitura (
    idLeitura INT AUTO_INCREMENT,
    fkSensor INT NOT NULL,
    FOREIGN KEY (fkSensor) REFERENCES sensor(idSensor),
    PRIMARY KEY(idLeitura, fkSensor),
    dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    valorPPM DECIMAL(5,2)
);

INSERT INTO leitura VALUES
(default, 1, default, 2),
(default, 2, default, 2),
(default, 3, default, 1),
(default, 4, default, 10),
(default, 5, default, 10),
(default, 6, default, 10),
(default, 7, default, 10),
(default, 8, default, 10);

CREATE VIEW view_empresa_plano AS
SELECT e.idEmpresa, e.nomeFantasia, e.codigoEmpresa,
       p.tipoPlano, p.valorPlano, p.formaPagamento, p.dtVencimentoPlano
FROM empresa e
JOIN empresa_plano ep ON ep.fkEmpresa = e.idEmpresa
JOIN plano p ON p.idPlano = ep.fkPlano;

CREATE VIEW view_sensores_leituras AS
SELECT 
    s.idSensor,
    ls.nomeLocal,
    cf.nome AS nomeCamara,
    l.valorPPM,
    l.dataHora
FROM sensor s
JOIN localSensor ls ON ls.idLocalSensor = s.fkLocalSensor
JOIN camaraFria cf ON cf.idCamaraFria = ls.fkCamaraFria
JOIN leitura l ON l.fkSensor = s.idSensor;

CREATE VIEW view_empresa_completa AS
SELECT 
    e.nomeFantasia,
    e.codigoEmpresa,
    f.nome AS funcionario,
    f.email,
    p.valorPlano,
    p.tipoPlano,
    p.formaPagamento,
    ls.nomeLocal,
    cf.nome AS camaraFria,
    l.valorPPM,
    l.dataHora
FROM empresa e
JOIN empresa_plano ep ON ep.fkEmpresa = e.idEmpresa
JOIN plano p ON p.idPlano = ep.fkPlano
JOIN cadastroFuncionario f ON f.fkEmpresa = e.idEmpresa
JOIN camaraFria cf ON cf.fkEmpresa = e.idEmpresa
JOIN localSensor ls ON ls.fkCamaraFria = cf.idCamaraFria
JOIN sensor s ON s.fklocalSensor = ls.idLocalSensor
JOIN leitura l ON l.fkSensor = s.idSensor;