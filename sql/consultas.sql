-- Consulta 1
-- Para todos recursos, selecionar os recursos de hospitais que estão abaixo da média
-- Quando o hospital nao ter o recurso (NULL) essa funcao coloca 0 no lugar "COALESCE(p.quantidade_disponivel, 0)"
SELECT h.cnes_hospital, r.registro_ms, r.nome, COALESCE(p.quantidade_disponivel, 0) AS qtd_hospital, media.avg_estoque, media.maior_estoque, media.menor_estoque
FROM hospital h 
CROSS JOIN recurso r -- produto cartesiano para considerar todo os recursos + hospitais possiveis
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


-- Consulta 2
/* Pesquisar pelos pedidos sob análise que requisitarem por uma quantia de um determinado recurso acima da disponível no estoque total
e exibir o pedido, o recurso, o estoque externo total e a quantia em falta daquele recurso. */
SELECT P.id_pedido, R.nome, R.registro_ms, P.quantidade, (COALESCE(EXT.estoque_total,0) - COALESCE(PS.quantidade_disponivel, 0)) AS estoque_externo, 
((COALESCE(EXT.estoque_total, 0) - COALESCE(PS.quantidade_disponivel, 0)) - P.quantidade) as em_falta -- Calcula-se a falta como a diferença da quantia pedida e do estoque externo.
    FROM relatorio_recurso RR
    JOIN pedido P ON P.id_pedido = RR.id_pedido_relatorio
    JOIN turno T ON P.id_turno = T.id_turno 
    JOIN recurso R ON R.registro_ms = P.registro_ms_recurso 
    LEFT JOIN possui PS ON PS.cnes_entidade_saude = T.cnes_entidade_saude AND PS.registro_ms_recurso = P.registro_ms_recurso -- Junção externa para não excluirmos hospitais que não possuem o recurso que estão pedindo.
    LEFT JOIN (
        SELECT SUM(PO.quantidade_disponivel) AS estoque_total, PO.registro_ms_recurso AS recurso
        FROM possui PO 
        GROUP BY PO.registro_ms_recurso) as EXT ON EXT.recurso = P.registro_ms_recurso -- Cálculo generalizado do estoque total de todos os recursos pedidos. Junção externa para pedidos de recursos que não existem em nenhum hospital.
WHERE P.quantidade > (COALESCE(EXT.estoque_total,0) - COALESCE(PS.quantidade_disponivel, 0)) AND RR.estado_relatorio = 'ANALISE' -- Somente exibição dos pedidos em análise;


-- Consulta 3.
-- Recursos que são produzidos por laboratorios mas nenhum hospital tem em estoque
SELECT r.registro_ms, r.nome, r.tipo
FROM recurso r
JOIN produz P ON r.registro_ms = P.registro_ms_recurso
LEFT JOIN (
        SELECT DISTINCT p.registro_ms_recurso
        FROM possui p
        JOIN entidade_saude es 
            ON p.cnes_entidade_saude = es.cnes
        WHERE es.tipo_entidade = 'HOSPITAL' AND p.quantidade_disponivel > 0
    ) AS RecursosComEstoqueEmHospital
    ON r.registro_ms = RecursosComEstoqueEmHospital.registro_ms_recurso
WHERE RecursosComEstoqueEmHospital.registro_ms_recurso IS NULL;



-- Consulta 4.
-- Selecionar quais hospitais atendem todas as 3 especialidades menos frequentes
-- No caso de teste, as 3 menos frequentes foram Cardiologia, Pediatria e Ortopedia
SELECT H.* -- Selecionar todos os atributos de hospital
    FROM HOSPITAL H 
        WHERE NOT EXISTS ( -- Se Not Exists for vazio, então atende a condição where e é retornado
            (SELECT E1.ESPECIALIDADE
                FROM ESPECIALIZACOES E1
            GROUP BY E1.ESPECIALIDADE
            ORDER BY COUNT(*) ASC
            LIMIT 3)
        -- Tradução: Seleção das 3 especialidades menos frequentes
    
        EXCEPT
            (SELECT E.ESPECIALIDADE 
                FROM ESPECIALIZACOES E
            WHERE E.cnes_hospital = H.cnes_hospital)
            -- Tradução: Seleção de todas as especialidades de um dado hospital
        );


-- Consulta 5.
-- Dado um hospital, nesse caso cnes = 2751503, devemos verificar todos os relatorio de recurso que estão em analise
-- e encontrar quais sao os laboratorios que são capazes de produzir todos os recursos  que estao presente nos relatorios em
-- analise

WITH recursos_requisitados AS (
    SELECT DISTINCT p.registro_ms_recurso
    FROM relatorio_recurso r JOIN pedido p ON r.id_pedido_relatorio = p.id_pedido
        JOIN turno t ON p.id_turno = t.id_turno
    WHERE (t.cnes_entidade_saude = '2751503' AND r.estado_relatorio = 'ANALISE'))
SELECT cnes_laboratorio, COUNT(*)
FROM produz 
WHERE registro_ms_recurso IN (SELECT * FROM recursos_requisitados)
GROUP BY cnes_laboratorio
HAVING COUNT(*) = (SELECT COUNT(*) FROM recursos_requisitados);


