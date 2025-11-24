import os
import psycopg
from psycopg import Error
from contextlib import contextmanager  # Importa o contextmanager que permite criar gerenciadores de contexto
from typing import List, Tuple, Optional
from dotenv import load_dotenv  # Biblioteca que carrega variáveis de ambiente a partir de um arquivo .env

# Carregar variáveis de ambiente do arquivo .env
load_dotenv()


class DatabaseConnection:
    """Classe que gerencia a conexão com o banco de dados PostgreSQL."""

    def __init__(self):
        """
        Inicializa a classe com os parâmetros de conexão.
        
        Se algum parâmetro não for fornecido, ele será buscado nas variáveis de ambiente
        carregadas pelo dotenv (ex: DB_NAME, DB_USER, etc.).
        """
        self.connection_params = {
            'dbname':os.getenv('DB_NAME'),
            'user': os.getenv('DB_USER'),
            'password': os.getenv('DB_PASSWORD'),
            'host': os.getenv('DB_HOST'),
            'port': os.getenv('DB_PORT')
        }
        self.connection = None  # Inicializa a variável de conexão como None
        self.cursor = None  # Inicializa o cursor como None
    
    def connect(self) -> bool:
        """Estabelece conexão com o banco de dados PostgreSQL."""
        try:
            # Conecta ao banco usando os parâmetros fornecidos ou as variáveis de ambiente
            self.connection = psycopg.connect(**self.connection_params)
            self.cursor = self.connection.cursor()  # Cria o cursor para executar as consultas
            return True  # Se a conexão for bem-sucedida, retorna True
        except Error as e:
            print(f"Erro ao conectar: {e}")  # Exibe o erro caso ocorra uma falha na conexão
            return False
    
    def disconnect(self):
        """Fecha a conexão com o banco de dados e o cursor."""
        if self.cursor:
            self.cursor.close()  # Fecha o cursor
        if self.connection:
            self.connection.close()  # Fecha a conexão com o banco
    
    def fetch_one(self, query, params = None):
        """Executa uma query e retorna apenas um resultado (o primeiro encontrado)."""
        try:
            self.cursor.execute(query, params)  # Executa a consulta com os parâmetros fornecidos
            return self.cursor.fetchone()  # Retorna o primeiro resultado encontrado
        except Error as e:
            print(f"Erro ao buscar registro: {e}")  # Exibe erro caso algo dê errado
            raise
    
    def fetch_all(self, query, params = None):
        """Executa uma query e retorna todos os resultados encontrados."""
        try:
            self.cursor.execute(query, params)  # Executa a consulta com os parâmetros fornecidos
            return self.cursor.fetchall()  # Retorna todos os resultados encontrados
        except Error as e:
            print(f"Erro ao buscar registros: {e}")  # Exibe erro caso algo dê errado
            raise
    
    def execute(self, query, params = None):
        """Executa uma query de alteração no banco (INSERT, UPDATE, DELETE)."""
        try:
            self.cursor.execute(query, params)  # Executa a consulta de alteração
        except Error as e:
            print(f"Erro ao executar query: {e}")  # Exibe erro caso algo dê errado
            raise
    
    def commit(self):
        """Confirma as alterações no banco de dados, realizando o commit da transação."""
        if self.connection:
            self.connection.commit()  # Confirma todas as alterações feitas durante a transação
    
    def rollback(self):
        """Desfaz as alterações não commitadas em caso de erro (rollback da transação)."""
        if self.connection:
            self.connection.rollback()  # Reverte todas as alterações feitas até o momento
    
    @contextmanager
    def transaction(self):
        """
        https://docs.python.org/3/library/contextlib.html
        Gerenciador de contexto para transações. Garante que o commit seja feito se
        a execução ocorrer sem erros, ou rollback se ocorrer alguma falha.
        
        Esse método usa o decorador @contextmanager, que permite que você utilize
        o 'with' para gerenciar transações de forma automática.
        
        O fluxo é o seguinte:
        - Quando a transação é iniciada, o código dentro do 'with' é executado.
        - Se não houver erro, o commit é realizado .
        - Se ocorrer um erro, o rollback é chamado .
        """
        try:
            yield self  # O 'yield' executa o código dentro do 'with'
            self.commit()  # Se o código dentro do 'with' for bem-sucedido, confirma a transação
        except Exception as e:
            self.rollback()  # Se ocorrer um erro, desfaz as alterações feitas na transação
            print(f"Transação revertida: {e}")  # Imprime a mensagem de erro
            raise  # Relança o erro para que ele possa ser tratado externamente
