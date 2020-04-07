@echo off
cls

SET Password=MyHiddEnPassw0rd

openssl enc -aes-256-cbc -salt -pbkdf2 -a -d -in encrypted/secrets.txt -out decrypted/secrets_decrypted.md -k %Password%

echo  ==============
echo  = Decryption =
echo  ==============
echo.
echo  File encrypted\secrets.txt has been decrypted, file
echo  decrypted\secrets_decrypted.md has been decrypted, file
echo.
echo  Here's the content of the decrypted file:
echo.
type .\decrypted\secrets_decrypted.md
