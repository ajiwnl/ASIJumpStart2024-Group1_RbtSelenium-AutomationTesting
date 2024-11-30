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
${categoryTitle}         Food Expense
${dupeCategoryTitle}     Transportation
${newCategoryTitle}      Transpo
${catSuccessMsg}         Category added successfully!
${dupeCatMsg}            A category with this title already exists.
${catFldRequired}        Category title is required.
${TOAST_XPATH}        //div[contains(@class, 'toast-message')]






*** Keywords ***
Open Browser Session
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Sleep           2s

Close Browser Session
    Close Browser

*** Test Cases ***

Test Case 1 EXTR Navigation
    [Documentation]    Test navigation and browser responsiveness
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

Test Cases 4 Add Category, Field Validation and Duplicate Check

    # Adding category
    Input Text              //*[@id="category-input"]   ${categoryTitle}
    Click Button            //*[@id="addCategory"]
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          ${catSuccessMsg}
    Sleep                   2s

    # Category title is required
    Click Button            //*[@id="addCategory"]
    Page Should Contain     ${catFldRequired}
    Sleep                   2s

    # Duplicate category check
    Input Text              //*[@id="category-input"]   ${dupeCategoryTitle}
    Click Button            //*[@id="addCategory"]
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          ${dupeCatMsg}
    Sleep                   2s

Test Case 5 Edit and Delete Category
    Click Button            ${dupeCategoryTitle}
    Input Text              //*[@id="editCategoryTitle"]    ${newCategoryTitle}
    Click Button            Save Changes
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Category updated successfully!
    Sleep                   2s
    Click Button            ${newCategoryTitle}
    Click Button            Delete
    Sleep                   2s
    Click Button            Yes, delete it!
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Category deleted successfully.
    Sleep                   2s



Test Case X Responsive check
# Responsive check - Tablet
    Set Window Size      768    1024    # Width and height for tablet screen size
    Sleep                2s
    Page Should Contain Element   //*[@id="loginnavbtn"]
    Page Should Contain Element   //*[@id="regnavbtn"]
    Sleep                2s

    # Responsive check - Mobile
    Set Window Size      375    667    # Width and height for mobile screen size
    Sleep                2s
    Page Should Contain Element   //*[@id="loginnavbtn"]
    Page Should Contain Element   //*[@id="regnavbtn"]
    Sleep                2s

    # Return to default size
    Maximize Browser Window
    Sleep                2s




