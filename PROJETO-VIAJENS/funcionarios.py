#main a entrada principal do sistema.
#inicia o sistema.
#chama funções.

from database import conectar

def listar_funcionarios():
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para selecionar todos os registros da tabela "funcionario"
    sql = """
    select
        f.id_funcionario,
        f.nome,
        f.cargo,
        d.nome as setor
    from funcionario f
    join setor d on f.id_setor = d.id_setor
    """
    #executar a consulta SQL
    cursor.execute(sql)

    #recuperar os resultados da consulta
    dados = cursor.fetchall()

    #exibir os resultados
    for funcionario in dados:
        print(funcionario)

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def cadastrar_funcionario(nome, cargo, id_setor):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para inserir um novo registro na tabela "funcionario"
    sql = """
    insert into funcionario (nome, cargo, id_setor)
    values (%s, %s, %s)
    """
    valores = (nome, cargo, id_setor)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Funcionário {nome} cadastrado com sucesso!")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def atualizar_cargo_funcionario(id_funcionario, novo_cargo):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para atualizar o cargo de um funcionário
    sql = """
    update funcionario
    set cargo = %s
    where id_funcionario = %s
    """
    valores = (novo_cargo, id_funcionario)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Cargo do funcionário com ID {id_funcionario} atualizado para {novo_cargo}.")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()