*** Settings ***
Library     SeleniumLibrary


*** Keywords ***
Validate homePage
    Create Webdriver  Chrome  executable_path=C:/Users/EDA/Desktop/chromedriver
    Go To  https://www.beymen.com/
    Maximize Browser Window