"""
Serviço para operações relacionadas a trabalhadores de saúde.
"""
from datetime import datetime
from typing import Optional, Tuple
from database import DatabaseConnection


class TrabalhadorService:
    """Gerencia operações de trabalhadores e turnos."""
    
    def __init__(self, db: DatabaseConnection):
        self.db = db
    
    def buscar_trabalhador(self, funcao: str, registro: str) -> Optional[Tuple]:
        """
        Busca trabalhador por função e registro profissional.
        
        Args:
            funcao: 'MEDICO' ou 'ENFERMEIRO'
            registro: CRM ou COREN
        
        Returns:
            Tupla (id_pessoa, cpf, nome, funcao, registro) ou None
        """
        query = """
            SELECT t.id_pessoa, p.cpf, p.nome, t.funcao_trabalhador, t.registro_profissional
            FROM trabalhador_es t
            JOIN pessoa p ON t.id_pessoa = p.id_pessoa
            WHERE t.funcao_trabalhador = %s AND t.registro_profissional = %s;
        """
        return self.db.fetch_one(query, (funcao, registro))
    
    def verificar_turno_ativo(self, id_trabalhador: int) -> Optional[Tuple]:
        """
        Verifica se o trabalhador possui turno ativo (sem saída registrada).
        
        Args:
            id_trabalhador: ID do trabalhador
        
        Returns:
            Tupla (id_turno, cnes_entidade_saude, tstz_entrada, nome_entidade) ou None
        """
        query = """
            SELECT t.id_turno, t.cnes_entidade_saude, t.tstz_entrada, e.nome
            FROM turno t
            JOIN entidade_saude e ON t.cnes_entidade_saude = e.cnes
            WHERE t.id_trabalhador_es = %s AND t.tstz_saida IS NULL;
        """
        return self.db.fetch_one(query, (id_trabalhador,))
    
    def iniciar_turno(self, id_trabalhador: int, cnes_entidade: str) -> str:
        """
        Inicia um novo turno para o trabalhador.
        
        Args:
            id_trabalhador: ID do trabalhador
            cnes_entidade: CNES da entidade de saúde
        
        Returns:
            ID do turno criado (UUID)
        """
        query = """
            INSERT INTO turno (id_trabalhador_es, cnes_entidade_saude, tstz_entrada)
            VALUES (%s, %s, %s)
            RETURNING id_turno;
        """
        result = self.db.fetch_one(query, (id_trabalhador, cnes_entidade, datetime.now()))
        return str(result[0]) if result else None
    
    def finalizar_turno(self, id_turno: str):
        """
        Finaliza um turno registrando o horário de saída.
        
        Args:
            id_turno: ID do turno (UUID)
        """
        query = """
            UPDATE turno
            SET tstz_saida = %s
            WHERE id_turno = %s;
        """
        self.db.execute(query, (datetime.now(), id_turno))
    
    def listar_entidades_saude(self):
        """Lista todas as entidades de saúde disponíveis."""
        query = """
            SELECT cnes, nome, tipo_entidade
            FROM entidade_saude
            ORDER BY nome;
        """
        return self.db.fetch_all(query)
    
    def buscar_entidades_por_nome(self, nome_busca: str):
        """
        Busca entidades de saúde cujo nome começa com o texto fornecido.
        Usa LIKE com proteção contra SQL injection.
        
        Args:
            nome_busca: Início do nome da entidade
        
        Returns:
            Lista de tuplas (cnes, nome, tipo_entidade)
        """
        query = """
            SELECT cnes, nome, tipo_entidade
            FROM entidade_saude
            WHERE nome ILIKE %s
            ORDER BY nome;
        """
        # Adiciona % ao final para buscar nomes que começam com o texto
        return self.db.fetch_all(query, (f"{nome_busca}%",))
    
    def buscar_entidade(self, cnes: str) -> Optional[Tuple]:
        """Busca entidade de saúde por CNES."""
        query = """
            SELECT cnes, nome, tipo_entidade
            FROM entidade_saude
            WHERE cnes = %s;
        """
        return self.db.fetch_one(query, (cnes,))
