#CONEXÃO COM O BANCO 
#INSTALAR O DRIVE CONECTOR 
#MYSQLCONNECTOR
#O DRIVER É UM CONJUNTO DE FUNÇÕES QUE PERMITE A COMUNICAÇÃO ENTRE O BANCO DE DADOS E A APLICAÇÃO. (TRADUTOR)


import mysql.connector

def conectar():
    #conexão com o banco de dados.
    conexao = mysql.connector.connect(
        host='localhost',
        user='root',
        password='root',
        database='projetoindustrial',
        port = 3306
    )
    return conexao