*** Settings ***
Library     SeleniumLibrary
Library    XML
Library    Collections
Library    OperatingSystem
Test Teardown       Close Browser

*** Variables ***
${beymen_url}       https://www.beymen.com/
#homepage
${home_page_load}       //img[@alt='Beymen']
${search_text}      //input[@class='default-input o-header__search--input']
${product_list}     //div[@id='productList']
#poduct details page
${product_title}        //a[@class='o-productDetail__brandLink']
${product_description}        //span[@class='o-productDetail__description']
${product_price}        //ins[@id='priceNew']
${product_color}        //div[@class='m-colorsSlider__top']//label[@class='m-form__label m-variation__label']
${add_cart_button}      //button[@id='addBasket']
#sohopping cart page
${cart_button}      //a[@class='o-header__userInfo--item bwi-cart-o -cart']
${amount}      //li[@class='m-orderSummary__item -grandTotal']//span[@class='m-orderSummary__value']


*** Keywords ***
Validate homePage
    [Arguments]  ${url}
    Create Webdriver  Chrome  executable_path=C:/Users/EDA/Desktop/chromedriver
    Go To  ${url}
    Maximize Browser Window

Wait Until Element Is Loceted in the Page
    Wait Until Element Is Visible    ${home_page_load}

Search for Products
    [Arguments]   ${product_name}
    Input Text    ${search_text}    ${product_name}

Choose Product
    ${products}     Create List
    ${maxAccount}    SeleniumLibrary.Get Element Count    xpath://div[@data-component-name='list']
    FOR    ${i}    IN RANGE        ${maxAccount}
        ${index} =      Evaluate    ${i} + 1
        ${productIdList}    SeleniumLibrary.Get Element Attribute    xpath:(//div[@class='m-productCard'])[${index}]   data-productid
        Append To List    ${products}    ${productIdList}
    END
    Log List    ${products}
    ${value}  Evaluate  random.choice($products)  random
    ${selected product}     Set Variable        //div[@data-productid='${value}']
    Click Element    //div[@data-productid='${value}']
    Sleep    5s
    ${title}        Get Text    ${product_title}
    ${description}        Get Text    ${product_description}
    ${price}        Get Text    ${product_price}
    ${color}        Get Text    ${product_color}
    #Create File     C:/Users/EDA/PycharmProjects/BeymenTest/Resources/details.txt
    Append To File    C:/Users/EDA/PycharmProjects/BeymenTest/Resources/details.txt    ${title}\n
    Append To File    C:/Users/EDA/PycharmProjects/BeymenTest/Resources/details.txt    ${description}\n
    Append To File    C:/Users/EDA/PycharmProjects/BeymenTest/Resources/details.txt    ${price}\n
    Append To File    C:/Users/EDA/PycharmProjects/BeymenTest/Resources/details.txt    ${color}\n


Add to Shopping Cart
    ${body_size}     Create List
    ${count}  SeleniumLibrary.Get Element Count    xpath://span[@class='m-variation__item -criticalStock']
    FOR    ${i}    IN RANGE        ${count}
        ${index}       Evaluate    ${i} + 1
        ${sizeList}    SeleniumLibrary.Get Element Attribute    xpath:(//span[@class='m-variation__item -criticalStock'])[${index}]  class
        Click Element    xpath:(//span[@class='m-variation__item -criticalStock'])[${index}]
        Exit For Loop
    END
    Click Button    ${add_cart_button}

verification price
    ${price}        Get Text    ${product_price}
    Click Element    ${cart_button}
    Sleep    5s
    ${amount_price}  Get Text    ${amount}
    Should Be True    '${amount_price}'=='${price}'

add product




*** Test Cases ***
Login HomePage
    Validate homePage  ${beymen_url}
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






