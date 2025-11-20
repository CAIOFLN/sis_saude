-- CONSULTA 1
-- Para todos recursos disponiveis em cada hospital, selecionar os recursos que estão 

SELECT *
FROM hospital h JOIN entidade_saude es ON h.cnes_hospital = es.cnes
    JOIN possui p ON p.cnes_entidade_saude = es.cnes
        JOIN recurso r ON r.registro_ms = p.registro_ms_recurso 
        




            SELECT p.registro_ms_recurso, avg(p.quantidade_disponivel), min(p.quantidade_disponivel), max(p.quantidade_disponivel)
            FROM hospital h JOIN entidade_saude es ON h.cnes_hospital = es.cnes
                JOIN possui p ON p.cnes_entidade_saude = es.cnes
            GROUP BY (p.registro_ms_recurso);