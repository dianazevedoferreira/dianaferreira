-- Universidade do Minho
-- Bases de Dados 2023
-- Caso de Estudo: Hospital Portucalense


-- -----------------------------------------------------
-- Indicação da base de dados de trabalho
-- -----------------------------------------------------
USE hospitalPortucalense_23;


-- -----------------------------------------------------
-- Povoamento da tabela `seguradoras`
-- -----------------------------------------------------
INSERT INTO seguradoras(nome,cobertura) VALUES
('ADSE', '0.20'),
('Multicare', '0.10'),
('Médis', '0.25'),
('Medicare', '0.20'),
('Saúde Prime', '0.10'),
('AdvanceCare', '0.15');


-- -----------------------------------------------------
-- Povoamento da tabela `seguros`
-- -----------------------------------------------------
INSERT INTO seguros(dta_ini, dta_fim, comparticipacao, id_seguradora) VALUES
('2010-10-25', '2030-12-06', 'C', 10),
('2015-03-04', '2020-06-15', 'R', 11),
('2022-09-19', '2050-02-23', 'R', 11),
('2009-12-05', '2028-11-25', 'C', 13),
('2020-06-10', '2022-10-17', 'C', 14);


-- -----------------------------------------------------
-- Povoamento da tabela `pacientes`
-- -----------------------------------------------------
INSERT INTO pacientes(nr_sequencial,nome,dta_nascimento,sexo,estado_civil,NIF,nr_utente,rua,localidade,cod_postal,nr_apolice) VALUES
(111111, 'Maria João Fernades Cunha', '1992-10-19', 'F', 'S', '265768988', '145654327', 'Rua do Sol, 18', 'Porto', '4715-135', NULL),
(111112, 'Patrícia Muniz Ribeiro', '1978-05-16', 'F', 'C', '260454999', '124552789', 'Rua 25 de Abril', 'Porto', '4700-480', '1'),
(111113, 'Tiago Araújo Ferreira', '1984-11-22', 'M', 'S', '260454111', '163456789', 'Rua Zeca Afonso', 'Braga', '4700-834', NULL),
(111114, 'Santiago Ribeiro Pais', '2012-10-20', 'M', NULL, '262435413', '183653397', 'Rua 25 de Abril', 'Porto', '4700-480', '1'),
(111115, 'Francisco Castro Pais', '1978-01-21', 'M', 'C', '260444969', '134539789', 'Rua 25 de Abril', 'Porto', '4700-480', '1'),
(111116, 'Joana Filipa Cunha Alves', '1990-04-14', 'I', NULL, '260434245', '145673739', 'Rua do Monte de Baixo II', 'Porto', '4710-071', '2'),
(111117, 'Madalena Peixoto Azevedo', '1983-07-08', 'F', 'V', '260555333', '123956989', 'Rua 1º de Maio', 'Braga', '4710-470', '3'),
(111118, 'Afonso Azevedo Teixeira', '2005-09-18', 'M', 'S', '240454363', '125955959', 'Rua 1º de Maio', 'Braga', '4710-470', '5'),
(111119, 'Leonor da Silva Ferreira', '1999-03-24', 'F', 'S', '260545671', '123443189', 'Rua da Devesa Basta', 'Porto', '4715-135', NULL),
(111120, 'Pedro Castro Duarte', '1984-12-09', 'M', NULL, '235482321', '162387254', 'Rua do Parque Norte', 'Guimarães', '4700-103', '4');


-- -----------------------------------------------------
-- Povoamento da tabela `telefones_pacientes`
-- -----------------------------------------------------
INSERT INTO telefones_pacientes(nr_telefone, nr_sequencial) VALUES
('913914918', 111111),
('933945812', 111112),
('966783675', 111113),
('933945812', 111114),
('917463302', 111115),
('917463302', 111116),
('965455605', 111117),
('961677567', 111118),
('961677567', 111119),
('253600806', 111120);


-- -----------------------------------------------------
-- Povoamento da tabela `emails_pacientes`
-- -----------------------------------------------------
INSERT INTO emails_pacientes(email, nr_sequencial) VALUES
('mjcunha@gmail.com', 111111),
('muniz_ribeiro@gmail.com', 111112),
('tpereira@hotmail.com', 111113),
('muniz_ribeiro@gmail.com', 111114),
('fcp@sapo.pt', 111115),
('joanalves_14@gmail.com', 111116),
('madalena@outlook.pt', 111117),
('afonsoteixeira@gmail.pt', 111118),
('leo@outlook.pt', 111119),
('castroduarte@sapo.pt', 111120);


-- -----------------------------------------------------
-- Povoamento da tabela `funcionarios`
-- -----------------------------------------------------
INSERT INTO funcionarios(nome,dta_ini,dta_fim) VALUES
('Pedro de Almeida Xavier', '1960-10-10', NULL),
('João Castro Cabral', '1960-10-10', NULL),
('Teresa Ribeiro da Costa', '1960-10-10', NULL),
('Fátima Noronha Pinto', '1960-10-10', NULL),
('Inês Maria da Silva Abrantes', '1960-10-10', NULL),
('Artur Pereira Santos', '1960-10-10', '1988-02-22'),
('Ana Eduarda Castro Dinis', '1960-10-10', NULL),
('Tiago José Alves Ribeiro', '1960-10-10', '1995-03-08'),
('António Pedro Ribeiro Costa', '1960-10-10', NULL),
('João Pedro Dias Gonçalves', '1980-03-14', NULL),
('Maria João Sousa Barbosa', '1980-04-08', NULL),
('Leonor Santos da Cunha', '1980-05-20', NULL),
('Margarida Simões Branco', '1980-08-30', '2000-10-22'),
('José Fernando Noronha', '1984-01-21', NULL),
('Cristiana Silva Pereira', '1984-01-21', NULL),
('Eduardo Azevedo Castro', '1991-03-11', NULL),
('Filipa Silva Mendonça', '1991-03-11', '2001-06-18'),
('Pedro Rodrigues Peixoto', '1997-10-02', '2007-09-22'),
('Carlos André Cunha Fernandes', '1997-10-02', NULL),
('Bruno Miguel Costa Ferreira', '1997-10-02', NULL),
('Lígia Ribeiro Santos', '2000-05-07', NULL),
('Bernardo Pereira Neto', '2000-05-07', NULL),
('Marília Costa Azevedo', '2000-05-07', '2010-01-08'),
('Álvaro Ribeiro Pascoal', '2000-05-07', NULL),
('Leandro Correia Pereira', '2006-11-15', NULL),
('Maria Leonor Dias Gomes', '2006-11-15', '2009-02-19'),
('José Pereira Cabral', '2010-09-19', NULL),
('Leonardo Morais Sarmento', '2010-09-19', NULL),
('Patrícia Filipa Maia Almeida', '2010-09-19', NULL),
('Catarina Rodrigues Nogueira', '2017-04-15', NULL),
('Ricardo José Santos da Maia', '2017-04-15', NULL),
('Fernando Costa Tavares', '2017-04-15', NULL),
('Eduarda Maria da Silva Pascoal', '2020-10-01', NULL),
('Rita Gomes Teixeira', '2020-10-01', NULL),
('Maria Joana Pereira Alves', '2020-10-01', NULL),
('Gabriel Santos da Silva', '2021-04-19', NULL),
('Tiago Rodrigues Simões', '2021-04-19', NULL),
('Artur Ferreira Soares', '2022-11-14', NULL);


-- -----------------------------------------------------
-- Povoamento da tabela `telefones_func`
-- -----------------------------------------------------
INSERT INTO telefones_func(telefone, nr_mec) VALUES
('911232123', 1),
('935618391', 2),
('965276518', 3),
('917826197', 4),
('916352726', 5),
('966542836', 6),
('910230825', 7),
('918726350', 8),
('933653087', 9),
('916521098', 10),
('919237261', 11),
('969899698', 12),
('912376589', 13),
('963760303', 14),
('960876390', 15),
('918273098', 16),
('914590872', 17),
('915055345', 18),
('917878787', 19),
('911191091', 20),
('962692022', 21),
('916526765', 22),
('913393047', 23),
('915795050', 24),
('961741011', 25),
('919171011', 26),
('915691541', 27),
('913543783', 28),
('963360300', 29),
('915006256', 30),
('910018900', 31),
('912210222', 32),
('966554433', 33),
('962351427', 34),
('913648291', 35),
('934267433', 36),
('966223262', 37),
('911894814', 38);


-- -----------------------------------------------------
-- Povoamento da tabela `emails_func`
-- -----------------------------------------------------
INSERT INTO emails_func(email, nr_mec) VALUES
('pedro_xavier@hp.min-saude.pt', 1),
('joao_cabral@hp.min-saude.pt', 2),
('teresa_costa@hp.min-saude.pt', 3),
('fatima_pinto@hp.min-saude.pt', 4),
('ines_abrantes@hp.min-saude.pt', 5),
('artur_santos@hp.min-saude.pt', 6),
('ana_dinis@hp.min-saude.pt', 7),
('tiago_ribeiro@hp.min-saude.pt', 8),
('antonio_costa@hp.min-saude.pt', 9),
('joao_gonçalves@hp.min-saude.pt', 10),
('maria_barbosa@hp.min-saude.pt', 11),
('leonor_cunha@hp.min-saude.pt', 12),
('margarida_branco@hp.min-saude.pt', 13),
('fernando_noronha@hp.min-saude.pt', 14),
('cristiana_pereira@hp.min-saude.pt', 15),
('eduardo_castro@hp.min-saude.pt', 16),
('filipa_mendonca@hp.min-saude.pt', 17),
('pedro_peixoto@hp.min-saude.pt', 18),
('carlos_fernandes@hp.min-saude.pt', 19),
('bruno_ferreira@hp.min-saude.pt', 20),
('ligia_santos@hp.min-saude.pt', 21),
('bernardo_neto@hp.min-saude.pt', 22),
('marilia_azevedo@hp.min-saude.pt', 23),
('alvaro_pascoal@hp.min-saude.pt', 24),
('leandro_pereira@hp.min-saude.pt', 25),
('maria_gomes@hp.min-saude.pt', 26),
('jose_cabral@hp.min-saude.pt', 27),
('leonardo_sarmento@hp.min-saude.pt', 28),
('patricia_almeida@hp.min-saude.pt', 29),
('catarina_nogueira@hp.min-saude.pt', 30),
('ricardo_maia@hp.min-saude.pt', 31),
('fernando_tavares@hp.min-saude.pt', 32),
('eduarda_pascoal@hp.min-saude.pt', 33),
('rita_teixeira@hp.min-saude.pt', 34),
('maria_alves@hp.min-saude.pt', 35),
('gabriel_silva@hp.min-saude.pt', 36),
('tiago_simoes@hp.min-saude.pt', 37),
('artur_soares@hp.min-saude.pt', 38);

-- -----------------------------------------------------
-- Povoamento da tabela `especialidades`
-- -----------------------------------------------------
INSERT INTO especialidades(cod_especialidade,des_especialidade,preco_consulta) VALUES(2200, 'Anestesiologia', '40.00');

INSERT INTO especialidades(des_especialidade,preco_consulta) VALUES
('Angiologia', '35.00'),
('Cardiologia', '35.00'),
('Cirurgia Cardiotorácica', '40.00'),
('Cirurgia Geral', '40.00'),
('Cirurgia Vascular', '40.00'),
('Dermatologia', '35.00'),
('Endocrinologia', '35.00'),
('Estomatologia', '35.00'),
('Fisiatria', '35.00'),
('Gastrenterologia', '35.00'),
('Ginecologia', '35.00'),
('Medicina Interna', '35.00'),
('Medicina Intensiva', '35.00'),
('Medicina Nuclear', '35.00'),
('Nefrologia', '35.00'),
('Neurocirurgia', '35.00'),
('Neurologia', '35.00'),
('Neuropsicologia', '35.00'),
('Neurorradiologia', '35.00'),
('Obstetrícia', '35.00'),
('Oftalmologia', '35.00'),
('Oncologia', '35.00'),
('Ortopedia', '35.00'),
('Otorrinolaringologia', '35.00'),
('Pediatria', '35.00'),
('Pneumologia', '35.00'),
('Psiquiatria', '35.00'),
('Radiologia', '50.00'),
('Reumatologia', '35.00'),
('Urologia', '35.00');


-- -----------------------------------------------------
-- Povoamento da tabela `medicos`
-- -----------------------------------------------------
INSERT INTO medicos (nr_mec, cod_especialidade) VALUES
(6,2202),
(7,2200),
(10,2206),
(12,2207),
(13,2208),
(14,2210),
(15,2209),
(21,2211),
(22,2221),
(23,2224),
(24,2230),
(25,2227),
(26,2226),
(27,2228),
(28,2220),
(29,2201),
(30,2203),
(31,2212),
(34,2213),
(35,2204),
(36,2205),
(37,2215),
(38,2217);


-- -----------------------------------------------------
-- Povoamento da tabela `administrativos`
-- -----------------------------------------------------
INSERT INTO administrativos (nr_mec) VALUES
(8),
(9),
(11),
(16),
(17),
(18),
(19),
(20),
(32),
(33);


-- -----------------------------------------------------
-- Povoamento da tabela `consultas`
-- -----------------------------------------------------
INSERT INTO consultas(nr_episodio, dta_ini,dta_fim,nr_sequencial,nr_mec_medico,nr_mec_secretaria,dta_emissao,dta_pagamento) VALUES
(111, '2022-10-01 10:10:04', '2022-10-01 10:40:00', 111111, 10, 9, '2022-10-01', NULL),
(112, '2022-11-14 11:20:14', '2022-11-14 11:50:05', 111112, 6, 17, '2022-11-14', NULL),
(113, '2022-12-21 14:16:44', '2022-12-21 14:56:14', 111115, 21, 20, '2022-12-21', '2022-12-22'),
(114, '2023-01-12 12:10:15', '2023-01-12 12:40:45', 111117, 25, 9, NULL, NULL),
(115, '2023-02-21 16:30:34', '2023-02-21 17:03:54', 111120, 38, 32, '2023-02-21', '2023-02-21');


-- -----------------------------------------------------
-- Povoamento da tabela `exames`
-- -----------------------------------------------------
INSERT INTO exames(desc_exame,preco) VALUES
('RM Abdomen Superior', '300.00'),
('RM Encefálica','300.00'),
('TC Tórax', '100.00'),
('Angio TC Tórax', '150.00'),
('RX Tórax', '65.00');


-- -----------------------------------------------------
-- Povoamento da tabela `agendamentos`
-- -----------------------------------------------------
INSERT INTO agendamentos(nr_episodio,cod_exame,dta_marcacao,prioridade,externo) VALUES
(112, 5, '2023-02-20 10:00:00', 'B', 0),
(112, 1, '2023-12-11 11:30:00', 'N', 1),
(115, 2, '2023-12-11 11:30:00', 'A', 0);


-- -----------------------------------------------------
-- Povoamento da tabela `medicamentos`
-- -----------------------------------------------------
INSERT INTO medicamentos(`nome`,`desc`) VALUES
('Acarbose', 'Comprimido revestido por película hipoglicemiante'),
('Amoxicilina', 'Comprimido revestido por película antibiótico utilizado para tratar diversas infecções bacterianas'),
('Bicarbonato de sódio', 'Solução injetável alcalinizante'),
('Betametasona', 'Pomada corticóide com potente ação anti-inflamatória e antialérgica'),
('Ferro', 'Solução injetável para reposição de ferro'),
('Ibuprofeno', 'Comprimido revestido por película anti-inflamatório não esteroidal'),
('Insulina glulisina', 'Solução injetável antidiabética'),
('Levetiracetam', 'Comprimido revestido por película antiepiletico'),
('Levotiroxina', 'Comprimido de hormona tiroideia sintética usado no tratamento de reposição hormonal'),
('Omeprazol', 'Cápsula gastrorresistente'),
('Oxitocina', 'Solução para pulverização nasal'),
('Pantoprazol', 'Comprimido gastrorresistente'),
('Paracetamol', 'Comprimido revestido por película analgésico');


-- -----------------------------------------------------
-- Povoamento da tabela `prescricoes`
-- -----------------------------------------------------
INSERT INTO prescricoes(id_med,nr_episodio,data_prescricao,data_validade,quantidade,unidade) VALUES
(8, 115, '2023-02-21', '2024-02-21', '500', 'mg'),
(2, 113, '2022-12-21', '2023-12-01', '100', 'mg'),
(12, 113, '2022-12-21', '2024-01-20', '100', 'mg');


-- -----------------------------------------------------
-- Povoamento da tabela `procedimentos`
-- -----------------------------------------------------
INSERT INTO procedimentos(desc_proc, preco) VALUES
('Procedimento A', 19.95),
('Procedimento B', 15.45),
('Procedimento C', 19.99),
('Procedimento D', 22.50),
('Procedimento E', 55.00),
('Procedimento F', 34.25),
('Procedimento G', 80.50),
('Procedimento H', 65.00),
('Procedimento I', 8.99),
('Procedimento J', 5.25);


-- -----------------------------------------------------
-- Povoamento da tabela `examinacoes`
-- -----------------------------------------------------
INSERT INTO examinacoes(nr_episodio,cod_proc) VALUES
(111, 2),
(113, 4),
(113, 5);


-- -----------------------------------------------------
-- Povoamento da tabela `equipamentos`
-- -----------------------------------------------------
INSERT INTO equipamentos(nome_equipamento, preco) VALUES
('Equipamento A', 10.95),
('Equipamento B', 5.45),
('Equipamento C', 7.99),
('Equipamento D', 8.50),
('Equipamento E', 15.00),
('Equipamento F', 14.25),
('Equipamento G', 8.50);


-- -----------------------------------------------------
-- Povoamento da tabela `examinacoes_equipamentos`
-- -----------------------------------------------------
INSERT INTO examinacoes_equipamentos(id_examinacao,id_equipamento) VALUES
(1,2),
(1,3),
(2,6),
(2,3);
