*** Settings ***
Resource  ../resources/api_testing_usuarios.resource

*** Variables ***

*** Test Cases ***
Cenário 01: Cadastrar um novo usuário com sucesso no ServeRest
    Criar um novo usuário
    # Cadastrar o usuário criado no ServeRest
    # Conferir se o usuário foi cadastrado corretamente