def listar_setores():
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para selecionar todos os registros da tabela "funcionario"
    sql = """
    select
        s.id_setor,
        s.nome as setor
    from setor s
    """
    #executar a consulta SQL
    cursor.execute(sql)

    #recuperar os resultados da consulta
    dados = cursor.fetchall()

    #exibir os resultados
    for setor in dados:
        print(setor)

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def cadastrar_setor(nome):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para inserir um novo registro na tabela "setor"
    sql = """
    insert into setor (nome)
    values (%s)
    """
    valores = (nome,)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Setor {nome} cadastrado com sucesso!")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def atualizar_setor(id_setor, novo_nome):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para atualizar o nome de um setor
    sql = """
    update setor
    set nome = %s
    where id_setor = %s
    """
    valores = (novo_nome, id_setor)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Setor com ID {id_setor} atualizado para {novo_nome}.")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def deletar_setor(id_setor):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para deletar um setor
    sql = """
    delete from setor
    where id_setor = %s
    """
    valores = (id_setor,)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Setor com ID {id_setor} deletado com sucesso.")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()