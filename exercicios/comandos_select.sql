
--1. Listar todos os dados de todas as pessoas cadastradas.
SELECT * FROM Pessoa;


--2. Listar nome, e-mail e data de nascimento das pessoas cadastradas.
SELECT nome, email, data_nascimento 
FROM Pessoa;


--3. Listar nome, e-mail e data de nascimento da 3a à 8a pessoa cadastrada.
SELECT nome, email, data_nascimento 
FROM Pessoa 
ORDER BY cpf 
LIMIT 6 OFFSET 2;


--4. Listar nome, e-mail e idade das pessoas cadastradas.
SELECT nome, email, EXTRACT(YEAR FROM AGE(data_nascimento)) AS idade 
FROM Pessoa;


--5. Listar a quantidade de agendamentos.
SELECT COUNT(*) AS quantidade_agendamentos 
FROM Agendamento;


--6. Listar a data/hora das consultas e os respectivos valores com desconto de 5%. 

SELECT data_hora_consulta, 
       CONCAT('R$ ', ROUND(valor_consulta * 0.95, 2)) AS valor_com_desconto 
FROM Agendamento;


--7. Listar nome, cpf e e-mail dos pacientes que não possuem plano de saúde.

SELECT p.nome, p.cpf, p.email 
FROM Pessoa p
JOIN Paciente pac ON p.cpf = pac.cpf_pessoa
WHERE pac.plano_de_saude = FALSE;


--8. Listar os dados dos agendamentos registrados para o mesmo mês da consulta.
SELECT * 
FROM Agendamento 
WHERE EXTRACT(MONTH FROM data_hora_agendamento) = EXTRACT(MONTH FROM data_hora_consulta)
  AND EXTRACT(YEAR FROM data_hora_agendamento) = EXTRACT(YEAR FROM data_hora_consulta);


--9. Listar cpf, nome e e-mail dos pacientes que não possuem telefone.
SELECT p.cpf, p.nome, p.email 
FROM Pessoa p
JOIN Paciente pac ON p.cpf = pac.cpf_pessoa
WHERE p.telefone IS NULL;


--10. Listar a data das consultas cujo o valor está entre R$ 50.00 e R$ 100.00.
SELECT CAST(data_hora_consulta AS DATE) AS data_consulta 
FROM Agendamento 
WHERE valor_consulta BETWEEN 50.00 AND 100.00;


--11. Listar cpf, nome e e-mail dos pacientes que moram em "Natal".
SELECT p.cpf, p.nome, p.email 
FROM Pessoa p
JOIN Paciente pac ON p.cpf = pac.cpf_pessoa
WHERE p.endereco LIKE '%Natal%';


--12. Listar cpf, nome, e-mail e data de nascimento dos pacientes ordenados pela data de nascimento.
SELECT p.cpf, p.nome, p.email, p.data_nascimento 
FROM Pessoa p
JOIN Paciente pac ON p.cpf = pac.cpf_pessoa
ORDER BY p.data_nascimento ASC;


--13. Listar a quantidade de pacientes que não possuem plano de saúde.
SELECT COUNT(*) AS qtd_pacientes_sem_plano 
FROM Paciente 
WHERE plano_de_saude = FALSE;


--14. Listar o maior e o menor valor das consultas agendadas para cada dia que contém consulta.
SELECT CAST(data_hora_consulta AS DATE) AS dia_consulta, 
       MAX(valor_consulta) AS maior_valor, 
       MIN(valor_consulta) AS menor_valor
FROM Agendamento
GROUP BY CAST(data_hora_consulta AS DATE)
ORDER BY dia_consulta;


--15. Listar a média dos valores das consultas agendadas para o mês de Dezembro.
SELECT AVG(valor_consulta) AS media_valores_dezembro 
FROM Agendamento 
WHERE EXTRACT(MONTH FROM data_hora_consulta) = 12;


--16. Listar nome e e-mail das pessoas que agendaram alguma consulta para o dia do seu aniversário.
SELECT DISTINCT p.nome, p.email 
FROM Pessoa p
JOIN Paciente pac ON p.cpf = pac.cpf_pessoa
JOIN Agendamento a ON pac.cpf_pessoa = a.cpf_paciente
WHERE EXTRACT(DAY FROM a.data_hora_consulta) = EXTRACT(DAY FROM p.data_nascimento)
  AND EXTRACT(MONTH FROM a.data_hora_consulta) = EXTRACT(MONTH FROM p.data_nascimento);


--17. Listar o nome, e-mail, cpf dos médicos e as suas respectivas especialidades.
SELECT p.nome, p.email, p.cpf, esp.descricao AS especialidade
FROM Pessoa p
JOIN Medico m ON p.cpf = m.cpf_pessoa
JOIN Medico_Especialidade me ON m.crm = me.crm_medico
JOIN Especialidade esp ON me.id_especialidade = esp.identificador;


--18. Listar a quantidade de consultas para cada médico.
SELECT m.crm, p.nome AS nome_medico, COUNT(a.id_agendamento) AS quantidade_consultas
FROM Medico m
JOIN Pessoa p ON m.cpf_pessoa = p.cpf
LEFT JOIN Agendamento a ON m.crm = a.crm_medico
GROUP BY m.crm, p.nome;
