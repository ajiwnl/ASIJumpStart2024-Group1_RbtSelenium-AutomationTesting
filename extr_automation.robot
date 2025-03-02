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
    Click Element       //*[@id="walletdetails"]
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
    Sleep                   1s
    Click Button            //*[@id="addCategory"]
    Sleep                   2s
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
    Sleep                   1s
    Click Button            //*[@id="addCategory"]
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          ${dupeCatMsg}
    Sleep                   2s

Test Case 5 Edit and Delete Category
    # Edit Category
    Click Button            ${dupeCategoryTitle}
    Input Text              //*[@id="editCategoryTitle"]    ${newCategoryTitle}
    Click Button            Save Changes
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Category updated successfully!
    Sleep                   2s

    # Delete Category
    Click Button            ${newCategoryTitle}
    Click Button            Delete
    Sleep                   2s
    Click Button            Yes, delete it!
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Category deleted successfully.
    Sleep                   2s

Test Case 6 Add, Validated input fields, and Wallet Validation
    # Validate input fields
    Click Element           //*[@id="expdetails"]
    Title Should Be         Expense
    Click Button            //*[@id="submitBtn"]
    Page Should Contain     Expense Name is required.
    Page Should Contain     Date is required.
    Sleep                   2s

    #Add Expense
    Select From List By Label    //*[@id="categoryInput"]    Bills Expense
    Sleep                   1s
    Input Text                  //*[@id="expenseInput"]      Internet
    Sleep                   1s
    Input Text                   //*[@id="amountInput"]       1500
    Sleep                   1s
    Input Text                  //*[@id="dateInput"]          11-30-2024
    Sleep                   1s
    Input Text                  //*[@id="descriptionInput"]   Billing for this month
    Sleep                   1s
    Click Button                //*[@id="submitBtn"]
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Expense added successfully!
    Sleep                   2s
    Click Element           //*[@id="catdetails"]
    Page Should Contain     Internet
    Sleep                   2s

    #Wallet balance check
    Click Element           //*[@id="expdetails"]
    Sleep                   1s
    Select From List By Label    //*[@id="categoryInput"]    Food Expense
    Sleep                        1s
    Input Text                  //*[@id="expenseInput"]      Breakfast meal
    Sleep                        1s
    Input Text                   //*[@id="amountInput"]      150
    Sleep                        1s
    Input Text                  //*[@id="dateInput"]         11-30-2024
    Sleep                        1s
    Input Text                  //*[@id="descriptionInput"]  Food budget
    Sleep                        1s
    Click Button                //*[@id="submitBtn"]
    Sleep                       2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          An error occurred while adding the expense. Verify your wallet balance
    Sleep                   2s
    Click Element           //*[@id="catdetails"]
    Sleep                   2s

    #Add Wallet
    Click Element           //*[@id="walletdetails"]
    Sleep                   1s
    Page Should Contain     Add Funds
    Click Button            //*[@id="addFunds"]
    Sleep                   1s
    Select From List By Label    //*[@id="categorySelect"]    Food Expense
    Sleep                   1s
    Input Text              //*[@id="amountInput"]            1500
    Sleep                   1s
    Click Button           Add Funds
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Successfully added ₱1,500.00 to budget
    Sleep                   2s

    #Add new expense for food Expense category
    Click Element           //*[@id="expdetails"]
    Sleep                   1s
    Select From List By Label    //*[@id="categoryInput"]    Food Expense
    Sleep                        1s
    Input Text                  //*[@id="expenseInput"]      Breakfast meal
    Sleep                        1s
    Input Text                   //*[@id="amountInput"]      150
    Sleep                        1s
    Input Text                  //*[@id="dateInput"]         12-01-2024
    Sleep                        1s
    Input Text                  //*[@id="descriptionInput"]  Food budget
    Sleep                        1s
    Click Button                //*[@id="submitBtn"]
    Sleep                       2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Expense added successfully!
    Sleep                   2s
    Click Element           //*[@id="catdetails"]
    Sleep                   2s

Test Case 7 Edit and Delete of Expense
    # Delete Expense
    Page Should Contain     Category Management
    Click Button            //tr[td[text()="Internet"]]//button[contains(@id, "deleteExpense")]
    Sleep                   2s
    Click Button            Yes, delete it!
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Expense deleted successfully!
    Sleep                   2s

    # Edit Expense
    Click Button            //tr[td[text()="Kuryente"]]//button[contains(@id, "editExpense")]
    Input Text              //*[@id="description"]      VECO billing partial
    Click Button            Save
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Expense updated successfully!
    Sleep                   2s

Test Case 8 Analytics Display
    # Analytics Display
    Click Element           //*[@id="sumanalytics"]
    Title Should Be         Summary
    Click Button            //*[@id="allBtn"]
    Sleep                   2s
    Click Button            //*[@id="todayBtn"]
    Sleep                   2s
    Click Button            //*[@id="weekBtn"]
    Sleep                   2s
    Click Button            //*[@id="monthBtn"]
    Sleep                   2s
    Select From List By Label    //*[@id="categoryBtn"]    Food Expense
    Page Should Contain          Breakfast meal
    Sleep                   2s
    Input Text                  //*[@id="startDate"]         11-01-2024
    Sleep                        1s
    Input Text                  //*[@id="endDate"]           11-30-2024
    Sleep                   2s

Test Case 9 Settings and Pref Management
    # Change Username
    Click Element           //*[@id="settings"]
    Title Should Be         Settings
    Sleep                   2s
    Click Button            //*[@id="newUNEditButton"]
    Sleep                   1s
    Input Text              //*[@id="usernameInput"]       capstone
    Sleep                   1s
    Click Button            //*[@id="newUNSubmitButton"]
    Sleep                   2s
    Wait Until Element Is Visible    ${TOAST_XPATH}    timeout=5s
    ${toast_message}=       Get Text                  ${TOAST_XPATH}
    Should Be Equal         ${toast_message}          Username updated successfully!
    Sleep                   2s
    Click Element           //*[@id="sumanalytics"]
    Sleep                   2s
    Title Should Be         Summary
    Click Button             //*[@id="logout"]
    Input Text          //*[@id="usernameInput"]    capstone
    Input Text          //*[@id="passwordInput"]    123456
    Sleep               2s
    Click Element       //*[@id="loginBtn"]
    Sleep               2s
    Title Should Be         Summary
    Click Button             //*[@id="logout"]
    Sleep                   2s


Test Case 10 Screen Responsiveness
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






















