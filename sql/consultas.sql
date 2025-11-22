-- CONSULTA 1
-- Para todos recursos, selecionar os recursos de hospitais que estão abaixo da média
-- Quando o hospital nao ter o recurso (NULL) essa funcao coloca 0 no lugar "COALESCE(p.quantidade_disponivel, 0)"

SELECT h.cnes_hospital, r.registro_ms, r.nome, COALESCE(p.quantidade_disponivel, 0) AS qtd_hospital, media.avg_estoque, media.maior_estoque, media.menor_estoque
FROM hospital h 
CROSS JOIN recurso r -- produto cartesiano para considerar todo os produtos possiveis
LEFT JOIN possui p ON (p.cnes_entidade_saude = h.cnes_hospital AND p.registro_ms_recurso = r.registro_ms)
JOIN ( -- podemos fazer join pois devido ao CROSS JOIN ja temos todas as combinacoes possivel
    SELECT r.registro_ms, AVG(COALESCE(p.quantidade_disponivel, 0)) as avg_estoque, MIN(COALESCE(p.quantidade_disponivel, 0)) as menor_estoque,
    MAX(COALESCE(p.quantidade_disponivel, 0)) as maior_estoque -- quando nao tem estoque considera 0
    FROM hospital h JOIN possui p ON h.cnes_hospital = p.cnes_entidade_saude -- considera apenas hospitais para fazer a conta
    RIGHT JOIN recurso r ON r.registro_ms = p.registro_ms_recurso -- produtos que nao tem estoque deve ser considerado
    GROUP BY (r.registro_ms)
) media ON media.registro_ms = r.registro_ms
WHERE (COALESCE(p.quantidade_disponivel, 0) < media.avg_estoque or COALESCE(p.quantidade_disponivel, 0) = 0)
ORDER BY h.cnes_hospital;

-- Não criei casos especificos pois os dados padroes ja geram uma boa querry

--Consulta 2

-- Versão 1 (Feita pelo Avatas)
/*SELECT r.id_pedido_relatorio AS id_pedido, r.justificativa_decisao AS parecer_diretor, es.nome, p.quantidade, p.urgencia
FROM relatorio_recurso r JOIN pedido p ON r.id_pedido_relatorio = p.id_pedido
    JOIN turno t ON p.id_turno = t.id_turno
    JOIN entidade_saude es ON t.cnes_entidade_saude = es.cnes
WHERE (r.estado_relatorio = 'ANALISE' AND  p.quantidade > (
    SELECT SUM(p2.quantidade_disponivel) AS qtd_disponivel
    FROM entidade_saude es2 JOIN possui p2 on es2.cnes = p2.cnes_entidade_saude
    JOIN recurso r2 ON p2.registro_ms_recurso = r2.registro_ms
    WHERE (es2.cnes <> es.cnes AND r2.registro_ms = p.registro_ms_recurso)
));

-- Versão 2 (Mais performance em comparação à 3 porém menos informações)
SELECT P.id_pedido, R.nome, R.registro_ms, P.quantidade -- Pode retornar somente com o ID do recurso para evitar uma junção adicional
    FROM PEDIDO P
    JOIN turno T ON P.id_turno = T.id_turno 
    JOIN entidade_saude ES ON ES.cnes = T.cnes_entidade_saude
    JOIN recurso R ON R.registro_ms = P.registro_ms_recurso -- Linha opcional caso deseja-se listar também qual o nome do recurso em falta.
WHERE P.quantidade > (
    SELECT SUM(PO.quantidade_disponivel) as ESTOQUE_EXTERNO FROM possui PO 
    JOIN entidade_saude ES2 ON PO.cnes_entidade_saude = ES2.cnes
    WHERE ES2.cnes <> ES.cnes AND PO.registro_ms_recurso = P.registro_ms_recurso
    GROUP BY PO.registro_ms_recurso);
*/

-- Versão 3 (Menos performance porém bem mais explicativo e útil)
SELECT P.id_pedido, R.nome, R.registro_ms, P.quantidade, EXT.ESTOQUE_EXTERNO, (EXT.ESTOQUE_EXTERNO - P.quantidade) AS FALTA
    FROM PEDIDO P
    JOIN turno T ON P.id_turno = T.id_turno 
    JOIN entidade_saude ES ON ES.cnes = T.cnes_entidade_saude
    JOIN recurso R ON R.registro_ms = P.registro_ms_recurso 
JOIN LATERAL(
    SELECT SUM(PO.quantidade_disponivel) as ESTOQUE_EXTERNO 
    FROM possui PO 
    JOIN entidade_saude ES2 ON PO.cnes_entidade_saude = ES2.cnes
    WHERE ES2.cnes <> ES.cnes AND PO.registro_ms_recurso = P.registro_ms_recurso
    GROUP BY PO.registro_ms_recurso) AS EXT ON TRUE
WHERE P.quantidade > EXT.ESTOQUE_EXTERNO;






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
