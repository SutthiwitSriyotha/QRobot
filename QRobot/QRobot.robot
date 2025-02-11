*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}             http://automationexercise.com
${BROWSER}         Chrome
${USERNAME}        testuser
${EMAIL}           testuser@example.com
${PASSWORD}        Test@1234
${FIRSTNAME}       Test
${LASTNAME}        User
${ADDRESS}         123 Test Street
${CITY}            TestCity
${STATE}           TestState
${ZIPCODE}         12345
${MOBILE}          1234567890

*** Test Cases ***
Verify Address Details In Checkout Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Home

    Click Element    xpath=//a[contains(text(),'Signup / Login')]
    Input Text    xpath=//input[@name='name']    ${USERNAME}
    Input Text    xpath=//input[@name='email']    ${EMAIL}
    Click Button    xpath=//button[contains(text(),'Signup')]
    Wait Until Page Contains    ENTER ACCOUNT INFORMATION

    # Fill signup form
    Select Radio Button    title    Mr.
    Input Text    xpath=//input[@name='password']    ${PASSWORD}
    Input Text    xpath=//input[@name='first_name']    ${FIRSTNAME}
    Input Text    xpath=//input[@name='last_name']    ${LASTNAME}
    Input Text    xpath=//input[@name='address1']    ${ADDRESS}
    Input Text    xpath=//input[@name='city']    ${CITY}
    Input Text    xpath=//input[@name='state']    ${STATE}
    Input Text    xpath=//input[@name='zipcode']    ${ZIPCODE}
    Input Text    xpath=//input[@name='mobile_number']    ${MOBILE}
    Click Button    xpath=//button[contains(text(),'Create Account')]
    Wait Until Page Contains    ACCOUNT CREATED!
    Click Button    xpath=//a[contains(text(),'Continue')]

    # Verify logged in
    Wait Until Page Contains    Logged in as ${USERNAME}

    # Add products to cart
    Click Element    xpath=//a[contains(text(),'Products')]
    Wait Until Page Contains    All Products
    Click Element    xpath=(//a[contains(text(),'Add to cart')])[1]
    Click Button    xpath=//button[contains(text(),'Continue Shopping')]

    # Go to cart
    Click Element    xpath=//a[contains(text(),'Cart')]
    Wait Until Page Contains    Shopping Cart
    Click Button    xpath=//a[contains(text(),'Proceed To Checkout')]

    # Verify addresses
    Wait Until Page Contains    Address Details
    Page Should Contain    ${ADDRESS}
    Page Should Contain    ${CITY}
    Page Should Contain    ${STATE}
    Page Should Contain    ${ZIPCODE}
    Page Should Contain    ${MOBILE}

    # Delete account
    Click Element    xpath=//a[contains(text(),'Delete Account')]
    Wait Until Page Contains    ACCOUNT DELETED!
    Click Button    xpath=//a[contains(text(),'Continue')]

    Close Browser
