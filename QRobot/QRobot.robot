*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}             http://automationexercise.com
${BROWSER}         Chrome
${USERNAME}        sutthiwit
${EMAIL}           sutthiwit154623@gmail.com
${PASSWORD}        Test@1234
${FIRSTNAME}       Test
${LASTNAME}        User
${ADDRESS}         123 Test Street
${ADDRESS2}        456 Test Ave
${CITY}            TestCity
${STATE}           TestState
${ZIPCODE}         12345
${MOBILE}          1234567890
${DOB}             01/01/1990
${COUNTRY}         Singapore
${COMPANY}         TestCompany
${TITLE}           Mr.

*** Test Cases ***
Verify Address Details In Checkout Page
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window
    Wait Until Page Contains    Home

    # คลิกที่ปุ่ม "Signup / Login" เพื่อไปยังหน้าสมัครสมาชิก
    Click Element    xpath=//a[contains(text(),'Signup / Login')]

    # รอให้ช่องกรอกอีเมลปรากฏ
    Wait Until Element Is Visible    xpath=//input[@data-qa='signup-email']

    # กรอกข้อมูลสมัครสมาชิก
    Input Text    xpath=//input[@name='name']    ${USERNAME}
    Input Text    xpath=//input[@data-qa='signup-email']    ${EMAIL}  # กรอกอีเมลที่ถูกต้อง
    Click Button    xpath=//button[contains(text(),'Signup')]

    Wait Until Page Contains    Enter Account Information

    # กรอกข้อมูลในฟอร์มสมัครสมาชิก
    Click Element  xpath=//*[@id="uniform-id_gender1"]/span/input
    Input Text    xpath=//input[@name='password']    ${PASSWORD}
    Input Text    xpath=//input[@name='first_name']    ${FIRSTNAME}
    Input Text    xpath=//input[@name='last_name']    ${LASTNAME}
    Input Text    xpath=//input[@name='address1']    ${ADDRESS}
    Input Text    xpath=//input[@name='address2']    ${ADDRESS2}
    Input Text    xpath=//input[@name='city']    ${CITY}
    Input Text    xpath=//input[@name='state']    ${STATE}
    Input Text    xpath=//input[@name='zipcode']    ${ZIPCODE}
    Input Text    xpath=//input[@name='mobile_number']    ${MOBILE}
    Input Text    xpath=//input[@name='company']    ${COMPANY} 
    
    Select From List By Label    xpath=//select[@name='country']    ${COUNTRY}
    Click Button    xpath=//button[contains(text(),'Create Account')]

    Wait Until Page Contains    Account Created!
    Click Element    xpath=//*[@id="form"]/div/div/div/div/a

    # ตรวจสอบว่าเราเข้าสู่ระบบหรือไม่
    Wait Until Page Contains    Logged in as ${USERNAME}

    # เพิ่มสินค้าลงในตะกร้า
    Click Element    xpath=//a[contains(text(),'Products')]
    Wait Until Page Contains    All Products
    Click Element    xpath=(//a[contains(text(),'Add to cart')])[1]
    Click Button    xpath=//button[contains(text(),'Continue Shopping')]

    # ไปที่หน้า Cart
    Click Element    xpath=//a[contains(text(),'Cart')]
    Wait Until Page Contains    Shopping Cart
    Click Button    xpath=//a[contains(text(),'Proceed To Checkout')]

    # ตรวจสอบที่อยู่
    Wait Until Page Contains    Address Details
    Page Should Contain    ${ADDRESS}
    Page Should Contain    ${ADDRESS2}
    Page Should Contain    ${CITY}
    Page Should Contain    ${STATE}
    Page Should Contain    ${ZIPCODE}
    Page Should Contain    ${MOBILE}

    # ลบบัญชีผู้ใช้
    Click Element    xpath=//a[contains(text(),'Delete Account')]
    Wait Until Page Contains    ACCOUNT DELETED!
    Click Button    xpath=//a[contains(text(),'Continue')]

    Close Browser
    
