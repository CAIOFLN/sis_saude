


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
        if existe_pessoa:
            query2 = """
                SELECT 1
                FROM tipo_pessoa
                WHERE id_pessoa = %s and tipo = 'PACIENTE';
            """
            paciente = self.db.fetch_one(query2, (existe_pessoa[0],))
            if paciente:
                return True
        return False