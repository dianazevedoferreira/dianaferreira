-- Questão 4.1. Liste todos os médicos que trabalham no Hospital Portucalense.
SELECT m.* FROM medicos m, funcionarios f WHERE f.dta_fim IS NULL AND m.nr_mec=f.nr_mec;

-- Questão 4.2. Liste o nome, o sexo e a data de nascimento dos pacientes do Hospital Portucalense.
SELECT nome, sexo, dta_nascimento FROM pacientes;

-- Questão 4.3. Liste as diferentes localidades dos pacientes do Hospital.
SELECT localidade FROM pacientes GROUP BY localidade;
SELECT DISTINCT(localidade) FROM pacientes;

-- Questão 4.4. Quais os procedimentos que têm um custo superior a 15€?
SELECT * FROM procedimentos WHERE preco>15.00 ORDER BY preco ASC;

-- Questão 4.5. Liste as consultas onde foram efetuados procedimentos;
SELECT * FROM consultas WHERE nr_episodio IN (SELECT nr_episodio FROM examinacoes);
SELECT * FROM consultas c WHERE EXISTS (SELECT * FROM examinacoes e WHERE e.nr_episodio=c.nr_episodio);
SELECT * FROM consultas WHERE nr_episodio = ANY (SELECT nr_episodio FROM examinacoes);

-- Questão 4.6. Liste as consultas que ainda não foram faturadas;
SELECT * FROM consultas WHERE dta_emissao IS NULL;

-- Questão 4.7. Quais as pacientes do sexo feminino casadas?
SELECT * FROM pacientes WHERE sexo='F' AND estado_civil='C';

-- Questão 4.8. Liste os pacientes que não possuem seguro de saúde.
SELECT * FROM pacientes WHERE nr_apolice IS NULL;

-- Questão 4.9. Quais são as seguradoras que possuem parceria com o hospital que não estão a cobrir o seguro de saúde de nenhum paciente?
SELECT * FROM seguradoras WHERE id_seguradora NOT IN (SELECT id_seguradora FROM seguros);
SELECT * FROM seguradoras s1 WHERE NOT EXISTS (SELECT * FROM seguros s2 WHERE s1.id_seguradora=s2.id_seguradora);
SELECT * FROM seguradoras WHERE id_seguradora != ALL (SELECT id_seguradora FROM seguros);

-- Questão 4.10. Qual é o nome dos medicamentos que não terminam em ‘ol’ nem em ‘na’?
SELECT nome FROM medicamentos WHERE nome NOT LIKE '%ol' AND nome NOT LIKE '%na';
SELECT nome FROM medicamentos WHERE nome NOT RLIKE 'ol$|na$';

-- Questão 4.11. Qual o nome dos procedimentos que possuem um custo entre 20 e 30€?
SELECT desc_proc FROM procedimentos WHERE preco >20 AND preco<30;
SELECT desc_proc FROM procedimentos WHERE preco BETWEEN 20 AND 30;

-- Questão 4.12. Liste as localidades dos pacientes que possuem exatamente 5 caracteres
SELECT distinct(localidade) FROM pacientes WHERE localidade RLIKE '^.{5}$';
SELECT distinct(localidade) FROM pacientes WHERE localidade RLIKE '^.....$';

-- Questão 4.13. Quais as especialidades que possuem ‘neuro’ no nome?
SELECT * FROM especialidades WHERE des_especialidade LIKE '%neuro%';
SELECT * FROM especialidades WHERE des_especialidade RLIKE 'neuro';

-- Questão 4.14. Quais as especialidades que terminam em ‘logia’?
SELECT * FROM especialidades WHERE des_especialidade LIKE '%logia';
SELECT * FROM especialidades WHERE des_especialidade RLIKE 'logia$';

-- Questão 4.15. Liste os telefones dos pacientes que começam por 253.
SELECT nr_telefone FROM telefones_pacientes WHERE nr_telefone LIKE '253%';
SELECT nr_telefone FROM telefones_pacientes WHERE nr_telefone RLIKE '^253';

-- Questão 4.16. Liste os administrativos que se chamam ‘João’ ou ‘Pedro’.
SELECT * FROM administrativos a, funcionarios f WHERE (f.nome LIKE '%João%' OR f.nome LIKE '%Pedro%') AND f.nr_mec=a.nr_mec;
SELECT * FROM administrativos a, funcionarios f WHERE f.nome RLIKE 'João|Pedro' AND f.nr_mec=a.nr_mec;
 
-- Questão 4.17. Liste as prescrições por ordem crescente de validade, isto é, da mais antiga para a mais recente.
SELECT * FROM prescricoes ORDER BY data_validade ASC;

-- Questão 4.18. Retorne para cada estado de agendamento externo (0 – hospital e 1 – externo) o número total de agendamentos.
SELECT externo, COUNT(*) AS total FROM agendamentos GROUP BY externo;

-- Questão 4.19. Indique o número total de pacientes para os sexos feminino e masculino.
SELECT sexo, COUNT(*) as total FROM pacientes WHERE sexo IN ('F', 'M') GROUP BY sexo;

-- Questão 4.20. Liste os procedimentos que possuem um valor acima da média por ordem decrescente de preço.
SELECT * FROM procedimentos WHERE preco > (SELECT AVG(preco) FROM procedimentos) ORDER BY preco DESC;