-- CONSULTA 1
-- Para todos recursos, selecionar os recursos de hospitais que estão abaixo da média


SELECT h.cnes_hospital, r.registro_ms, r.nome, COALESCE(p.quantidade_disponivel, 0) AS qtd_hospital, media.avg_estoque
FROM hospital h 
CROSS JOIN recurso r -- produto cartesiano para considerar todo os produtos possiveis
LEFT JOIN possui p ON (p.cnes_entidade_saude = h.cnes_hospital AND p.registro_ms_recurso = r.registro_ms)
JOIN (
    SELECT r.registro_ms, AVG(COALESCE(p.quantidade_disponivel, 0)) as avg_estoque -- sem estoque do recurso considera 0
    FROM hospital h JOIN possui p ON h.cnes_hospital = p.cnes_entidade_saude -- considera apenas hospitais para fazer a conta
    RIGHT JOIN recurso r ON r.registro_ms = p.registro_ms_recurso -- produtos que nao tem estoque deve ser considerado
    GROUP BY (r.registro_ms)
) media ON media.registro_ms = r.registro_ms
WHERE (COALESCE(p.quantidade_disponivel, 0) < media.avg_estoque or COALESCE(p.quantidade_disponivel, 0) = 0)
ORDER BY h.cnes_hospital;

--Consulta 2

SELECT *
FROM relatorio_recurso r JOIN pedido p ON r.id_pedido_relatorio = p.id_pedido
    JOIN turno t ON p.id_turno = t.id_turno
    JOIN entidade_saude es ON t.cnes_entidade_saude = es.cnes
WHERE p.quantidade > (
    SELECT SUM(p2.quantidade_disponivel) AS qtd_disponivel
    FROM entidade_saude es2 JOIN possui p2 on es2.cnes = p2.cnes_entidade_saude
    JOIN recurso r2 ON p2.registro_ms_recurso = r2.registro_ms
    WHERE (es2.cnes <> es.cnes AND r2.registro_ms = p.registro_ms_recurso)
);