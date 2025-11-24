from database import DatabaseConnection
from trabalhador_service import TrabalhadorService
from pedido_service import PedidoService
from paciente_service import PacienteService
import re

class SistemaSaude:    
    def __init__(self):
        self.db = DatabaseConnection()
        self.trabalhador_service = TrabalhadorService(self.db)
        self.pedido_service = PedidoService(self.db)
        self.paciente_service = PacienteService(self.db)
        self.trabalhador_atual = None
        self.turno_atual = None
    
    def conectar_banco(self) -> bool:
        """Conecta ao banco de dados."""
        print("=" * 60)
        print("SISTEMA DE SAÚDE - Gerenciamento de Turnos e Pedidos")
        print("=" * 60)
        print("\nConectando ao banco de dados...")
        
        if self.db.connect():
            print("Conectado com sucesso!\n")
            return True
        else:
            print("Falha na conexão. Verifique as configurações do banco.")
            return False
    
    def passo1_autenticacao(self) -> bool:
        """
        PASSO 1: Perguntar função e registro profissional.
        Verifica se está cadastrado no banco.
        """
        print("\n" + "=" * 60)
        print("PASSO 1: AUTENTICAÇÃO")
        print("=" * 60)
        
        while True:
            print("\nQual sua função?")
            print("1 - Médico")
            print("2 - Enfermeiro")
            print("0 - Sair")
            
            opcao = input("\nEscolha uma opção: ").strip()
            
            if opcao == '1':
                funcao = 'MEDICO'
                tipo_registro = "CRM"
                break
            elif opcao == '2':
                funcao = 'ENFERMEIRO'
                tipo_registro = "COREN"
                break
            elif opcao == '0':
                print("\nAplicação encerrada.")
                return False
            else:
                print("Opção inválida! Tente novamente.")
        
        registro = input(f"\nDigite seu {tipo_registro}: ").strip()
        
        trabalhador = self.trabalhador_service.buscar_trabalhador(funcao, registro)
        if trabalhador:
            self.trabalhador_atual = {
                'id': trabalhador[0],
                'cpf': trabalhador[1],
                'nome': trabalhador[2],
                'funcao': trabalhador[3],
                'registro': trabalhador[4]
            }
            print(f"\nBem-vindo(a), {self.trabalhador_atual['nome']}!")
            return True
        else:
            print("\nRegistro não encontrado no sistema.")
            return False
    
    def passo2_verificar_turno(self):
        """
        PASSO 2: Verifica se tem turno ativo.
        Se não tem: opção de iniciar turno ou sair.
        Se tem: direciona para o fluxo específico (médico ou enfermeiro).
        """
        print("\n" + "=" * 60)
        print("PASSO 2: VERIFICAÇÃO DE TURNO")
        print("=" * 60)
        
        turno = self.trabalhador_service.verificar_turno_ativo(self.trabalhador_atual['id'])
        
        if turno:
            # Tem turno ativo - direciona para fluxo específico
            self.turno_atual = {
                'id': str(turno[0]),
                'cnes': turno[1],
                'entrada': turno[2],
                'nome_entidade': turno[3]
            }
            print(f"\nVocê possui um turno ativo.")
            print(f"Entidade: {self.turno_atual['nome_entidade']}")
            print(f"Entrada: {self.turno_atual['entrada'].strftime('%d/%m/%Y às %H:%M')}")
            
            # Direciona para o fluxo específico baseado na função
            if self.trabalhador_atual['funcao'] == 'MEDICO':
                return self.fluxo_medico()
            else:  # ENFERMEIRO
                return self.fluxo_enfermeiro()
        else:
            # Não tem turno ativo
            print("\nVocê não possui turno ativo no momento.")
            return self.menu_iniciar_turno()
    
    def fluxo_medico(self) -> bool:
        """Fluxo de operações para médicos."""
        while True:
            print("\n" + "-" * 60)
            print("MENU MÉDICO")
            print("-" * 60)
            print("1 - Fazer um pedido de recurso")
            print("2 - Buscar relatórios de caso de um paciente")
            print("3 - Cadastrar relatório de caso")
            print("4 - Finalizar turno")
            print("5 - Sair")
            
            opcao = input("\nEscolha uma opção: ").strip()
            
            if opcao == '1':
                self.passo3_fazer_pedido()
            elif opcao == '2':
                self.buscar_relatorio_caso()
            elif opcao == '3':
                print("\nFuncionalidade em desenvolvimento.")
            elif opcao == '4':
                return self.passo4_finalizar_turno()
            elif opcao == '5':
                print("\nSessão encerrada.")
                return True
            else:
                print("Opção inválida!")
    
    def fluxo_enfermeiro(self) -> bool:
        """Fluxo de operações para enfermeiros."""
        while True:
            print("\n" + "-" * 60)
            print("MENU ENFERMEIRO")
            print("-" * 60)
            print("1 - Fazer um pedido de recurso")
            print("2 - Finalizar turno")
            print("3 - Sair")
            
            opcao = input("\nEscolha uma opção: ").strip()
            
            if opcao == '1':
                self.passo3_fazer_pedido()
            elif opcao == '2':
                return self.passo4_finalizar_turno()
            elif opcao == '3':
                print("\nSessão encerrada.")
                return True
            else:
                print("Opção inválida!")
    
    def menu_iniciar_turno(self) -> bool:
        """Menu para iniciar um novo turno."""
        while True:
            print("\n" + "-" * 60)
            print("Deseja iniciar um novo turno?")
            print("1 - Sim")
            print("2 - Não (sair)")
            
            opcao = input("\nEscolha uma opção: ").strip()
            
            if opcao == '1':
                return self.iniciar_turno()
            elif opcao == '2' or opcao == '0':
                print("\nAplicação encerrada.")
                return False
            else:
                print("Opção inválida! Tente novamente.")
    
    def iniciar_turno(self) -> bool:
        """Inicia um novo turno."""
        print("\n" + "-" * 60)
        print("INICIAR NOVO TURNO")
        print("-" * 60)
        
        nome_busca = input("\nDigite o nome da entidade: ").strip()
        
        if not nome_busca:
            print("Nome não pode ser vazio.")
            return False
        
        entidades = self.trabalhador_service.buscar_entidades_por_nome(nome_busca)
        
        if not entidades:
            print(f"Nenhuma entidade encontrada com nome começando por '{nome_busca}'.")
            return False
        
        print(f"\nEntidades encontradas:")
        for i, (cnes, nome, tipo) in enumerate(entidades, 1):
            print(f"{i}. {nome} ({tipo})")
        print("0. Sair")
        
        while True:
            try:
                escolha = int(input("\nEscolha o número da entidade: ").strip())
                if escolha == 0:
                    return False
                elif 1 <= escolha <= len(entidades):
                    break
                else:
                    print("Opção inválida! Tente novamente.")
            except ValueError:
                print("Entrada inválida! Digite um número.")
        
        try:
            if True:
                cnes_escolhido = entidades[escolha - 1][0]
                nome_escolhido = entidades[escolha - 1][1]
                
                # Usar transação para garantir consistência
                with self.db.transaction():
                    id_turno = self.trabalhador_service.iniciar_turno(
                        self.trabalhador_atual['id'], 
                        cnes_escolhido
                    )
                
                self.turno_atual = {
                    'id': id_turno,
                    'cnes': cnes_escolhido,
                    'nome_entidade': nome_escolhido
                }
                
                print(f"\nTurno iniciado com sucesso!")
                print(f"Entidade: {nome_escolhido}")
                
                # Direciona para o fluxo específico baseado na função
                if self.trabalhador_atual['funcao'] == 'MEDICO':
                    return self.fluxo_medico()
                else:  # ENFERMEIRO
                    return self.fluxo_enfermeiro()
        except Exception as e:
            print(f"Erro ao iniciar turno.")
            return False
    
    def passo3_fazer_pedido(self):
        """
        PASSO 3: Fazer um pedido de recurso.
        """
        print("\n" + "=" * 60)
        print("PASSO 3: FAZER PEDIDO DE RECURSO")
        print("=" * 60)
        
        # Listar recursos disponíveis
        recursos = self.pedido_service.listar_recursos()
        
        if not recursos:
            print("Nenhum recurso cadastrado no sistema.")
            return
        
        print("\nRecursos disponíveis:")
        for i, (registro_ms, nome, tipo) in enumerate(recursos, 1):
            print(f"{i}. {nome} ({tipo})")
        print("0. Cancelar")
        
        # Escolher recurso
        while True:
            try:
                escolha = int(input("\nEscolha o número do recurso: ").strip())
                if escolha == 0:
                    return
                elif 1 <= escolha <= len(recursos):
                    break
                else:
                    print("Opção inválida! Tente novamente.")
            except ValueError:
                print("Entrada inválida! Digite um número.")
        
        recurso_escolhido = recursos[escolha - 1]
        registro_ms = recurso_escolhido[0]
        nome_recurso = recurso_escolhido[1]
        
        # Quantidade
        while True:
            try:
                quantidade = int(input("Quantidade solicitada: ").strip())
                if quantidade > 0:
                    break
                else:
                    print("Quantidade deve ser maior que zero! Tente novamente.")
            except ValueError:
                print("Entrada inválida! Digite um número.")
        
        # Urgência
        while True:
            print("\nNível de urgência:")
            print("1 - BAIXA")
            print("2 - MEDIA")
            print("3 - EXTREMA")
            print("0 - Cancelar pedido")
            urgencia_opt = input("Escolha uma opção: ").strip()
            
            if urgencia_opt == '0':
                return
            
            urgencia_map = {'1': 'BAIXA', '2': 'MEDIA', '3': 'EXTREMA'}
            if urgencia_opt in urgencia_map:
                urgencia = urgencia_map[urgencia_opt]
                break
            else:
                print("Opção inválida! Tente novamente.")
        
        # Justificativa
        justificativa = input("\nJustificativa (opcional, pressione Enter para pular): ").strip()
        justificativa = justificativa if justificativa else None
        
        # Criar pedido com transação
        try:
            with self.db.transaction():
                id_pedido = self.pedido_service.criar_pedido(
                    self.turno_atual['id'],
                    registro_ms,
                    quantidade,
                    urgencia,
                    justificativa
                )
            
            print(f"\nPedido criado com sucesso!")
            print(f"Recurso: {nome_recurso}")
            print(f"Quantidade: {quantidade}")
            print(f"Urgência: {urgencia}")
            
        except Exception as e:
            print(f"Erro ao criar pedido: {e}")
    
    def buscar_relatorio_caso(self):
        cpf = input("\nInforme o CPF do paciente:").strip()
        cpf_padrao = r'[0-9]{11}'
        if not re.fullmatch(cpf_padrao, cpf):
            print("CPF inválido (deve conter exatamente 11 números).")
            return
        print(self.paciente_service.verifica_cadastro_paciente(cpf))


    def passo4_finalizar_turno(self) -> bool:
        """
        PASSO 4: Finalizar o turno atual.
        """
        print("\n" + "=" * 60)
        print("PASSO 4: FINALIZAR TURNO")
        print("=" * 60)
        
        while True:
            print("\nTem certeza que deseja finalizar o turno?")
            print("1 - Sim")
            print("2 - Não")
            
            opcao = input("\nEscolha uma opção: ").strip()
            
            if opcao == '1':
                break
            elif opcao == '2':
                print("\nTurno não finalizado.")
                return False
            else:
                print("Opção inválida! Tente novamente.")
        
        if True:
            try:
                # Finalizar turno com transação
                with self.db.transaction():
                    self.trabalhador_service.finalizar_turno(self.turno_atual['id'])
                
                print(f"\nTurno finalizado com sucesso!")
                print(f"Entidade: {self.turno_atual['nome_entidade']}")
                
                # Mostrar pedidos feitos durante o turno
                pedidos = self.pedido_service.listar_pedidos_turno(self.turno_atual['id'])
                if pedidos:
                    print(f"\nTotal de pedidos realizados: {len(pedidos)}")
                    for i, pedido in enumerate(pedidos, 1):
                        print(f"  {i}. {pedido[2]} - Qtd: {pedido[3]} - Urgência: {pedido[4]}")
                
                self.turno_atual = None
                print("\nSessão encerrada.")
                return True
                
            except Exception as e:
                print(f"Erro ao finalizar turno: {e}")
                return False
    
    def executar(self):
        """Executa o fluxo principal da aplicação."""
        try:
            # Conectar ao banco
            if not self.conectar_banco():
                return
            
            # PASSO 1: Autenticação
            if not self.passo1_autenticacao():
                return
            
            # PASSO 2: Verificar turno (que leva aos passos 3 e 4)
            self.passo2_verificar_turno()
            
        except KeyboardInterrupt:
            print("\n\nAplicação interrompida pelo usuário.")
        except Exception as e:
            print(f"\nErro inesperado: {e}")
        finally:
            # Sempre desconectar do banco
            self.db.disconnect()
            print("\nDesconectado do banco de dados.")
            print("=" * 60)


def main():
    """Função principal."""
    app = SistemaSaude()
    app.executar()


if __name__ == "__main__":
    main()
