*** Settings ***
Library    OperatingSystem
Library    CSVLibrary
Library    SeleniumLibrary
Library    ../resources/libraries/labrary.py
Library    Collections
Suite Setup     Open_Website    ${URL}      ${BROWSER}
Suite Teardown      Close_Website
Test Setup     Log    1212
Variables    ../resources/variables/variables.py
Resource    ../resources/keywords/Common.robot

*** Variables ***
${URL}      https://demoqa.com/elements
${CSV_PATH}       D:/housing.csv
${CSV_OUTPUT}     D:/test.csv

*** Test Cases ***
Reading CSV data and setting global variables
    Given I have read data from the CSV file "${CSV_PATH}"
    And I have calculated the length of the list
Adding items to the table from CSV data
    Given I am on the web page with the table
    When I add each item from the CSV to the table
Updating items in the table
    Given I am on the web page with the table
    When I update each item in the table
Writing data back to CSV
    Given I write the data to the CSV file "${CSV_OUTPUT}"
    Then I verify the CSV file is updated

*** Keywords ***
I have read data from the CSV file "${CSV_PATH}"
    @{list}=    Read Csv File To List    ${CSV_PATH}
    Set Global Variable    ${global_list}    ${list}
    ${length}=    Get Length    ${global_list}
    Set Global Variable    ${global_length}    ${length}

I have calculated the length of the list
    [Documentation]    This step calculates the length of the list and logs it.
    ${length}=    Get Length    ${global_list}
    Log    The length of the list is ${length}

I am on the web page with the table
    Click Element       xpath=(//li[@id='item-3'])[1]

I add each item from the CSV to the table
    FOR    ${index}    IN RANGE    1    ${global_length}
        ${item}=    Get From List    ${global_list}    ${index}
        Execute The Addition    ${item}
        Wait Two Second
        Verify each item is added correctly   ${item}
    END
Verify each item is added correctly
    [Arguments]    ${item}
    Input Text    id=searchBox      ${item}[0]
    Wait Until Element Is Visible    xpath=//div[normalize-space()='${item}[0]']
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[normalize-space()='${item}[0]']
    Should Be True    ${is_visible}    msg=Item '${item}[0]' was not added to the page
Verify each item is updated correctly
    [Arguments]    ${item}
    Input Text    id=searchBox      ${item}[0] Edit
    Wait Until Element Is Visible    xpath=//div[normalize-space()='${item}[0] Edit']
    ${is_visible}=    Run Keyword And Return Status    Element Should Be Visible    xpath=//div[normalize-space()='${item}[0] Edit']
    Should Be True    ${is_visible}    msg=Item '${item}[0]' was not update to the page
Execute The Addition
    [Arguments]    ${item}
    Wait Until Element Is Visible    xpath=//button[@id='addNewRecordButton']
    Click Button    xpath=//button[@id='addNewRecordButton']
    Input Text    id=firstName      ${item}[0]
    Input Text    id=lastName       ${item}[1]
    Input Text    id=userEmail      ${item}[2]
    Input Text    id=age            ${item}[3]
    Input Text    id=salary         ${item}[4]
    Input Text    id=department     ${item}[5]
    Click Button    xpath=//button[@id='submit']

I update each item in the table
    FOR    ${index}    IN RANGE    1    ${global_length}
        ${item}=    Get From List    ${global_list}    ${index}
        Execute The Update    ${item}
        Wait Two Second
        Verify each item is updated correctly   ${item}
    END

Execute The Update
    [Arguments]    ${item}
    Input Text    id=searchBox      ${item}[0]
    Wait Two Second
    Click Element       xpath=//span[@title='Edit']
    Input Text    id=firstName      ${item}[0] Edit
    Input Text    id=lastName       ${item}[1] Edit
    Input Text    id=userEmail      ${item}[2]
    Input Text    id=age            ${item}[3]
    Input Text    id=salary         ${item}[4]
    Input Text    id=department     ${item}[5] Edit
    Click Button    xpath=//button[@id='submit']

I write the data to the CSV file "${CSV_OUTPUT}"
    FOR    ${row}    IN    @{global_list}
        Append To Csv File    ${CSV_OUTPUT}    ${row}
    END

I verify the CSV file is updated
    [Documentation]    Verifies that the CSV file is updated with new data.
    File Should Exist    ${CSV_OUTPUT}

#
#Sigin web
#    Input Text      id=userNameBox    PHUONGTMAAdmin
#    Input Password  id=passWordBox    12345678x@X
#    Click Element    xpath=//a[@id='submit']
#TC1 web
#    Click Element    xpath=//i[@class='fa-icon-reorder']
#    Sleep    3s
#    Click Element    xpath=//a[@id='header_headerResponsive_responsiveNav_rptMenu_lnkMenu_1']
#    Sleep    3s
#    Click Element    xpath=//a[@id='header_headerResponsive_responsiveNav_rptMenu_rptSubMenu_1_lnkSubMenu_3']
#TC2 web
#    @{list}=   Read Csv File To List    D:/housing.csv
#    ${length}=    Get Length    ${list}
#    FOR    ${index}    IN RANGE    0    ${length}
#    ${item}=    Get From List     ${list}    ${index}
#    Sleep    3s
#    Click Element    xpath=(//a[@id='___________u'])[1]
#    Sleep    3s
#    Click Element    xpath=//input[@id='_____bd______er']
#    Sleep    3s
#    Input Text    xpath=//input[@id='_____bd_____cm_508']   ${item}[0]
#    Input Text    xpath=//textarea[@id='_____bd_____cp_508']    ${item}[1]
#    Sleep    3s
#    Click Element    xpath=//a[@id='_____bd_____dk']
#    Sleep    3s
#    Input Text    xpath=//input[@id='_____bd_____fe_bb_inp']    ${item}[2]
#    Sleep    3s
#    Click Element    xpath=//a[@title='Search']//i[@class='fa-icon-search']
#    Sleep    5s
#    ${test}=    Get Text    xpath=//a[@id='_____bd_____fe_bv_z0___o']
#    IF    '${item}[2]' == '${test}'
#        Sleep    3s
#        Click Element    xpath=(//input[@id='_____bd_____fe_bv_z0___i_508'])[1]
#    ELSE
#         Log    message
#    END
#    Sleep    2s
#    Click Element    xpath=//a[@id='_____bd_____fu']
#    Sleep    3s
#    Click Element    xpath=//a[@id='_____cl']
#    Sleep    3s
#    Click Element    xpath=//div[@id='_____be__a']//div[1]//fieldset[1]//label[1]//span[1]
#    Sleep    3s
#    Click Element    xpath=//label[@for='_____be__v_508']//span[1]
#    Sleep    3s
#    Click Element    xpath=//div[@id='_____be__y']//span[1]
#    Sleep    3s
#    Click Element    xpath=//input[@id='_____be_bv']
#    Sleep    3s
#    Click Element    xpath=//div[@id='_____be_by']//span[1]
#    Sleep    3s
#    Click Element    xpath=//input[@id='_____be_ct___bu_508']
#    Sleep    3s
#    Click Element    xpath=//input[@id='_____be_ct___bx_508']
#    Sleep    3s
#    Click Element    xpath=(//a[normalize-space()='Next'])[1]
#    Sleep    3s
#    Click Element    xpath=(//a[normalize-space()='Next'])[1]
#    Sleep    5s
#    Click Element    xpath=(//a[normalize-space()='Select Users'])[1]
#    Sleep    3s
#    Click Element    xpath=(//a[@title='Users'])[2]
#    Sleep    3s
#    Click Element    xpath=//span[normalize-space()='Group']
#    Sleep    3s
#    Input Text          xpath=//input[@id='_____bg______hc___bc_inp']      ${item}[3]
#    Sleep    3s
#    Click Element    xpath=//a[@id='_____bg______hc___bg']
#    Sleep    5s
#    ${test}=    Get Text    xpath=(//span[@id='_____bg______hc___ec0___n'])[1]
#    IF    '${item}[3]' == '${test}'
#        Sleep    3s
#        Click Element    xpath=(//input[@id='_____bg______hc___ec0___g_508'])[1]
#        Sleep    2s
#        Click Element    xpath=//a[@id='_____bg______hc___ev']
#        Sleep    3s
#        Click Element    xpath=(//a[normalize-space()='Generate Initial User List'])[1]
#        Sleep    3s
#        Click Element    xpath=(//a[normalize-space()='Next'])[1]
#        Sleep    4s
#        Click Element    xpath=//a[@id='_____et']
#        Sleep    3s
#        Click Element    xpath=//a[@id='_____co']
#        Sleep    4s
#        Click Element    xpath=(//a[normalize-space()='Yes'])[1]
#        Sleep    3s
#        Append To Csv File    D:/test.csv    ${item}
#        Log    success
#    ELSE
#         Fail    message
#    END
#    END