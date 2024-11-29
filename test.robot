*** Settings ***
Documentation   Student Form
Library         SeleniumLibrary

*** Variables ***
@{student_ids}          121212121   23232323   343434343   45454545   56565656   76767676   78787878   8989898   9090909
@{last_names}           Smith   Jones   Doe   Johnson   Brown   Davis   Miller   Wilson   Moore   Taylor
@{middle_names}         James   Lee   Patrick   Michael   Elizabeth   Ann   William   Joseph   Katherine   Christopher
@{first_names}          John    Jane    Robert   Emily   Benjamin   Olivia   Liam   Sophia   Ethan   Ava
@{courses}              BSIT    BSIS    BSCPE    BSN    BSCRIM
@{years}                1st     2nd     3rd     4th
@{remarks}              SHIFTEE     TRANSFEREE      NEW     OLD     CROSS-ENROLLEE
${student_id_from_previous_test}
${last_name_from_previous_test}
${middle_name_from_previous_test}
${first_name_from_previous_test}
${course_from_previous_test}
${year_from_previous_test}
${remark_from_previous_test}
${Student_Entry}     xpath://a[contains(text(), 'STUDENT ENTRY')]
${Add_Student}       xpath://a[contains(text(), 'ADD STUDENT')]
${Browser}           edge

*** Keywords ***
Hover Over Nav Bar
    ${student_entry}  Get WebElement  ${Student_Entry}
    Mouse Over  ${student_entry}

Click Student Entry
    ${student_entry}  Get WebElement  ${Student_Entry}
    Click Element  ${student_entry}

Click Add Student
    ${add_student}  Get WebElement  ${Add_Student}
    Click Element  ${add_student}

*** Test Cases ***

Test Case 1 Navigate the Nav Bar
    [Documentation]         Highlight when the Cursor is in Hover
     Open Browser                http://www.martianuniversity.somee.com/    ${Browser}
     Maximize Browser Window
     Hover Over Nav Bar
     Sleep    2s
     Close Browser

Test Case 2 Click the Student Entry Button
    [Documentation]         It will will drop down and have contents the student list and add student
    Open Browser                http://www.martianuniversity.somee.com/    ${Browser}
    Maximize Browser Window
    Click Student Entry
    Close Browser

Test Case 3 Click the Add Student Button
    [Documentation]         It will show the add student page
    Open Browser                http://www.martianuniversity.somee.com/    ${Browser}
    Maximize Browser Window
    Click Student Entry
    Sleep    1s
    Click Add Student
    Sleep    1s
    Page Should Contain    ID N0
    Sleep    2s
    Close Browser

Test Case 4 to 11
    [Documentation]         Expecting Succession Of Saving Student Entry Information and Redirect to Student List

    ${random_student_id}    Evaluate    random.choice($student_ids)
    ${random_last_name}     Evaluate    random.choice($last_names)
    ${random_middle_name}   Evaluate    random.choice($middle_names)
    ${random_first_name}    Evaluate    random.choice($first_names)
    ${random_course}        Evaluate    random.choice($courses)
    ${random_year}          Evaluate    random.choice($years)
    ${random_remark}        Evaluate    random.choice($remarks)
    Set Suite Variable    ${student_id_from_previous_test}      ${random_student_id}
    Set Suite Variable    ${last_name_from_previous_test}       ${random_last_name}
    Set Suite Variable    ${middle_name_from_previous_test}     ${random_middle_name}
    Set Suite Variable    ${first_name_from_previous_test}      ${random_first_name}
    Set Suite Variable    ${course_from_previous_test}          ${random_course}
    Set Suite Variable    ${year_from_previous_test}            ${random_year}
    Set Suite Variable    ${remark_from_previous_test}          ${random_remark}

    Open Browser                http://www.martianuniversity.somee.com/Student/Add  ${Browser}
    Maximize Browser Window
    Input Text                  //*[@name="STFSTUDID"]          ${random_student_id}
    Sleep    1s
    Input Text                  //*[@name="STFSTUDLNAME"]       ${random_last_name}
    Sleep    1s
    Input Text                  //*[@name="STFSTUDFNAME"]       ${random_first_name}
    Sleep    1s
    Input Text                  //*[@name="STFSTUDMNAME"]       ${random_middle_name}
    Sleep    1s
    Execute JavaScript          window.scrollTo(0, document.querySelector('[value="Submit"]').getBoundingClientRect().top)
    Sleep                       1s
    Click Element               //*[@name="STFSTUDCOURSE"]
    Sleep    1s
    Click Element               //*[contains(text(), '${random_course}')]
    Sleep    1s
    Click Element               //*[@name="STFSTUDYEAR"]
    Sleep    1s
    Click Element               //*[contains(text(), '${random_year}')]
    Sleep    1s
    Click Element               //*[@name="STFSTUDREMARKS"]
    Sleep    1s
    Click Element               //*[contains(text(), '${random_remark}')]
    Execute JavaScript          window.scrollTo(0, document.querySelector('[value="Submit"]').getBoundingClientRect().top)
    Sleep                       1s
    Click Button                //*[@value="Submit"]
    Page Should Contain         Succes
    Execute JavaScript        Swal.close()
    Go To                     http://www.martianuniversity.somee.com/Student
    Sleep    2s
    Close Browser

Cancelling Inputted Entries On Student Form (Added by the Tester)
    [Documentation]             Expecting Clearing Input Fields Of Student Entry Form

    Open Browser                http://www.martianuniversity.somee.com/Student/Add  ${Browser}
    Maximize Browser Window
    Input Text                  //*[@name="STFSTUDID"]          ${student_id_from_previous_test}
    Input Text                  //*[@name="STFSTUDLNAME"]       ${last_name_from_previous_test}
    Input Text                  //*[@name="STFSTUDFNAME"]       ${first_name_from_previous_test}
    Input Text                  //*[@name="STFSTUDMNAME"]       ${middle_name_from_previous_test}
    Execute JavaScript          window.scrollTo(0, document.querySelector('[value="Submit"]').getBoundingClientRect().top)
    Sleep                       1s
    Click Element               //*[@name="STFSTUDCOURSE"]
    Click Element               //*[contains(text(), '${course_from_previous_test}')]
    Click Element               //*[@name="STFSTUDYEAR"]
    Click Element               //*[contains(text(), '${year_from_previous_test}')]
    Click Element               //*[@name="STFSTUDREMARKS"]
    Click Element               //*[contains(text(), '${remark_from_previous_test}')]
    Reload Page
    Page Should Contain         ADD STUDENT
    Close Browser

Attempting To Create Student Information With No Entries On Fields (Added by the Tester)
    [Documentation]             Expecting Denial Of Submitting And Display Required Warnings

    Open Browser                http://www.martianuniversity.somee.com/Student/Add  ${Browser}
    Maximize Browser Window
    Execute JavaScript          window.scrollTo(0, document.querySelector('[value="Submit"]').getBoundingClientRect().top)
    Sleep                       1s
    Click Button                //*[@value="Submit"]
    Page Should Contain         Required!
    Close Browser

Attempting To Create Another Existing Student Information (Added by the Tester)
    [Documentation]             Expecting Validation To Trigger Duplicate Entry Error

    Open Browser                http://www.martianuniversity.somee.com/Student/Add  ${Browser}
    Maximize Browser Window
    Input Text                  //*[@name="STFSTUDID"]          ${student_id_from_previous_test}
    Input Text                  //*[@name="STFSTUDLNAME"]       ${last_name_from_previous_test}
    Input Text                  //*[@name="STFSTUDFNAME"]       ${first_name_from_previous_test}
    Input Text                  //*[@name="STFSTUDMNAME"]       ${middle_name_from_previous_test}
    Execute JavaScript          window.scrollTo(0, document.querySelector('[value="Submit"]').getBoundingClientRect().top)
    Sleep                       1s
    Click Element               //*[@name="STFSTUDCOURSE"]
    Click Element               //*[contains(text(), '${course_from_previous_test}')]
    Click Element               //*[@name="STFSTUDYEAR"]
    Click Element               //*[contains(text(), '${year_from_previous_test}')]
    Click Element               //*[@name="STFSTUDREMARKS"]
    Click Element               //*[contains(text(), '${remark_from_previous_test}')]
    Execute JavaScript          window.scrollTo(0, document.querySelector('[value="Submit"]').getBoundingClientRect().top)
    Sleep                       1s
    Click Button                //*[@value="Submit"]
    Page Should Contain         Error!
    Close Browser