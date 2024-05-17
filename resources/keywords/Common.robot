*** Settings ***
Library    SeleniumLibrary
Library    DateTime
Variables    ../resources/variables/variables.py
*** Keywords ***
Open_Website
    [Arguments]     ${URL}      ${BROWSER}
    [Documentation]     mở trang website  https://gabi-spa.vercel.app
    Open Browser    ${URL}      ${BROWSER}
    Maximize Browser Window
Close_Website
    [Documentation]      đóng Browser
    Sleep    5s
    Close Browser
Sin In Website
    [Documentation]      đăng nhập vào web
    [Arguments]     ${USERNAME}      ${PASSWORD}
    Click Element    xpath=${XPATH_LOGIN}
    Input Text      id=email    ${USERNAME}
    Input Password  id=password    ${PASSWORD}
    Click Element    xpath=${XPATH_SUBMIT}
Current_Date
    ${current_date}=    Get Current Date    result_format=%m-%d-00%YT%H:%M%p
    Return From Keyword  ${current_date}
Wait Two Second
    Sleep    2s