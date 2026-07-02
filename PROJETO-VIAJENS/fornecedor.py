#main a entrada principal do sistema.
#inicia o sistema.
#chama funções.

from database import conectar

def listar_fornecedores():   
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para selecionar todos os registros da tabela "fornecedor"
    sql = """
    select
        f.id_fornecedor,
        f.nome,
        f.cnpj
    from fornecedor f
    """
    #executar a consulta SQL
    cursor.execute(sql)

    #recuperar os resultados da consulta
    dados = cursor.fetchall()

    #exibir os resultados
    for fornecedor in dados:
        print(fornecedor)

    #exibir os resultados
    for fornecedor in dados:
        print(fornecedor)

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def cadastrar_fornecedor(nome, cnpj):

    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para inserir um novo registro na tabela "fornecedor"
    sql = """
    insert into fornecedor (nome, cnpj)
    values (%s, %s)
    """
    valores = (nome, cnpj)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Fornecedor {nome} cadastrado com sucesso!")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def atualizar_cnpj_fornecedor(id_fornecedor, novo_cnpj):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para atualizar o cnpj de um fornecedor
    sql = """
    update fornecedor
    set cnpj = %s
    where id_fornecedor = %s
    """
    valores = (novo_cnpj, id_fornecedor)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"CNPJ do fornecedor com ID {id_fornecedor} atualizado para {novo_cnpj}.")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()

def deletar_fornecedor(id_fornecedor):
    #conectar ao banco de dados
    conexao = conectar()

    #criar um cursor para executar comandos SQL
    cursor = conexao.cursor()

    #executar uma consulta SQL para deletar um fornecedor
    sql = """
    delete from fornecedor
    where id_fornecedor = %s
    """
    valores = (id_fornecedor,)
    cursor.execute(sql, valores)

    #confirmar a transação
    conexao.commit()
    print(f"Fornecedor com ID {id_fornecedor} deletado com sucesso.")

    #fechar o cursor e a conexão com o banco de dados
    cursor.close()
    conexao.close()