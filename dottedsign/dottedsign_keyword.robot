*** Settings ***
Documentation   郵務包裹_回歸測試
Library           SeleniumLibrary
Library           BuiltIn
Library           String

*** Keywords ***

Open DottedSign in Chrome
 #a-1-1以最大化視窗開啟點點簽的網頁
        Open Browser  ${URL}  ${BROWSER}  options=add_argument('--start-maximized')
 #我的chromedriver路徑在C:\Users\user\AppData\Local\Programs\Python\Python39

Go to Login Page
#a-2-1接受cookie政策
        Click Element  id=gdpr-agree
#a-2-2click 按鈕_登入，進入登入頁
        Click Element  xpath=//div[2]/a[1][@id='Login_Navibar']
Login
#a-3-1確定已到登入頁
        Wait Until Page Contains    繼續使用 DottedSign Web
#a-3-2輸入email
        Input Text    xpath=//div[1]/input[@placeholder='Email']  ${ACCOUNT}
#a-3-3輸入密碼
        Input Password  xpath=//div[2]/input[@placeholder='密碼']  ${Password}
#a-3-4click 按鈕_登入，完成登入
        Click Element  id=btn-ready-send

Verify the user name
#a-4-1確認登入名字的地方姓名正確
        Sleep  2s
        Click Element    xpath=/html/body/div[1]/div/div[1]/div/div[3]/div/div[3]/div/div/div
        Element Should Contain    xpath=/html/body/div[1]/div/div[1]/div/div[3]/div/div[3]/div/div[2]/div[1]/div/div[1]    ${ADMIN_NAME}
        Click Element  xpath=/html/body/div[1]/div/div[3]/div/div[1]/div[2]
Create a Get Signatures sign task
#b-1-1click 按鈕_+，選擇邀請他人簽署
        Click Element   xpath=//div[3]/div/div[@class='styled__WrapperIconShadow-sc-39hx2f-1 hqZvLe']
        Click Element    xpath=//div/div[2]/div[2][@id='Task-AddTask-GetSignatures']
Upload a PDF file
#c-1-1確認頁面內有"上傳文件"的字眼
        Wait Until Page Contains  上傳文件
#c-1-2上傳pdf檔案
        Choose File    xpath=//div[1]/div/input[@accept='application/pdf']  D:/程式學習/tools/dottedsign/pdfexamplefile.pdf
Make sure that the PDF file has been uploaded
#c-2-1確認已跳轉至任務名稱頁
        Wait Until Page Contains    任務名稱
        Sleep  1s
#c-2-2確認有輸入pdf檔案名稱作為預設任務名稱
        Textfield Should Contain   xpath=/html/body/div[1]/div/div[2]/div[2]/div/input  pdfexamplefile 
#c-2-3確認上傳文件頁內有pdf檔案
        Element Should Contain    xpath=//div[3]/div/div/div/div[1][@class='styled__Filename-sc-wyc4pm-1 kIhjCn']  pdfexamplefile.pdf
Assign yourself as a signer
#d-1-1在placeholder_姓名，輸入{ADMIN_NAME}
        Input Text  xpath=//div/div[2]/div/input[@placeholder='姓名']  ${ADMIN_NAME}
#d-1-2在placeholder_電子郵件，輸入電子郵件
        Input Text  xpath=//div/div[3]/div/input[@placeholder='電子郵件']  ${ACCOUNT}
#d-1-3click 按鈕_下一步
        Click Element  xpath=//div[1]/div[2]/div[5][@tabindex='2020']
Make sure that the signer's name is Testa
        Sleep  4s
#d-2-1關掉教學彈窗
        Click Element  xpath=/html/body/div[3]/div/div/div/div[1]/div
#d-2-2確認欄位已有文字{ADMIN_NAME}
        Element Should Contain  xpath=//div[2]/div[1]/div/div/div[2][@class='styled__Email-sc-6wp343-2 fjicwe']  ${ADMIN_NAME}
        
Insert a signature field to the file in any place
#e-1-1click 側邊欄_文字
        Click Element  xpath=//div[2]/div[2]/div[3][@class='styled__Item-sc-1qmkaq6-2 cqJWom']
#e-1-2將簽名的欄位放到pdf檔案內
        Click Element    xpath=/html/body/div[1]/div/div[2]/div[2]/div[2]/div/div/div/div/canvas
Make sure that the signature field is added
#e-2-1click 按鈕_預覽
        Click Element   xpath=/html/body/div[1]/div/div[2]/div[2]/div[1]/div/div[2]
#e-2-2確認預覽頁面有簽名框
        Page Should Contain Element    xpath=/html/body/div[1]/div/div[2]/div[2]/div[2]/div/div/div/div[2]
Continue to send the task
#f-1-1click 按鈕_下一步
        Click Element  xpath=/html/body/div[1]/div/div[1]/div[2]/div[5]
#f-1-2在彈窗click按鈕_送出
        Click Element  xpath=/html/body/div[3]/div/div/div/div[4]/div[3]
Back to the Homepage of Dottedsign 
#g-1-1等待頁面載入，click 左上角上一頁，回到首頁
        Sleep  25s
        Wait Until Page Contains    pdfexamplefile
        Wait Until Element Contains  xpath=/html/body/div[1]/div/div[1]/nav/div[3]/div[1]/div/div[3]  下一個
        Click Element  xpath=/html/body/div[1]/div/div[1]/nav/div[1]/div
#g-1-2確定已回到首頁且已載入完畢
        Page Should Contain  待自己簽署        
Check if the sign task is appeared in the task list 
#g-2-1click tab_待自己簽署
        Sleep  5s
        Click Element    xpath=/html/body/div[1]/div/div[2]/div[1]
#g-2-2確認有名為"pdfexamplefile"的任務
        Page Should Contain    pdfexamplefile
        Page Should Contain Element  xpath=/html/body/div[1]/div/div[3]/div/div[2]/div/div