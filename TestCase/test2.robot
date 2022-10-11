*** Settings ***
Library     SeleniumLibrary
Library    XML
Library    Collections
Library    OperatingSystem
Test Setup      Validate homePage
Test Teardown       Close Browser
Resource        ../Facilities/baseKey.robot
Resource        ../Facilities/TestingBeymenFacilities.robot

*** Test Cases ***
Login HomePage
    Wait Until Element Is Loceted in the Page
    Search for Products    şort
    #Clear Element Text    ${search_text}
    Press Keys   ${search_text}   CTRL+a   BACKSPACE
    Search for Products    gömlek
    Press Keys    ${search_text}    ENTER
    Sleep    5s
    Choose Product
    Sleep    5s
    Add to Shopping Cart
    Sleep    5s
    verification price
    #Increase The Number of Products in The Cart
    Delete Product in Cart







