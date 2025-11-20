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

--
