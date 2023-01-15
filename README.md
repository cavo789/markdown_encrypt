# Markdown Encrypt - Using SSL

> Also see [Encrypt/decrypt files using Docker and OpenSSL](https://github.com/cavo789/docker_ssl_encrypt), a much simplier example based on this repository.

> Proof of concept - Encrypt markdown files and store encrypted version on github

![Banner](./banner.svg)

* [Introduction](#introduction)
* [Install OpenSSL](#install-openssl)
* [Encrypt a file](#encrypt-a-file)
* [Decrypt a file](#decrypt-a-file)
* [gitignore](#gitignore)
* [Automation](#automation)
  * [Using batches](#using-batches)
  * [Using githooks](#using-githooks)
* [Annex](#annex)
* [Licence](#licence)

## Introduction

Idea of this proof-of-concept is to show how to encrypt files with a SSL key and allow to store these files on github, in a public repository.

Keeping the key for the decryption in a private place (like on a hard disk) will allow to decrypt files locally.

So, in short, POC to show how to use a public repository keeping content hidden.

## Install OpenSSL

First, you'll need to install OpenSSL on your computer:

* Go to [https://slproweb.com/products/Win32OpenSSL.html](https://slproweb.com/products/Win32OpenSSL.html)
* Download the `Win64 OpenSSL v1.1.1d Light` file
* Start the setup process (default install directory will be `C:\Program Files\OpenSSL-Win64`)

Tip: add the `C:\Program Files\OpenSSL-Win64\bin` folder in your `PATH` so you can call the `openssl` command from anywhere.

## Encrypt a file

Under a DOS Prompt Session, run the following command:

```dos
openssl enc -aes-256-cbc -salt -pbkdf2 -a -in SOURCE.TXT -out ENCRYPTED.TXT -k MyHiddEnPassw0rd
```

| Option         | Description                                             |
| -------------- | ------------------------------------------------------- |
| `enc`          | Encoding with Ciphers                                   |
| `-aes-256-cbc` | The encryption cipher to be used                        |
| `-salt`        | Adds strength to the encryption                         |
| `-pbkdf2`      | Generate a PBKDF2 key derivation of a supplied password |
| `-a`           | Encrypted data should be in Base64 and not binary       |
| `-in`          | Specifies the input file                                |
| `-out`         | Specifies the output file                               |
| `-k`           | Provide the password to use for the encryption          |

See file `encrypt_samples.cmd` for a sample.

## Decrypt a file

Under a DOS Prompt Session, run the following command:

```dos
openssl enc -aes-256-cbc -salt -pbkdf2 -a -d -in ENCRYPTED.TXT -out DECRYPTED.TXT -k MyHiddEnPassw0rd
```

| Option         | Description                                             |
| -------------- | ------------------------------------------------------- |
| `enc`          | Encoding with Ciphers                                   |
| `-aes-256-cbc` | The encryption cipher to be used                        |
| `-salt`        | Adds strength to the encryption                         |
| `-pbkdf2`      | Generate a PBKDF2 key derivation of a supplied password |
| `-a`           | Encrypted data should be in Base64 and not binary       |
| `-d`           | Decrypt action                                          |
| `-in`          | Specifies the input file                                |
| `-out`         | Specifies the output file                               |
| `-k`           | Provide the password to use for the decryption          |

See file `decrypt_samples.cmd` for a sample.

## gitignore

Make sure to add to the `.gitignore` with, at least, this content:

```text
decrypt.cmd
encrypt.cmd
decrypted/
```

1. `decrypt.cmd` - The batch for the decryption. That script can contains the password in plain-text.
2. `encrypt.cmd` - The batch for the encryption. That script can contains the password in plain-text.
3. `decrypted/`  - Ignore the folder with decrypted files.

Note: in this proof-of-concept and for demo purposes, files and folder aren't part of the `.gitignore` file. **In your real-life use cases, don't forget to fill in the `.gitignore` file.**.

## Automation

### Using batches

1. Make a copy of `decrypt_samples.cmd` to `decrypt.cmd` and  `encrypt_samples.cmd` to `encrypt.cmd`.
2. Edit `decrypt.cmd` and `encrypt.cmd` to set your own password.

### Using githooks

By using a `pre-commit` hook; you can automate the encryption of new notes. By writing a custom script of your owns, you can detect the list of changes (with a `git status` command) and run the encryption for all these notes. Encrypted version should be saved in the ` encrypted` folder to complete the automation.


## Annex

Part of information's have been found on [https://www.shellhacks.com/encrypt-decrypt-file-password-openssl/](https://www.shellhacks.com/encrypt-decrypt-file-password-openssl/)

## Licence

[MIT](LICENSE)
