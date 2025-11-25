-- Consulta 1
-- Para todos recursos, selecionar os recursos de hospitais que estão abaixo da média
-- Quando o hospital nao ter o recurso (NULL) essa funcao coloca 0 no lugar "COALESCE(p.quantidade_disponivel, 0)"
SELECT h.cnes_hospital, r.registro_ms, r.nome, COALESCE(p.quantidade_disponivel, 0) AS qtd_hospital, media.avg_estoque, media.maior_estoque, media.menor_estoque
FROM hospital h 
CROSS JOIN recurso r -- produto cartesiano para considerar todo os produtos possiveis
LEFT JOIN possui p ON (p.cnes_entidade_saude = h.cnes_hospital AND p.registro_ms_recurso = r.registro_ms)
JOIN ( -- podemos fazer join pois devido ao CROSS JOIN ja temos todas as combinacoes possivel
    SELECT r2.registro_ms, AVG(COALESCE(p2.quantidade_disponivel, 0)) as avg_estoque, MIN(COALESCE(p2.quantidade_disponivel, 0)) as menor_estoque,
    MAX(COALESCE(p2.quantidade_disponivel, 0)) as maior_estoque -- quando nao tem estoque considera 0
    FROM hospital h2 JOIN possui p2 ON h2.cnes_hospital = p2.cnes_entidade_saude -- considera apenas hospitais para fazer a conta
    RIGHT JOIN recurso r2 ON r2.registro_ms = p2.registro_ms_recurso -- produtos que nao tem estoque deve ser considerado
    GROUP BY (r2.registro_ms)
) media ON media.registro_ms = r.registro_ms
WHERE (COALESCE(p.quantidade_disponivel, 0) < media.avg_estoque or COALESCE(p.quantidade_disponivel, 0) = 0)
ORDER BY h.cnes_hospital;

-- Não criei casos especificos pois os dados padroes ja geram uma boa querry

-- Consulta 2
/* Pesquisar pelos pedidos sob análise que requisitarem por uma quantia de um determinado recurso acima da disponível no estoque total
e exibir o pedido, o recurso, o estoque externo total e a quantia em falta daquele recurso. */
SELECT P.id_pedido, R.nome, R.registro_ms, P.quantidade, (EXT.estoque_total - COALESCE(PS.quantidade_disponivel, 0)) AS estoque_externo, 
((EXT.estoque_total - COALESCE(PS.quantidade_disponivel, 0)) - P.quantidade) as em_falta -- Calcula-se a falta como a diferença da quantia pedida e do estoque externo.
    FROM relatorio_recurso RR
    JOIN pedido P ON P.id_pedido = RR.id_pedido_relatorio
    JOIN turno T ON P.id_turno = T.id_turno 
    JOIN entidade_saude ES ON ES.cnes = T.cnes_entidade_saude
    JOIN recurso R ON R.registro_ms = P.registro_ms_recurso 
    LEFT JOIN possui PS ON PS.cnes_entidade_saude = ES.cnes AND PS.registro_ms_recurso = P.registro_ms_recurso -- Junção externa para não excluirmos hospitais que não possuem o recurso que estão pedindo.
    JOIN (
        SELECT SUM(PO.quantidade_disponivel) AS estoque_total, PO.registro_ms_recurso AS recurso
        FROM possui PO 
        GROUP BY PO.registro_ms_recurso) as EXT ON EXT.recurso = P.registro_ms_recurso -- Cálculo generalizado do estoque total de todos os recursos pedidos.
WHERE P.quantidade > (EXT.estoque_total - COALESCE(PS.quantidade_disponivel, 0)) AND RR.estado_relatorio = 'ANALISE' -- Somente exibição dos pedidos em análise;


-- Consulta 3.
-- Recursos que são produzidos por laboratorios mas nenhum hospital tem em estoque

WITH recursos_faltantes AS (
    SELECT registro_ms_recurso
    FROM produz
    EXCEPT
    SELECT p.registro_ms_recurso
    FROM hospital h 
    JOIN possui p ON h.cnes_hospital = p.cnes_entidade_saude
    WHERE p.quantidade_disponivel > 0
)
SELECT r.registro_ms, r.nome, r.tipo
FROM recursos_faltantes rf 
JOIN recurso r ON rf.registro_ms_recurso = r.registro_ms;




-- Consulta 4.
-- 
SELECT * FROM transportadora
    WHERE temp_min_suportada <= 
    (SELECT MIN(temp_min) FROM RECURSO) AND
    temp_max_suportada >=
    (SELECT MAX(temp_max) FROM RECURSO);


-- Consulta 5.
-- Dado um hospital, nesse caso cnes = 2751503, devemos verificar todos os relatorio de recurso que estão em analise
-- e encontrar quais sao os laboratorios que são capazes de produzir todos os recursos  que estao presente nos relatorios em
-- analise

WITH recursos_requisitados AS (
    SELECT DISTINCT p.registro_ms_recurso
    FROM relatorio_recurso r JOIN pedido p ON r.id_pedido_relatorio = p.id_pedido
        JOIN turno t ON p.id_turno = t.id_turno
        JOIN entidade_saude es ON t.cnes_entidade_saude = es.cnes
    WHERE (es.cnes = '2751503' AND r.estado_relatorio = 'ANALISE'))
SELECT cnes_laboratorio, COUNT(*)
FROM produz 
WHERE registro_ms_recurso IN (SELECT * FROM recursos_requisitados)
GROUP BY cnes_laboratorio
HAVING COUNT(*) = (SELECT COUNT(*) FROM recursos_requisitados);



WITH menos_frequentes AS (
    SELECT especialidade
    FROM especializacoes
    GROUP BY especialidade
    ORDER BY COUNT(*) ASC
    LIMIT 3
)
SELECT h.*
FROM hospital AS h
JOIN especializacoes AS e ON h.cnes_hospital = e.cnes_hospital
WHERE e.especialidade IN (SELECT especialidade FROM menos_frequentes)
GROUP BY h.cnes_hospital
HAVING COUNT(DISTINCT e.especialidade) >= 3;
