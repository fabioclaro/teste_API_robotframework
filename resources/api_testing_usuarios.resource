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
    ${bory}  Create Dictionary  
   ...     nome=Tifulano da Silva
   ...     email=${EMAIL_TEST} 
   ...     password=1234
   ...     administrador=true
   
   Criar sessão na ServeRest

   ${resposta}   POST On Session
   ...    alias=ServeRest
   ...    url=/usuarios
   ...    json=${bory}
   
   Log    ${resposta.json()} 
   Set Test Variable    ${RESPOSTA}   ${resposta.json()}  


Criar sessão na ServeRest
    ${headers}  Create Dictionary   accept=application/json   Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Conferir se o usuário foi cadastrado corretamente
    Log   ${RESPOSTA}
    Dictionary Should Contain Item   ${RESPOSTA}   message   Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${RESPOSTA}    _id



