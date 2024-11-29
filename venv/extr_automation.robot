*** Settings ***
Library           SeleniumLibrary

*** Variables ***
${BROWSER}        Edge
${URL}            https://www.google.com

*** Test Cases ***
Open Google Chrome
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Title Should Be    Google
    Sleep               30s
    Close Browser
