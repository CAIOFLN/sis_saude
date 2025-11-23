"""
Módulo de conexão e gerenciamento do banco de dados PostgreSQL.
Implementa proteção contra SQL injection e controle de transações.
"""
import os
import psycopg
from psycopg import Error
from contextlib import contextmanager
from typing import List, Tuple, Optional
from dotenv import load_dotenv

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()


class DatabaseConnection:
    """Gerencia a conexão com o banco de dados PostgreSQL."""
    
    def __init__(self, dbname: str = None, user: str = None, 
                 password: str = None, host: str = None, port: str = None):
        self.connection_params = {
            'dbname': dbname or os.getenv('DB_NAME', 'sis_saude'),
            'user': user or os.getenv('DB_USER', 'postgres'),
            'password': password or os.getenv('DB_PASSWORD', ''),
            'host': host or os.getenv('DB_HOST', 'localhost'),
            'port': port or os.getenv('DB_PORT', '5432')
        }
        self.connection = None
        self.cursor = None
    
    def connect(self) -> bool:
        """Estabelece conexão com o banco de dados."""
        try:
            self.connection = psycopg.connect(**self.connection_params)
            self.cursor = self.connection.cursor()
            return True
        except Error as e:
            print(f"Erro ao conectar: {e}")
            return False
    
    def disconnect(self):
        """Fecha a conexão com o banco de dados."""
        if self.cursor:
            self.cursor.close()
        if self.connection:
            self.connection.close()
    
    def fetch_one(self, query: str, params: Optional[Tuple] = None) -> Optional[Tuple]:
        """Executa query e retorna apenas um resultado."""
        try:
            self.cursor.execute(query, params)
            return self.cursor.fetchone()
        except Error as e:
            print(f"Erro ao buscar registro: {e}")
            raise
    
    def fetch_all(self, query: str, params: Optional[Tuple] = None) -> List[Tuple]:
        """Executa query e retorna todos os resultados."""
        try:
            self.cursor.execute(query, params)
            return self.cursor.fetchall()
        except Error as e:
            print(f"Erro ao buscar registros: {e}")
            raise
    
    def execute(self, query: str, params: Optional[Tuple] = None):
        """Executa uma query (INSERT, UPDATE, DELETE)."""
        try:
            self.cursor.execute(query, params)
        except Error as e:
            print(f"Erro ao executar query: {e}")
            raise
    
    def commit(self):
        """Confirma as alterações no banco de dados."""
        if self.connection:
            self.connection.commit()
    
    def rollback(self):
        """Desfaz as alterações não commitadas."""
        if self.connection:
            self.connection.rollback()
    
    @contextmanager
    def transaction(self):
        """
        Context manager para gerenciar transações automaticamente.
        Faz commit se tudo correr bem, ou rollback em caso de erro.
        """
        try:
            yield self
            self.commit()
        except Exception as e:
            self.rollback()
            print(f"Transação revertida: {e}")
            raise
