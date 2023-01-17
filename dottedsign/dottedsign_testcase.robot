*** Settings ***
Documentation   DottedSign
Library           SeleniumLibrary
Library           BuiltIn
Library           String
Resource        D:/程式學習/tools/dottedsign/dottedsign_keyword.robot

*** Variables ***
${URL}             https://www.dottedsign.com/zh-tw/
${BROWSER}          Chrome
${ACCOUNT}      lygoseje@abyssmail.com
${Password}     00000000 
${ADMIN_NAME}   Testa

*** Test Cases ***
a. Log in to the test account
        Open DottedSign in Chrome
        Go to Login Page
        Login
        Verify the user name
b. Create a Get Signatures sign task
        Create a Get Signatures sign task
c. Upload a PDF file
        Upload a PDF file
        Make sure that the PDF file has been uploaded
d. Assign yourself as a signer
        Assign yourself as a signer
        Make sure that the signer's name is Testa
e. Insert a signature field to the file in any place
        Insert a signature field to the file in any place
        Make sure that the signature field is added

f. Continue to send the task（default）
        Continue to send the task

g. Check if the sign task is appeared in the task list before signing the document
        Back to the Homepage of Dottedsign
        Check if the sign task is appeared in the task list 
