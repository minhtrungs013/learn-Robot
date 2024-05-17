*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library           DateTime
#Suite Setup     Sin In
#Suite Teardown      Close_Website
Test Setup     Log    1212
Variables    ../resources/variables/variables.py
Resource    ../resources/keywords/Common.robot
# dùng để set thời gian tối đa của 1 test case nếu vượt quá sẽ xảy ra lỗi cho test case đó nhưng hông ảnh hưởng quá trình chạy của hệ thống
#Test Timeout    2s
*** Variables ***
${API_URL}      https://api-gabispa-c2nd.onrender.com
${Path_Login}   auth/sign-in
&{task_details}    name=Example Task    description=This is an example task    object=Mẹ mang thai   workingTimePerDay=1
${username}     minhtrung
${password}     123123Aa.
${usernameEdit}     minhtrungadmin
${passwordEdit}     123123Aa.
*** Test Cases ***
TC1: Book service fails when the role has no access permissions
    [Documentation]     Verify that booking service fails when the role has no access permissions
    [Tags]      Function    high
    Given I have a valid access token by logging in with the account "${username}" and "${password}"
    When I attempt to create a task with the following details      &{task_details}
    Then the creation should fail with status code "403"
TC2: Task has already been used by username
    [Documentation]     Verify that an error is returned when the task name has already been used
    [Tags]      Function    high
    Given I have a valid access token by logging in with the account "${usernameEdit}" and "${passwordEdit}"
    When I attempt to create a task with the following details      &{task_details}
    Then the creation should fail with status code 409 and error message "Task has already been used by username: Example Task"
TC3: Book service successfully
    Given I have a valid access token by logging in with the account "${usernameEdit}" and "${passwordEdit}"
    &{task_details}=    Create Dictionary    name=Example Task new1   description=This is an example task    object=Mẹ mang thai   workingTimePerDay=1
    When I attempt to create a task with the following details      &{task_details}
    Then the creation should fail with status code "200"
*** Keywords ***
I have a valid access token by logging in with the account "${username}" and "${password}"
    Create Session    myapi    ${API_URL}    verify=${False}
    &{headers}=    Create Dictionary    Content-Type=application/json
    &{data}=    Create Dictionary    username=${username}    password=${password}
    ${response}=    Post Request    myapi    /api/v1/auth/sign-in    data=${data}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    202
    ${body}=    Set Variable    ${response.json()}
    ${access_token}=    Set Variable    ${body['data']['tokens']['accessToken']}
    Set Global Variable    ${access_token}

I attempt to create a task with the following details
    [Arguments]    &{task_details}
    &{headers}=    Create Dictionary    Content-Type=application/json    Authorization=Bearer ${access_token}
    ${task_details['workingTimePerDay']}=    Convert To Integer    ${task_details['workingTimePerDay']}
    &{converted_task_details}=    Create Dictionary    name=${task_details['name']}    description=${task_details['description']}    object=${task_details['object']}    workingTimePerDay=${task_details['workingTimePerDay']}
    ${response}=    Post Request    myapi    /api/v1/tasks    data=${converted_task_details}    headers=${headers}
    Set Global Variable    ${response}

Then the creation should fail with status code "${status_code}"
    Should Be Equal As Strings    ${response.status_code}    ${status_code}
    Log    Response Body: ${response.json()}

Then the creation should fail with status code 409 and error message "Task has already been used by username: Example Task"
    Should Be Equal As Strings    ${response.status_code}    409
    ${body}=    Set Variable    ${response.json()}
    Should Be Equal As Strings    ${body['message']}    Task has already been used by username: Example Task
    Log    Response Body: ${response.json()}