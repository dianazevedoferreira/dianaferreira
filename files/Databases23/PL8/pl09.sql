-- 1) Quais são os clientes da mercearia?
SELECT * FROM cliente;

-- 2) Quais são os nomes dos clientes que moram em 'Aguada do Queixo'?
SELECT nome FROM cliente WHERE localidade='Aguada do Queixo';

-- 3) Quais são as profissões dos clientes da D. Acácia? 
SELECT profissao FROM cliente GROUP BY profissao;
SELECT DISTINCT(profissao) FROM cliente;

-- 4) Quais são os nomes dos produtos, e respetivos preço, que estão catalogados na base de dados? Apresente-os ordenados alfabeticamente.
SELECT designacao, preco FROM produto ORDER BY designacao ASC;

-- 5) Quais são os melhores clientes da mercearia?
SELECT c.numero FROM cliente c, venda v WHERE c.numero = v.cliente ORDER BY v.total DESC LIMIT 3;

-- 6) Quais as vendas, e respetivos valores, que foram realizadas no dia '2017/10/05'?
SELECT numero, total, data FROM venda WHERE DATE(data) = '2017/10/05';

-- 7) Quais foram os produtos mais vendidos durante a semana '40'?
SELECT produto, SUM(quantidade) as total FROM vendaproduto WHERE venda IN (SELECT numero FROM venda WHERE WEEK(DATA)=40) GROUP BY produto ORDER BY total DESC;

-- 8) Qual o valor médio das vendas realizadas por dia da semana (segunda, terça, etc.)?
SELECT DAYNAME(DATA) as dia_da_semana, ROUND(AVG(total),2) as valor_medio FROM venda GROUP BY DAYNAME(DATA);