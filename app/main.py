from database import DatabaseConnection
from trabalhador_service import TrabalhadorService
from pedido_service import PedidoService
import re

class SistemaSaude:    
    def __init__(self):
        self.db = DatabaseConnection()
        self.trabalhador_service = TrabalhadorService(self.db)
        self.pedido_service = PedidoService(self.db)
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
        
        print("\nQual sua função?")
        print("1 - Médico")
        print("2 - Enfermeiro")
        
        opcao = input("\nEscolha (1 ou 2): ").strip()
        
        if opcao == '1':
            funcao = 'MEDICO'
            tipo_registro = "CRM"
        elif opcao == '2':
            funcao = 'ENFERMEIRO'
            tipo_registro = "COREN"
        else:
            print("✗ Opção inválida!")
            return False
        
        registro = input(f"\nDigite seu {tipo_registro} (formato: 123456-UF): ").strip()
        registro_regex = r'^[0-9]{4,6}-[A-Z]{2}$'
        if not re.match(registro_regex, registro):
            print("Formato de registro inválido! - SQL INJECTION PREVENTED")
            return False
        
        trabalhador = self.trabalhador_service.buscar_trabalhador(funcao, registro)
        if trabalhador:
            self.trabalhador_atual = {
                'id': trabalhador[0],
                'cpf': trabalhador[1],
                'nome': trabalhador[2],
                'funcao': trabalhador[3],
                'registro': trabalhador[4]
            }
            print(f"\n Bem-vindo(a), {self.trabalhador_atual['nome']}!")
            print(f"  CPF: {self.trabalhador_atual['cpf']}")
            print(f"  {tipo_registro}: {self.trabalhador_atual['registro']}")
            return True
        else:
            print(f"\n{funcao} com {tipo_registro} {registro} não encontrado(a) no sistema.")
            print("Aplicação encerrada.")
            return False
    
    def passo2_verificar_turno(self):
        """
        PASSO 2: Verifica se tem turno ativo.
        Se sim: opção de finalizar turno ou fazer pedido.
        Se não: opção de iniciar turno.
        """
        print("\n" + "=" * 60)
        print("PASSO 2: VERIFICAÇÃO DE TURNO")
        print("=" * 60)
        
        turno = self.trabalhador_service.verificar_turno_ativo(self.trabalhador_atual['id'])
        
        if turno:
            # Tem turno ativo
            self.turno_atual = {
                'id': str(turno[0]),
                'cnes': turno[1],
                'entrada': turno[2],
                'nome_entidade': turno[3]
            }
            print(f"\n Você possui um turno ATIVO:")
            print(f"  Entidade: {self.turno_atual['nome_entidade']} (CNES: {self.turno_atual['cnes']})")
            print(f"  Entrada: {self.turno_atual['entrada'].strftime('%d/%m/%Y %H:%M:%S')}")
            
            return self.menu_turno_ativo()
        else:
            # Não tem turno ativo
            print("\nVocê não possui turno ativo no momento.")
            return self.menu_iniciar_turno()
    
    def menu_turno_ativo(self) -> bool:
        """Menu de opções quando há turno ativo."""
        while True:
            print("\n" + "-" * 60)
            print("O que deseja fazer?")
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
        print("\n" + "-" * 60)
        print("Deseja iniciar um novo turno?")
        print("1 - Sim")
        print("2 - Não (sair)")
        
        opcao = input("\nEscolha uma opção: ").strip()
        
        if opcao == '1':
            return self.iniciar_turno()
        else:
            print("\nAplicação encerrada.")
            return False
    
    def iniciar_turno(self) -> bool:
        """Inicia um novo turno."""
        print("\n" + "-" * 60)
        print("INICIAR NOVO TURNO")
        print("-" * 60)
        
        # Buscar entidades por nome
        nome_busca = input("\nDigite o início do nome da entidade de saúde: ").strip()
        
        # Regex para validar que o nome não contém caracteres especiais perigosos
        if not re.match(r'^[a-zA-Z0-9\s\.\-]+$', nome_busca):
            print("Nome inválido! O nome deve conter apenas letras, números, espaços, pontos ou hífens.")
            return False
        
        # Buscar entidades com LIKE
        entidades = self.trabalhador_service.buscar_entidades_por_nome(nome_busca)
        
        if not entidades:
            print(f"Nenhuma entidade encontrada com nome começando por '{nome_busca}'.")
            return False
        
        print(f"\nEntidades encontradas ({len(entidades)}):")
        for i, (cnes, nome, tipo) in enumerate(entidades, 1):
            print(f"{i}. {nome} ({tipo}) - CNES: {cnes}")
        
        try:
            escolha = int(input("\nEscolha o número da entidade: ").strip())
            if 1 <= escolha <= len(entidades):
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
                
                print(f"\n Turno iniciado com sucesso!")
                print(f"  Entidade: {nome_escolhido}")
                print(f"  ID do turno: {id_turno}")
                
                return self.menu_turno_ativo()
            else:
                print("✗ Opção inválida!")
                return False
        except ValueError:
            print("✗ Entrada inválida!")
            return False
        except Exception as e:
            print(f"✗ Erro ao iniciar turno: {e}")
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
            print(f"{i}. {nome} ({tipo}) - Registro MS: {registro_ms}")
        
        try:
            # Escolher recurso
            escolha = int(input("\nEscolha o número do recurso: ").strip())
            if not (1 <= escolha <= len(recursos)):
                print("Opção inválida!")
                return
            
            recurso_escolhido = recursos[escolha - 1]
            registro_ms = recurso_escolhido[0]
            nome_recurso = recurso_escolhido[1]
            
            # Quantidade
            quantidade = int(input("Quantidade solicitada: ").strip())
            if quantidade <= 0:
                print("Quantidade deve ser maior que zero!")
                return
            
            # Urgência
            print("\nNível de urgência:")
            print("1 - BAIXA")
            print("2 - MEDIA")
            print("3 - EXTREMA")
            urgencia_opt = input("Escolha (1, 2 ou 3): ").strip()
            
            urgencia_map = {'1': 'BAIXA', '2': 'MEDIA', '3': 'EXTREMA'}
            urgencia = urgencia_map.get(urgencia_opt, 'BAIXA')
            
            # Justificativa
            justificativa = input("\nJustificativa (opcional, pressione Enter para pular): ").strip()
            justificativa = justificativa if justificativa else None
            
            # Criar pedido com transação
            with self.db.transaction():
                id_pedido = self.pedido_service.criar_pedido(
                    self.turno_atual['id'],
                    registro_ms,
                    quantidade,
                    urgencia,
                    justificativa
                )
            
            print(f"\nPedido criado com sucesso!")
            print(f"  ID do pedido: {id_pedido}")
            print(f"  Recurso: {nome_recurso}")
            print(f"  Quantidade: {quantidade}")
            print(f"  Urgência: {urgencia}")
            
        except ValueError:
            print("Entrada inválida!")
        except Exception as e:
            print(f"Erro ao criar pedido: {e}")
    
    def passo4_finalizar_turno(self) -> bool:
        """
        PASSO 4: Finalizar o turno atual.
        """
        print("\n" + "=" * 60)
        print("PASSO 4: FINALIZAR TURNO")
        print("=" * 60)
        
        print("\nTem certeza que deseja finalizar o turno?")
        print("1 - Sim")
        print("2 - Não")
        
        opcao = input("\nEscolha uma opção: ").strip()
        
        if opcao == '1':
            try:
                # Finalizar turno com transação
                with self.db.transaction():
                    self.trabalhador_service.finalizar_turno(self.turno_atual['id'])
                
                print(f"\n✓ Turno finalizado com sucesso!")
                print(f"  ID do turno: {self.turno_atual['id']}")
                print(f"  Entidade: {self.turno_atual['nome_entidade']}")
                
                # Mostrar pedidos feitos durante o turno
                pedidos = self.pedido_service.listar_pedidos_turno(self.turno_atual['id'])
                if pedidos:
                    print(f"\n  Total de pedidos realizados: {len(pedidos)}")
                    for i, pedido in enumerate(pedidos, 1):
                        print(f"    {i}. {pedido[2]} - Qtd: {pedido[3]} - Urgência: {pedido[4]}")
                
                self.turno_atual = None
                print("\n✓ Sessão encerrada.")
                return True
                
            except Exception as e:
                print(f"✗ Erro ao finalizar turno: {e}")
                return False
        else:
            print("\nTurno não finalizado.")
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
