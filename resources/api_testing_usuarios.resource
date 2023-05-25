*** Settings ***
Library   RequestsLibrary
Library   String
Library    Collections

*** Keywords ***
Criar um novo usuário
    ${palavra_aleatoria}   Generate Random String   length=4  chars=[LETTERS]
    ${palavra_aleatoria}   Convert To Lower Case    ${palavra_aleatoria} 
    Set Test Variable      ${EMAIL_TEST}            ${palavra_aleatoria}@emailteste.com
    Log To Console         ${EMAIL_TEST} 

Cadastrar o usuário criado no ServeRest
    [Arguments]  ${email}   ${status_code_desejado}
    ${bory}  Create Dictionary  
   ...     nome=Tifulano da Silva
   ...     email=${email}
   ...     password=1234
   ...     administrador=true
   
   Criar sessão na ServeRest

    ${resposta}   POST On Session
    ...    alias=ServeRest
    ...    url=/usuarios
    ...    json=${bory}
    ...    expected_status=${status_code_desejado}
   
   Log    ${resposta.json()} 

   IF    ${resposta.status_code} == 201
         Set Test Variable    ${ID_USUARIO}   ${resposta.json()["_id"]}        
   END
   
   Set Test Variable    ${RESPOSTA}     ${resposta.json()}  


Criar sessão na ServeRest
    ${headers}  Create Dictionary   accept=application/json   Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    Log   ${RESPOSTA}
    Dictionary Should Contain Item   ${RESPOSTA}   message   Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id

Vou repetir o cadastro do usuário
    Cadastrar o usuário criado no ServeRest   email=${EMAIL_TEST}   status_code_desejado=400 

Verificar se a API não permitiu o cadastro repetido
    Dictionary Should Contain Item   ${RESPOSTA}   message    Este email já está sendo usado

Consultar os dados do novo usuário
    ${resposta_consulta}  GET On Session   alias=ServeRest   url=/usuarios/${ID_USUARIO}   expected_status=200
    Set Test Variable    ${RESP_CONSULTA}   ${resposta_consulta.json()}                 

Conferir os dados retornados
    Log    ${RESP_CONSULTA}
    Dictionary Should Contain Item    ${RESP_CONSULTA}    nome             Tifulano da Silva
    Dictionary Should Contain Item    ${RESP_CONSULTA}    email            ${EMAIL_TEST}    
    Dictionary Should Contain Item    ${RESP_CONSULTA}    password         1234  
    Dictionary Should Contain Item    ${RESP_CONSULTA}    administrador    true   
    Dictionary Should Contain Item    ${RESP_CONSULTA}    _id              ${ID_USUARIO}     

Realizar Login com o usuário
    ${bory}  Create Dictionary
    ...   email=${EMAIL_TEST}
    ...   password=1234
    
    Criar sessão na ServeRest

    ${resposta}   POST On Session
   ...    alias=ServeRest
   ...    url=/login
   ...    json=${bory}
   ...    expected_status=200
   

   Set Test Variable     ${resposta}    ${resposta.json()}  

 Conferir se o Login ocorreu com sucesso
    Log    ${resposta}
    Dictionary Should Contain Item   ${RESPOSTA}   message   Login realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}   authorization

