*** Settings ***
Library   RequestsLibrary
Library   String

*** Keywords ***
Criar um novo usuário
    ${palavra_aleatoria}   Generate Random String   length=4  chars=[LETTERS]
    ${palavra_aleatoria}   Convert To Lower Case    ${palavra_aleatoria} 
    Set Test Variable      ${EMAIL_TEST}            ${palavra_aleatoria}@emailteste.com
    Log To Console         ${EMAIL_TEST} 