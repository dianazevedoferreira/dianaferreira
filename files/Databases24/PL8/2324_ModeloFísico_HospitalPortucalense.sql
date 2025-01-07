-- Universidade do Minho
-- Bases de Dados 2024
-- Caso de Estudo: Hospital Portucalense

-- -----------------------------------------------------
-- Schema HospitalPortucalense_24
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `HospitalPortucalense_24` DEFAULT CHARACTER SET utf8 ;
USE `HospitalPortucalense_24` ;

-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`seguradoras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`seguradoras` (
  `id_seguradora` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cobertura` DECIMAL(3,2) NOT NULL DEFAULT 0.00,
    -- Adicionar uma check constraint para garantir a inserção de valores entre 0.00 e 1.00
  CONSTRAINT `chk_cobertura` CHECK(`cobertura` >= 0.00 AND `cobertura` <= 1.00),
  PRIMARY KEY (`id_seguradora`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`seguros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`seguros` (
  `nr_apolice` INT NOT NULL AUTO_INCREMENT,
  `dta_ini` DATE NOT NULL,
  `dta_fim` DATE NULL,
  `comparticipacao` CHAR(1) NOT NULL,
  `id_seguradora` INT NOT NULL,
  -- Adicionar uma check constraint para garantir que a dta_fim é sempre posterior à dta_ini
  CONSTRAINT `chk_dtas_seguros` CHECK(`dta_fim` > `dta_ini`),
  -- Adicionar uma check constraint para limitar os valores da comparticipacao
  -- C-co-pagamento, R-reembolso
  CONSTRAINT `chk_comparticipacao` CHECK(`comparticipacao` IN ('C', 'R')),
  PRIMARY KEY (`nr_apolice`),
  CONSTRAINT `fk_seguros_seguradoras`
    FOREIGN KEY (`id_seguradora`)
    REFERENCES `HospitalPortucalense_24`.`seguradoras` (`id_seguradora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`pacientes` (
  `nr_sequencial` INT NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `dta_nascimento` DATE NOT NULL,
  `sexo` CHAR(1) NOT NULL,
  `estado_civil` CHAR(1) NULL,
  `NIF` CHAR(9) NOT NULL UNIQUE,
  `nr_utente` CHAR(9) NOT NULL UNIQUE,
  `rua` VARCHAR(100) NOT NULL,
  `localidade` VARCHAR(45) NOT NULL,
  `cod_postal` CHAR(8) NOT NULL,
  `nr_apolice` INT NULL,
  `tutor` INT NULL,
  -- Adicionar uma check constraint para garantir que o nr_sequencial tem sempre 6 dígitos
  CONSTRAINT `chk_nr_sequencial` CHECK(LENGTH(`nr_sequencial`) = 6),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna sexo
  -- F-feminino, M-masculino, I-indefinido
  CONSTRAINT `chk_sexo` CHECK(`sexo` IN ('F','M','I')),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna estado_civil
  -- S-solteiro, C-casado, D-divorciado, V-viúvo
  CONSTRAINT `chk_estado_civil` CHECK(`estado_civil` IN ('S', 'C', 'D', 'V')),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna cod_postal
  CONSTRAINT `chk_cod_postal` CHECK (`cod_postal` REGEXP '^[0-9]{4}-[0-9]{3}$'),
  PRIMARY KEY (`nr_sequencial`),
  CONSTRAINT `fk_pacientes_seguros`
    FOREIGN KEY (`nr_apolice`)
    REFERENCES `HospitalPortucalense_24`.`seguros` (`nr_apolice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pacientes_pacientes`
    FOREIGN KEY (`tutor`)
    REFERENCES `HospitalPortucalense_24`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`telefones_pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`telefones_pacientes` (
  `nr_telefone` CHAR(9) NOT NULL,
  `nr_sequencial` INT NOT NULL,
  PRIMARY KEY (`nr_telefone`, `nr_sequencial`),
  CONSTRAINT `fk_Telefone_pacientes_Paciente`
    FOREIGN KEY (`nr_sequencial`)
    REFERENCES `HospitalPortucalense_24`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`emails_pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`emails_pacientes` (
  `email` VARCHAR(45) NOT NULL,
  `nr_sequencial` INT NOT NULL,
  PRIMARY KEY (`email`, `nr_sequencial`),
  CONSTRAINT `fk_Email_pacientes_Paciente`
    FOREIGN KEY (`nr_sequencial`)
    REFERENCES `HospitalPortucalense_24`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`funcionarios` (
  `nr_mec` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `dta_ini` DATE NOT NULL,
  `dta_fim` DATE NULL,
  -- Adicionar uma check constraint para garantir que a dta_fim é sempre posterior à dta_ini
  CONSTRAINT `chk_dtas_funcionarios` CHECK(`dta_fim` > `dta_ini`),
  PRIMARY KEY (`nr_mec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`especialidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`especialidades` (
  `cod_especialidade` INT NOT NULL AUTO_INCREMENT,
  `des_especialidade` VARCHAR(45) NOT NULL,
  `preco_consulta` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_consulta` CHECK(`preco_consulta` >= 0.00),
  PRIMARY KEY (`cod_especialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`medicos` (
  `nr_mec` INT NOT NULL,
  `estado` CHAR(1) NOT NULL,
  `cod_especialidade` INT NOT NULL,
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna estado
  -- A-ativa, S-suspensa ou E-expirada
  CONSTRAINT `chk_estado` CHECK(`estado` IN ('A','S','E')),
  PRIMARY KEY (`nr_mec`),
  CONSTRAINT `fk_medicos_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `HospitalPortucalense_24`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicos_especialidades`
    FOREIGN KEY (`cod_especialidade`)
    REFERENCES `HospitalPortucalense_24`.`especialidades` (`cod_especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`telefones_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`telefones_func` (
  `telefone` CHAR(9) NOT NULL,
  `nr_mec` INT NOT NULL,
  PRIMARY KEY (`telefone`),
  CONSTRAINT `fk_telefones_func_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `HospitalPortucalense_24`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`emails_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`emails_func` (
  `email` VARCHAR(45) NOT NULL,
  `nr_mec` INT NOT NULL,
  PRIMARY KEY (`email`),
  CONSTRAINT `fk_emails_func_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `HospitalPortucalense_24`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`administrativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`administrativos` (
  `nr_mec` INT NOT NULL,
  `grau` CHAR(1) NOT NULL,
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna grau
  -- B-ensino básico, S-ensino secundário, L-licenciatura, E-especialização, M-mestrado, D-doutoramento
  CONSTRAINT `chk_grau` CHECK(`grau` IN ('B','S','L','E','M','D')),
  PRIMARY KEY (`nr_mec`),
  CONSTRAINT `fk_administrativos_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `HospitalPortucalense_24`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`consultas` (
  `nr_episodio` INT NOT NULL,
  `data_agenda` DATETIME NOT NULL,
  `hora_ini` TIME NULL,
  `hora_fim` TIME NULL,
  `id_paciente` INT NOT NULL,
  `id_medico` INT NOT NULL,
  `id_secretaria` INT NULL,
  `data_emissao` DATE NULL,
  `data_pagamento` DATE NULL,
  -- Adicionar uma check constraint para garantir que a hora_fim é sempre posterior à hora_ini
  CONSTRAINT `chk_hora_consultas` CHECK(`hora_fim` > `hora_ini`),
  -- Adicionar uma check constraint para garantir que a dta_pagamento é sempre igual ou posterior à dta_emissao
  CONSTRAINT `chk_dtas_faturas` CHECK(`data_pagamento` >= `data_emissao`),
  PRIMARY KEY (`nr_episodio`),
  CONSTRAINT `fk_consultas_pacientes`
    FOREIGN KEY (`id_paciente`)
    REFERENCES `HospitalPortucalense_24`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_medicos`
    FOREIGN KEY (`id_medico`)
    REFERENCES `HospitalPortucalense_24`.`medicos` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_administrativos`
    FOREIGN KEY (`id_secretaria`)
    REFERENCES `HospitalPortucalense_24`.`administrativos` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`exames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`exames` (
  `cod_exame` INT NOT NULL AUTO_INCREMENT,
  `desc_exame` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_exames` CHECK(`preco` >= 0.00),
  PRIMARY KEY (`cod_exame`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`agendamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`agendamentos` (
  `nr_episodio` INT NOT NULL,
  `cod_exame` INT NOT NULL,
  `dta_marcacao` DATETIME NOT NULL,
  `prioridade` CHAR(1) NOT NULL,
  `externo` TINYINT NOT NULL,
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna prioridade
  -- B-baixa, N-normal, A-alta, U-urgente, E-emergente
  CONSTRAINT `chk_prioridade` CHECK(`prioridade` IN ('B', 'N', 'A', 'U', 'E')),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna externo
  -- 0-false, 1-true
  CONSTRAINT `chk_externo` CHECK(`externo` IN (0,1)),
  PRIMARY KEY (`nr_episodio`, `cod_exame`),
  CONSTRAINT `fk_consultas_has_exames_consultas`
    FOREIGN KEY (`nr_episodio`)
    REFERENCES `HospitalPortucalense_24`.`consultas` (`nr_episodio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_has_exames_exames`
    FOREIGN KEY (`cod_exame`)
    REFERENCES `HospitalPortucalense_24`.`exames` (`cod_exame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`medicamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`medicamentos` (
  `id_med` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `desc` TEXT NULL,
  PRIMARY KEY (`id_med`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`prescricoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`prescricoes` (
  `id_med` INT NOT NULL,
  `nr_episodio` INT NOT NULL,
  `data_prescricao` DATETIME NOT NULL,
  `data_validade` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  `unidade` VARCHAR(8) NOT NULL,
  `PVP` DECIMAL(5,2) NULL DEFAULT 0.00,
  `comparticipacao` DECIMAL(5,2) NULL DEFAULT 0.00,
  `posologia` VARCHAR(75) NULL,
  -- Adicionar check constraint para impedir a inserção de valores negativos
  -- Para a quantidade (INT) também se poderia ter usado o UNSIGNED
  -- `quantidade` INT UNSIGNED NOT NULL,
  CONSTRAINT `chk_quantidade` CHECK(`quantidade` >= 0),
  CONSTRAINT `chk_PVP` CHECK(`PVP` >= 0.00),
  CONSTRAINT `chk_comparticipacao_med` CHECK(`comparticipacao` >= 0.00),
  -- Adicionar uma check constraint para garantir que a data_validade é sempre posterior à data_prescricao
  CONSTRAINT `chk_data_validade` CHECK(`data_validade` > `data_prescricao`),
  PRIMARY KEY (`id_med`, `nr_episodio`),
  CONSTRAINT `fk_medicamentos_has_consultas_medicamentos`
    FOREIGN KEY (`id_med`)
    REFERENCES `HospitalPortucalense_24`.`medicamentos` (`id_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicamentos_has_consultas_consultas`
    FOREIGN KEY (`nr_episodio`)
    REFERENCES `HospitalPortucalense_24`.`consultas` (`nr_episodio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`equipamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`equipamentos` (
  `cod_eq` INT NOT NULL AUTO_INCREMENT,
  `des_eq` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_equipamentos` CHECK(`preco` >= 0.00),
  PRIMARY KEY (`cod_eq`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`procedimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`procedimentos` (
  `cod_proc` INT NOT NULL AUTO_INCREMENT,
  `des_proc` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_procedimentos`
  CHECK(`preco` >= 0.00),
  PRIMARY KEY (`cod_proc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `HospitalPortucalense_24`.`examinacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `HospitalPortucalense_24`.`examinacoes` (
  `cod_eq` INT NOT NULL,
  `nr_episodio` INT NOT NULL,
  `cod_proc` INT NOT NULL,
  `estado` CHAR(1) NOT NULL,
  `hora_ini` DATETIME NOT NULL,
  `hora_fim` DATETIME NULL,
  `obs` TEXT NULL,
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna estado
  -- I-iniciado, S-suspenso, C-cancelado, T-terminado
  CONSTRAINT `chk_estado_examinacoes` CHECK (`estado` IN ('I', 'S', 'C', 'T')),
  -- Adicionar uma check constraint para garantir que a hora_fim é sempre posterior à hora_ini
  CONSTRAINT `chk_data_examinacoes` CHECK(`hora_fim` > `hora_ini`),
  PRIMARY KEY (`cod_eq`, `nr_episodio`),
  UNIQUE INDEX `index_unique` (`cod_proc`, `cod_eq`),
  CONSTRAINT `fk_Examinações_equipamentos`
    FOREIGN KEY (`cod_eq`)
    REFERENCES `HospitalPortucalense_24`.`equipamentos` (`cod_eq`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examinações_consultas`
    FOREIGN KEY (`nr_episodio`)
    REFERENCES `HospitalPortucalense_24`.`consultas` (`nr_episodio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Examinações_procedimentos`
    FOREIGN KEY (`cod_proc`)
    REFERENCES `HospitalPortucalense_24`.`procedimentos` (`cod_proc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;