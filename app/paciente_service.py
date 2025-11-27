class PacienteService:
    def __init__(self, db):
        self.db = db


    def verifica_cadastro_paciente(self, cpf):
        query1 = """
            SELECT id_pessoa
            FROM pessoa 
            WHERE cpf = %s;
        """
        existe_pessoa = self.db.fetch_one(query1, (cpf,))
        
        if not existe_pessoa:
            return None
        
        id_pessoa = existe_pessoa[0]
        
        query2 = """
            SELECT 1
            FROM tipo_pessoa
            WHERE id_pessoa = %s AND tipo = 'PACIENTE';
        """
        e_paciente = self.db.fetch_one(query2, (id_pessoa,))
        
        return {
            'id_pessoa': id_pessoa,
            'tipo_paciente': bool(e_paciente)
        }

    def busca_relatorio_casos_paciente(self, id_paciente):
        query = """
            SELECT rc.texto_relatorio, rc.palavra_chave_1, rc.palavra_chave_2, t.cnes_entidade_saude, rc.tstz_relatorio
            FROM relatorio_caso rc 
            JOIN turno t ON rc.id_turno = t.id_turno
            JOIN entidade_saude es ON t.cnes_entidade_saude = es.cnes
            WHERE rc.id_paciente = %s;
        """ 
        return self.db.fetch_all(query, (id_paciente,))
    
    def cadastrar_pessoa(self, cpf, nome):
        query = """
            INSERT INTO pessoa (cpf, nome)
            VALUES (%s, %s)
            RETURNING id_pessoa;
        """
        result = self.db.fetch_one(query, (cpf, nome))
        return result[0]
    
    def adicionar_tipo_paciente(self, id_pessoa):
        query = """
            INSERT INTO tipo_pessoa (id_pessoa, tipo)
            VALUES (%s, 'PACIENTE');
        """
        self.db.execute(query, (id_pessoa,))
    

    def cadastrar_paciente(self, id_pessoa):
        query = """
            INSERT INTO paciente (id_pessoa)
            VALUES (%s);
        """
        self.db.execute(query, (id_pessoa,))

    def insere_relatorio_caso(self, id_paciente, id_turno, texto_relatorio, palavra_chave_1=None, palavra_chave_2=None):
        query = """
            INSERT INTO relatorio_caso (
                id_paciente, 
                tstz_relatorio, 
                id_turno, 
                texto_relatorio, 
                palavra_chave_1, 
                palavra_chave_2
            )
            VALUES (%s, NOW(), %s, %s, %s, %s)
            RETURNING id_relatorio_caso;
        """
        return( self.db.fetch_one(query, (
            id_paciente,
            id_turno,
            texto_relatorio,
            palavra_chave_1,
            palavra_chave_2
        )))

    

