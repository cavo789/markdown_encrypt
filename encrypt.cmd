@echo off
cls

SET Password=MyHiddEnPassw0rd

openssl enc -aes-256-cbc -salt -pbkdf2 -a -in decrypted/secrets.md -out encrypted/secrets.txt -k %Password%

echo  ==============
echo  = Encryption =
echo  ==============
echo.
echo  File encrypted\secrets.txt has been encrypted
echo.
echo  Here's the content of the encrypted file:
echo.
type .\encrypted\secrets.txt
