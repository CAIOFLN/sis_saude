"""
Serviço para operações relacionadas a pedidos de recursos.
"""
from datetime import datetime
from typing import Optional, Tuple, List
from database import DatabaseConnection


class PedidoService:
    """Gerencia operações de pedidos de recursos."""
    
    def __init__(self, db: DatabaseConnection):
        self.db = db
    
    def listar_recursos(self) -> List[Tuple]:
        """Lista todos os recursos disponíveis."""
        query = """
            SELECT registro_ms, nome, tipo
            FROM recurso
            ORDER BY nome;
        """
        return self.db.fetch_all(query)
    
    def buscar_recurso(self, registro_ms: str) -> Optional[Tuple]:
        """Busca recurso por registro MS."""
        query = """
            SELECT registro_ms, nome, tipo
            FROM recurso
            WHERE registro_ms = %s;
        """
        return self.db.fetch_one(query, (registro_ms,))
    
    def criar_pedido(self, id_turno: str, registro_ms_recurso: str, 
                    quantidade: int, urgencia: str, justificativa: str = None) -> str:
        """
        Cria um novo pedido de recurso.
        
        Args:
            id_turno: ID do turno ativo
            registro_ms_recurso: Registro MS do recurso
            quantidade: Quantidade solicitada
            urgencia: 'BAIXA', 'MEDIA' ou 'EXTREMA'
            justificativa: Justificativa do pedido (opcional)
        
        Returns:
            ID do pedido criado (UUID)
        """
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
        return str(result[0]) if result else None
    
    def listar_pedidos_turno(self, id_turno: str) -> List[Tuple]:
        """Lista todos os pedidos feitos durante um turno."""
        query = """
            SELECT p.id_pedido, p.tstz_pedido, r.nome, p.quantidade, 
                   p.urgencia, p.justificativa
            FROM pedido p
            JOIN recurso r ON p.registro_ms_recurso = r.registro_ms
            WHERE p.id_turno = %s
            ORDER BY p.tstz_pedido DESC;
        """
        return self.db.fetch_all(query, (id_turno,))
