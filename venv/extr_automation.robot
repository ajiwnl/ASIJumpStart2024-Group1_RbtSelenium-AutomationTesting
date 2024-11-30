*** Settings ***
Library           SeleniumLibrary
Suite Setup       Open Browser Session
Suite Teardown    Close Browser Session

*** Variables ***
${BROWSER}          Edge
${URL}              https://localhost:60648/
${username1}         whyiamhated
${password1}         asdasdasd
${username2}         arya
${password2}         123456
${username3}         aiahtot
${password3}         12121212

*** Keywords ***

Open Browser Session
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep           2s

Close Browser Session
    Close Browser

*** Test Cases ***

Test Case 1 EXTR Navigation
    Sleep               2s
    Click Element       //*[@id="loginnavbtn"]
    Sleep               2s
    Click Element       //*[@id="regnavbtn"]
    Sleep               2s
    Click Element       //*[@id="tologinnav"]
    Sleep               2s
    Click Element       //*[@id="tofpassnav"]
    Sleep               2s
    Click Element       //*[@id="goBack"]
    Sleep               2s

Test Case 2 EXTR Login
    Input Text          //*[@id="usernameInput"]    ${username2}
    Input Text          //*[@id="passwordInput"]    ${password1}
    Sleep               2s
    Click Element       //*[@id="loginBtn"]
    Sleep               2s
    Input Text          //*[@id="usernameInput"]    ${username1}
    Input Text          //*[@id="passwordInput"]    ${password3}
    Sleep               2s
    Click Element       //*[@id="loginBtn"]
    Sleep               2s
    Input Text          //*[@id="usernameInput"]    ${username3}
    Input Text          //*[@id="passwordInput"]    ${password2}
    Sleep               2s
    Click Element       //*[@id="loginBtn"]
    Sleep               2s
    Input Text          //*[@id="usernameInput"]    ${username2}
    Input Text          //*[@id="passwordInput"]    ${password2}
    Sleep               2s
    Click Element       //*[@id="loginBtn"]
    Sleep               2s

Test Case 3 Dashboard Navigation
    Click Element       //*[@id="sumanalytics"]
    Sleep               2s
    Click Element       //*[@id="catdetails"]
    Sleep               2s
    Click Element       //*[@id="expdetails"]
    Sleep               2s
    Click Element       //*[@id="settings"]
    Sleep               2s
    Click Element       //*[@id="catdetails"]
    Sleep               2s
