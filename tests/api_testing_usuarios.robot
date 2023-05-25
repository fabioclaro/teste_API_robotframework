*** Settings ***
Resource  ../resources/api_testing_usuarios.resource

*** Variables ***

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso no ServeRest
    Criar um novo usuário
    Cadastrar o usuário criado no ServeRest     email=${EMAIL_TEST}   status_code_desejado=201
    Conferir se o usuário foi cadastrado corretamente

Cenário 02: Cadastrar um usuário já existente
    Criar um novo usuário
    Cadastrar o usuário criado no ServeRest      email=${EMAIL_TEST}   status_code_desejado=201
    Vou repetir o cadastro do usuário
    Verificar se a API não permitiu o cadastro repetido

Cenário 03: Consultar os dados de um novo usuário
    Criar um novo usuário
    Cadastrar o usuário criado no ServeRest    email=${EMAIL_TEST}   status_code_desejado=201
    Consultar os dados do novo usuário
    Conferir os dados retornados

Cenário 04: Logar com o novo usuário criado
    Criar um novo usuário
    Cadastrar o usuário criado no ServeRest    email=${EMAIL_TEST}   status_code_desejado=201
    Realizar Login com o usuário
    Conferir se o Login ocorreu com sucesso