""" comandos para testar as funções do módulo funcionarios.py
from funcionarios import listar_funcionarios
from funcionarios import cadastrar_funcionario
from funcionarios import atualizar_cargo_funcionario
from funcionarios import deletar_funcionario

listar_funcionarios()
cadastrar_funcionario("João Silva", "Analista de Sistemas", 1)
atualizar_cargo_funcionario(1, "Gerente de TI")
deletar_funcionario(1)
"""

""" comandos para testar as funções do módulo fornecedor.py
from fornecedor import listar_fornecedores
from fornecedor import cadastrar_fornecedor
from fornecedor import atualizar_cnpj_fornecedor
from fornecedor import deletar_fornecedor

listar_fornecedores()
cadastrar_fornecedor("Fornecedor XYZ", "12.345.678/0001-90")
atualizar_cnpj_fornecedor(1, "98.765.432/0001-10")
deletar_fornecedor(1)
"""
""" comandos para testar as funções do módulo setor.py
from setor import listar_setores
from setor import cadastrar_setor
from setor import atualizar_setor
from setor import deletar_setor

listar_setores()
cadastrar_setor("Setor de Marketing")
atualizar_setor(1, "Setor de Vendas")
deletar_setor(1)
"""