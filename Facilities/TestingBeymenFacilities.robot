*** Settings ***
Library     SeleniumLibrary
Library    XML
Library    Collections
Library    OperatingSystem
Resource        ../Resources/HomePage_Variables.robot
Resource        ../Resources/Product_Details_Variables.robot
Resource        ../Resources/Shopping_Cart_Variables.robot

*** Keywords ***
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
    ${amount_price}  Get Text    ${sale_price}
    Should Be True    '${amount_price}'=='${price}'

Increase The Number of Products in The Cart
    Select From List By Value    xpath://select[@class='a-selectControl -small']  2
    Wait Until Element Is Visible    xpath://div[@class='m-notification__content']

Delete Product in Cart
    Click Button    xpath://button[@class='m-basket__remove btn-text']
    Wait Until Page Contains Element    //strong[contains(text(),'Sepetinizde Ürün Bulunmamaktadır')]