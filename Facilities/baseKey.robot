*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Validate homePage
    Create Webdriver  Chrome  executable_path=Resources/chromedriver.exe
    Go To  https://www.beymen.com/
    Maximize Browser Window