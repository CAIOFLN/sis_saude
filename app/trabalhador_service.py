from datetime import datetime
from database import DatabaseConnection


class TrabalhadorService:
    
    def __init__(self, db: DatabaseConnection):
        self.db = db
    
    def buscar_trabalhador(self, funcao, registro):
        query = """
            SELECT t.id_pessoa, p.cpf, p.nome, t.funcao_trabalhador, t.registro_profissional
            FROM trabalhador_es t
            JOIN pessoa p ON t.id_pessoa = p.id_pessoa
            WHERE t.funcao_trabalhador = %s AND t.registro_profissional = %s;
        """
        return self.db.fetch_one(query, (funcao, registro))
    
    def verificar_turno_ativo(self, id_trabalhador):
        query = """
            SELECT t.id_turno, t.cnes_entidade_saude, t.tstz_entrada, e.nome
            FROM turno t
            JOIN entidade_saude e ON t.cnes_entidade_saude = e.cnes
            WHERE t.id_trabalhador_es = %s AND t.tstz_saida IS NULL;
        """
        return self.db.fetch_one(query, (id_trabalhador,))
    
    def iniciar_turno(self, id_trabalhador, cnes_entidade):
        # incializa turno com time atual do sistema
        query = """
            INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada)
            VALUES (%s, %s, %s)
            RETURNING id_turno;
        """
        result = self.db.fetch_one(query, (id_trabalhador, cnes_entidade, datetime.now()))
        return str(result[0]) if result else None
    
    def finalizar_turno(self, id_turno):
        # finaliza turno com time atual do sistema
        query = """
            UPDATE turno
            SET tstz_saida = %s
            WHERE id_turno = %s;
        """
        self.db.execute(query, (datetime.now(), id_turno))
        
    def buscar_entidades_por_nome(self, nome_busca):
        query = """
            SELECT cnes, nome, tipo_entidade
            FROM entidade_saude
            WHERE nome ILIKE %s
            ORDER BY nome;
        """
        # Adiciona % ao final para buscar nomes que começam com o texto
        return self.db.fetch_all(query, (f"{nome_busca}%",))
    