from datetime import datetime
from database import DatabaseConnection


class PedidoService:    
    def __init__(self, db: DatabaseConnection):
        self.db = db
    
    def listar_recursos(self):
        # Lista recursos cadastrado no sistema por ordem alfabetica
        query = """
            SELECT registro_ms, nome, tipo
            FROM recurso
            ORDER BY nome;
        """
        return self.db.fetch_all(query)
        
    def criar_pedido(self, id_turno, registro_ms_recurso, 
                    quantidade, urgencia, justificativa = None):
        query = """
            INSERT INTO pedido (id_turno, registro_ms_recurso, tstz_pedido, 
                               quantidade, urgencia, justificativa)
            VALUES (%s, %s, %s, %s, %s, %s)
            RETURNING id_pedido;
        """
        result = self.db.fetch_one(query, (
            id_turno, registro_ms_recurso, datetime.now(), 
            quantidade, urgencia, justificativa
        ))
        return result[0] if result else None
    