-- Universidade do Minho
-- Bases de Dados 2023
-- Caso de Estudo: Hospital Portucalense

-- -----------------------------------------------------
-- Schema hospitalPortucalense_23
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hospitalPortucalense_23` DEFAULT CHARACTER SET utf8 ;
USE `hospitalPortucalense_23` ;

-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`seguradoras`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`seguradoras` (
  `id_seguradora` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cobertura` DECIMAL(3,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_cobertura`
  CHECK(`cobertura` >= 0.00),
  PRIMARY KEY (`id_seguradora`))
  -- Podemos definir o valor inicial de um AUTO_INCREMENT
  AUTO_INCREMENT=10,
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`seguros`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`seguros` (
  `nr_apolice` INT NOT NULL AUTO_INCREMENT,
  `dta_ini` DATE NOT NULL,
  `dta_fim` DATE NOT NULL,
  `comparticipacao` CHAR(1) NOT NULL,
  `id_seguradora` INT NOT NULL,
  -- Adicionar uma check constraint para limitar os valores da comparticipacao
  -- C-co-pagamento, R-reembolso
  CONSTRAINT `chk_comparticipacao`
  CHECK(`comparticipacao` IN ('C', 'R')),
  -- Adicionar uma check constraint para garantir que a dta_fim é sempre posterior à dta_ini
  CONSTRAINT `chk_dtas_seguros`
  CHECK(`dta_fim` > `dta_ini`),
  PRIMARY KEY (`nr_apolice`),
  INDEX `fk_seguros_seguradoras_idx` (`id_seguradora` ASC) VISIBLE,
  CONSTRAINT `fk_seguros_seguradoras`
    FOREIGN KEY (`id_seguradora`)
    REFERENCES `hospitalPortucalense_23`.`seguradoras` (`id_seguradora`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`pacientes` (
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
  -- Adicionar uma check constraint para garantir que o nr_sequencial tem sempre 6 dígitos
  CONSTRAINT `chk_nr_sequencial`
	CHECK(LENGTH(`nr_sequencial`) = 6),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna sexo
  -- F-feminino, M-masculino, I-indefinido
  CONSTRAINT `chk_sexo`
	CHECK(`sexo` IN ('F','M','I')),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna estado_civil
  -- S-solteiro, C-casado, D-divorciado, V-viúvo
  CONSTRAINT `chk_estado_civil`
	CHECK(`estado_civil` IN ('S', 'C', 'D', 'V')),
  PRIMARY KEY (`nr_sequencial`),
  INDEX `fk_pacientes_seguros_idx` (`nr_apolice` ASC) VISIBLE,
  CONSTRAINT `fk_pacientes_seguros`
    FOREIGN KEY (`nr_apolice`)
    REFERENCES `hospitalPortucalense_23`.`seguros` (`nr_apolice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`telefones_pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`telefones_pacientes` (
  `nr_telefone` CHAR(9) NOT NULL,
  `nr_sequencial` INT NOT NULL,
  PRIMARY KEY (`nr_telefone`, `nr_sequencial`),
  INDEX `fk_Telefone_pacientes_Paciente_idx` (`nr_sequencial` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_pacientes_Paciente`
    FOREIGN KEY (`nr_sequencial`)
    REFERENCES `hospitalPortucalense_23`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`emails_pacientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`emails_pacientes` (
  `email` VARCHAR(45) NOT NULL,
  `nr_sequencial` INT NOT NULL,
  PRIMARY KEY (`email`, `nr_sequencial`),
  INDEX `fk_Email_pacientes_Paciente_idx` (`nr_sequencial` ASC) VISIBLE,
  CONSTRAINT `fk_Email_pacientes_Paciente`
    FOREIGN KEY (`nr_sequencial`)
    REFERENCES `hospitalPortucalense_23`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`funcionarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`funcionarios` (
  `nr_mec` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `dta_ini` VARCHAR(45) NOT NULL,
  `dta_fim` VARCHAR(45) NULL,
  -- Adicionar uma check constraint para garantir que a dta_fim é sempre posterior à dta_ini
  CONSTRAINT `chk_dtas_funcionarios`
  CHECK(`dta_fim` > `dta_ini`),
  PRIMARY KEY (`nr_mec`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`especialidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`especialidades` (
  `cod_especialidade` INT NOT NULL AUTO_INCREMENT,
  `des_especialidade` VARCHAR(45) NOT NULL,
  `preco_consulta` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_consulta`
  CHECK(`preco_consulta` >= 0.00),
  PRIMARY KEY (`cod_especialidade`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`medicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`medicos` (
  `nr_mec` INT NOT NULL,
  `cod_especialidade` INT NOT NULL,
  PRIMARY KEY (`nr_mec`),
  INDEX `fk_medicos_especialidades_idx` (`cod_especialidade` ASC) VISIBLE,
  CONSTRAINT `fk_medicos_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `hospitalPortucalense_23`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicos_especialidades`
    FOREIGN KEY (`cod_especialidade`)
    REFERENCES `hospitalPortucalense_23`.`especialidades` (`cod_especialidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`telefones_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`telefones_func` (
  `telefone` CHAR(9) NOT NULL,
  `nr_mec` INT NOT NULL,
  PRIMARY KEY (`telefone`),
  INDEX `fk_telefones_func_funcionarios_idx` (`nr_mec` ASC) VISIBLE,
  CONSTRAINT `fk_telefones_func_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `hospitalPortucalense_23`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`emails_func`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`emails_func` (
  `email` VARCHAR(45) NOT NULL,
  `nr_mec` INT NOT NULL,
  PRIMARY KEY (`email`),
  INDEX `fk_emails_func_funcionarios_idx` (`nr_mec` ASC) VISIBLE,
  CONSTRAINT `fk_emails_func_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `hospitalPortucalense_23`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`administrativos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`administrativos` (
  `nr_mec` INT NOT NULL,
  PRIMARY KEY (`nr_mec`),
  CONSTRAINT `fk_administrativos_funcionarios`
    FOREIGN KEY (`nr_mec`)
    REFERENCES `hospitalPortucalense_23`.`funcionarios` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`consultas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`consultas` (
  `nr_episodio` INT NOT NULL,
  `dta_ini` DATETIME NOT NULL,
  `dta_fim` DATETIME NULL,
  `nr_sequencial` INT NOT NULL,
  `nr_mec_medico` INT NOT NULL,
  `nr_mec_secretaria` INT NOT NULL,
  `dta_emissao` DATE NULL,
  `dta_pagamento` DATE NULL,
  `custo_total` DECIMAL(5,2) NULL DEFAULT 0.00,
  `custo_final` DECIMAL(5,2) NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para garantir que a dta_fim é sempre posterior à dta_ini
  CONSTRAINT `chk_dtas_consultas`
  CHECK(`dta_fim` > `dta_ini`),
  CONSTRAINT `chk_dtas_faturas`
  CHECK(`dta_pagamento` >= `dta_emissao`),
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_custo_total`
  CHECK(`custo_total` >= 0.00),
  CONSTRAINT `chk_custo_final`
  CHECK(`custo_final` >= 0.00),
  PRIMARY KEY (`nr_episodio`),
  INDEX `fk_consultas_pacientes_idx` (`nr_sequencial` ASC) VISIBLE,
  INDEX `fk_consultas_medicos_idx` (`nr_mec_medico` ASC) VISIBLE,
  INDEX `fk_consultas_administrativos_idx` (`nr_mec_secretaria` ASC) VISIBLE,
  CONSTRAINT `fk_consultas_pacientes`
    FOREIGN KEY (`nr_sequencial`)
    REFERENCES `hospitalPortucalense_23`.`pacientes` (`nr_sequencial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_medicos`
    FOREIGN KEY (`nr_mec_medico`)
    REFERENCES `hospitalPortucalense_23`.`medicos` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_administrativos`
    FOREIGN KEY (`nr_mec_secretaria`)
    REFERENCES `hospitalPortucalense_23`.`administrativos` (`nr_mec`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`exames`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`exames` (
  `cod_exame` INT NOT NULL AUTO_INCREMENT,
  `desc_exame` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_exames`
  CHECK(`preco` >= 0.00),
  PRIMARY KEY (`cod_exame`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`agendamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`agendamentos` (
  `nr_episodio` INT NOT NULL,
  `cod_exame` INT NOT NULL,
  `dta_marcacao` DATETIME NOT NULL,
  `prioridade` CHAR(1) NULL,
  `externo` TINYINT NULL,
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna prioridade
  -- B-baixa, N-normal, A-alta, U-urgente, E-emergente
  CONSTRAINT `chk_prioridade`
  CHECK(`prioridade` IN ('B', 'N', 'A', 'U', 'E')),
  -- Adicionar uma check constraint para limitar os valores de inserção na coluna externo
  -- 0-false, 1-true
  CONSTRAINT `chk_externo`
  CHECK(`externo` IN (0,1)),
  PRIMARY KEY (`nr_episodio`, `cod_exame`),
  INDEX `fk_consultas_has_exames_exames_idx` (`cod_exame` ASC) VISIBLE,
  INDEX `fk_consultas_has_exames_consultas_idx` (`nr_episodio` ASC) VISIBLE,
  CONSTRAINT `fk_consultas_has_exames_consultas`
    FOREIGN KEY (`nr_episodio`)
    REFERENCES `hospitalPortucalense_23`.`consultas` (`nr_episodio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_consultas_has_exames_exames`
    FOREIGN KEY (`cod_exame`)
    REFERENCES `hospitalPortucalense_23`.`exames` (`cod_exame`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`medicamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`medicamentos` (
  `id_med` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `desc` VARCHAR(150) NULL,
  PRIMARY KEY (`id_med`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`prescricoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`prescricoes` (
  `id_med` INT NOT NULL,
  `nr_episodio` INT NOT NULL,
  `data_prescricao` DATE NOT NULL,
  `data_validade` DATE NOT NULL,
  `quantidade` INT NOT NULL,
  `unidade` VARCHAR(8) NOT NULL,
  `PVP` DECIMAL(5,2) NULL DEFAULT 0.00,
  `comparticipacao` DECIMAL(5,2) NULL DEFAULT 0.00,
  `posologia` VARCHAR(45) NULL,
  -- Adicionar check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_PVP`
  CHECK(`PVP` >= 0.00),
  CONSTRAINT `chk_comparticipacao_med`
  CHECK(`comparticipacao` >= 0.00),
  -- Adicionar uma check constraint para garantir que a data_validade é sempre posterior à data_prescricao
  CONSTRAINT `chk_data_validade`
  CHECK(`data_validade` > `data_prescricao`),
  PRIMARY KEY (`id_med`, `nr_episodio`),
  INDEX `fk_medicamentos_has_consultas_consultas_idx` (`nr_episodio` ASC) VISIBLE,
  INDEX `fk_medicamentos_has_consultas_medicamentos_idx` (`id_med` ASC) VISIBLE,
  CONSTRAINT `fk_medicamentos_has_consultas_medicamentos`
    FOREIGN KEY (`id_med`)
    REFERENCES `hospitalPortucalense_23`.`medicamentos` (`id_med`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_medicamentos_has_consultas_consultas`
    FOREIGN KEY (`nr_episodio`)
    REFERENCES `hospitalPortucalense_23`.`consultas` (`nr_episodio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`procedimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`procedimentos` (
  `cod_proc` INT NOT NULL AUTO_INCREMENT,
  `desc_proc` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_procedimentos`
  CHECK(`preco` >= 0.00),
  PRIMARY KEY (`cod_proc`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`examinacoes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`examinacoes` (
  `id_examinacao` INT NOT NULL AUTO_INCREMENT,
  `avaliacao` VARCHAR(150) NULL,
  `nr_episodio` INT NOT NULL,
  `cod_proc` INT NOT NULL,
  PRIMARY KEY (`id_examinacao`),
  INDEX `fk_examinacoes_consultas_idx` (`nr_episodio` ASC) VISIBLE,
  INDEX `fk_examinacoes_procedimentos_idx` (`cod_proc` ASC) VISIBLE,
  CONSTRAINT `fk_examinacoes_consultas`
    FOREIGN KEY (`nr_episodio`)
    REFERENCES `hospitalPortucalense_23`.`consultas` (`nr_episodio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_examinacoes_procedimentos`
    FOREIGN KEY (`cod_proc`)
    REFERENCES `hospitalPortucalense_23`.`procedimentos` (`cod_proc`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`equipamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`equipamentos` (
  `id_equipamento` INT NOT NULL AUTO_INCREMENT,
  `nome_equipamento` VARCHAR(45) NOT NULL,
  `preco` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
  -- Adicionar uma check constraint para impedir a inserção de valores negativos
  CONSTRAINT `chk_preco_equipamentos`
  CHECK(`preco` >= 0.00),
  PRIMARY KEY (`id_equipamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hospitalPortucalense_23`.`examinacoes_equipamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `hospitalPortucalense_23`.`examinacoes_equipamentos` (
  `id_examinacao` INT NOT NULL,
  `id_equipamento` INT NOT NULL,
  PRIMARY KEY (`id_examinacao`, `id_equipamento`),
  INDEX `fk_examinacoes_has_equipamento_equipamento_idx` (`id_equipamento` ASC) VISIBLE,
  INDEX `fk_examinacoes_has_equipamento_examinacoes_idx` (`id_examinacao` ASC) VISIBLE,
  CONSTRAINT `fk_examinacoes_has_equipamento_examinacoes`
    FOREIGN KEY (`id_examinacao`)
    REFERENCES `hospitalPortucalense_23`.`examinacoes` (`id_examinacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_examinacoes_has_equipamento_equipamento`
    FOREIGN KEY (`id_equipamento`)
    REFERENCES `hospitalPortucalense_23`.`equipamentos` (`id_equipamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
