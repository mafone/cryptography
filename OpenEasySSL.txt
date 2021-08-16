#!/bin/bash
#Função para Sair do programa
Sair(){
clear
exit
}

#Função Help
Ajuda(){
echo "
__________________________________________________________________________________________________________________________________
|                                                                                                                                |
| Nome: OpenEasySSL                        Desenvolvido por:   L-Team                      Copyright © 2021 L-Team               |
|________________________________________________________________________________________________________________________________|

Descrição: Esta ferramenta é um guia de ajuda que facilita executar operações da biblioteca OpenSSL por intermédio da linha de 
comando, este guia não decarta a utilização do manual do openssl.
__________________________________________________________________________________________________________________________________
|                                     |                                                                                          |
|    Comandos padrão                  |                                         Descrição                                        | 
|_____________________________________|__________________________________________________________________________________________|
|1 |  openssl  	                                               Ferramenta openssl                                             |1 |           
|2 |  enc                                  Parte do openssl que indica o que vem a seguir é um modo de cifra                  |2 |
|3 |  -e                                   Parte do openssl que realiza a operação de cifra                                   |3 |
|4 |  -d                                   Parte do openssl que realiza a operação de decifra                                 |4 |
|5 |  -K                                   Parte do openssl que indica que o que vem a seguir é a chave                       |5 |
|6 |  -in                                  Parte do openssl que indica que o que vem a seguir é o ficheiro de entrada         |6 |
|7 |  -out                                 Parte do openssl que indica que o que vem a seguir é o ficheiro de saída           |7 |
___________________________________________________________________________________________________________________________________
|                                     |                                                                                                    
| Comandos padrão                     |                                       Descrição                                   
|_____________________________________|____________________________________________________________________________________________

Gerar número aleatório:					openssl rand -base64 8

Gerar hash (SHA;MD5) de um ficheiro:			openssl dgst -sha1 arquivo.txt
							openssl dgst -md5 arquivo.txt

Cifrar arquivo com AES/DES:				openssl enc -aes256 -e -in arquivo.txt -out arquivo.enc.txt
							openssl enc -des -e -in arquivo.txt -out arquivo.enc.txt

Descritografar arquivo com AES/DES:			openssl enc -aes256 -d -in arquivo.enc.txt -out arquivo.txt
							openssl enc -des -d -in arquivo.enc.txt -out arquivo.txt

Gera chave privada RSA:					openssl genrsa -out chave.key 1024
							openssl genrsa -aes256 -out chave.key 1024

Criar chave pública RSA:				openssl rsa -in chave.key -pubout -out chave.pub

Cifra arquivo com algoritmo 
assimétrico RSA:  					openssl rsautl -in teste.txt -out teste.rsa -encrypt -pubin -inkey pubkey.pem

Decifrar arquivo com algoritmo 
assimétrico RSA: 					openssl rsautl -in teste.rsa -out teste.rec -decrypt -inkey key.pem

Assinar hash com chave privada:				openssl dgst -sha256 -sign chave.key -out hash.sha256 arquivo

Verificar assinatura com chave pública:			openssl dgst -sha256 -verify chave.pub -signature hash.sha256 arquivo

Retirar chave pública do certificado:			openssl x509 -in snakeoil.crt -pubkey -noout > snakeoil.pub

Gerar uma chave privada e 
requisição de assinatura de 				
certificado (CSR): 					openssl req -out CSR.csr -new -newkey rsa:2048 -nodes -keyout privateKey.key


Gerar um certificado auto-assinado:			openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key 								-out certificate.crt

Gerar uma requisição de assinatura 
de certificado (CSR) para uma 
chave privada existente:				openssl req -out CSR.csr -key privateKey.key -new
______________________________________________________________________________________________________________________________________________
Autores: José Bongo, José Pereira, Hermenegildo Santos, Mbalú Júnior
COPYRIGHT L-Team2021 "

read operacao
if [ $operacao -eq 0 ]
then
	clear
	MenuPrincipal " "
else
	clear
	Ajuda ""
	echo "Opção inválida"
fi
}

#Menu Inicial
MenuPrincipal(){
echo "============Operar com openssl=============="
echo "|                                          |"
echo "|O que pretende fazer?                     |"
echo "|1 - Cifrar                                |"
echo "|2 - Decifrar                              |"
echo "|3 - Operação sobre assinaturas digitais   |"
echo "|4 - Calcular HASH                         |"
echo "|5 - Calcular ou Verificar HMAC            |"
echo "|6 - Algorítimo de codificação base64      |"
echo "|7 - Operação com certificado X.509        |"
echo "|8 - Help                                  |"
echo "|0 - Sair                                  |"
echo "|==========================================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 0 ]
then
	Sair " "

elif [ $operacao -eq 1 ]
then
	clear
	Cifrar " "

elif [ $operacao -eq 2 ]
then
	clear
	Decifrar " "

elif [ $operacao -eq 3 ]
then
	clear
	AssinDigit " "

elif [ $operacao -eq 4 ]
then
	clear
	CalcHash " "

elif [ $operacao -eq 5 ]
then
	clear
	CalcVerifHMAC " "

elif [ $operacao -eq 6 ]
then
	clear
	AlgCodBase64 " "

elif [ $operacao -eq 7 ]
then
	clear
	gerCertX509 " "
elif [ $operacao -eq 8 ]
then
	clear
	Ajuda " "
else
	clear
	MenuPrincipal ""
	echo "Opção inválida"
fi
}

#Inicio das funções de cifra
Cifrar(){
echo "=========Cifra========"
echo "|                    |"
echo "|Tipo de cifra       |"
echo "|1 - AES             |"
echo "|2 - DES             |"
echo "|3 - RC4             |"
echo "|0 - voltar          |"
echo "|====================|"
read operacao
if [ $operacao -eq 1 ]
	then
		clear
		CifraAES " "

elif [ $operacao -eq 2 ]
	then
		clear
		CifraDES ""

elif [ $operacao -eq 3 ]
	then
		clear
		CifraRC4 ""
elif [ $operacao -eq 0 ]
then
	clear
	MenuPrincipal ""
else
clear
	Cifrar ""
fi
}

#====================================================

CifraAES(){
echo "======== Cifra AES ========="
echo "|                          |"
echo "|Escolha o modo de cifra   |"
echo "|1 - AES (CBC)             |"
echo "|2 - AES (CFB)             |"
echo "|3 - AES (CFB1)            |"
echo "|4 - AES (CFB8)            |"
echo "|5 - AES (CTR)             |"
echo "|6 - AES (ECB)             |"
echo "|7 - AES (OFB)             |"
echo "|0 - voltar                |"
echo "|==========================|"		
read operacao
if [ $operacao -eq 1 ]
	then
		clear
		CifraAES_CBC " "

elif [ $operacao -eq 2 ]
	then
		clear
		CifraAES_CFB ""
elif [ $operacao -eq 3 ]
	then
		clear
		CifraAES_CFB1 ""
elif [ $operacao -eq 4 ]
	then
		clear
		CifraAES_CFB8 ""
elif [ $operacao -eq 5 ]
	then
		clear
		CifraAES_CTR ""
elif [ $operacao -eq 6 ]
	then
		clear
		CifraAES_ECB ""
elif [ $operacao -eq 7 ]
	then
		clear
		CifraAES_OFB ""
elif [ $operacao -eq 0 ]
	then
		clear
		Cifrar ""
else
		clear
		CifraAES ""
		echo "Opção inválida"	
	fi

}

#=====================================================

CifraAES_CBC(){
echo "========= Cifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CBC (256)          |"
echo "|2 - AES CBC (192)          |"
echo "|3 - AES CBC (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear
	aes256cbc ""					
elif [ $operacao -eq 2 ]
then
	clear
	aes192cbc ""			
elif [ $operacao -eq 3 ]
then
	clear
	aes128cbc ""	
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""
else
clear
		CifraAES_CBC ""
		echo "Opção inválida"
fi

}

CifraAES_CFB(){
echo "========= Cifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CFB (256)          |"
echo "|2 - AES CFB (192)          |"
echo "|3 - AES CFB (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear
	aes256cfb ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192cfb ""	
elif [ $operacao -eq 3 ]
then
	clear
	aes128cfb ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""	
else
clear
		CifraAES_CFB ""
		echo "Opção inválida"
fi	
}

CifraAES_CFB1(){
echo "========= Cifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CFB1 (256)         |"
echo "|2 - AES CFB1 (192)         |"
echo "|3 - AES CFB1 (128)         |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear	
	aes256cfb1 ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192cfb1 ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128cfb1 ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""
else
clear
		CifraAES_CFB1 ""
		echo "Opção inválida"
fi
}

CifraAES_CFB8(){
echo "========= Cifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CFB8 (256)         |"
echo "|2 - AES CFB8 (192)         |"
echo "|3 - AES CFB8 (128)         |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear
	aes256cfb8 ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192cfb8 ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128cfb8 ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""
else
clear
		CifraAES_CFB8 ""
		echo "Opção inválida"
fi
}

CifraAES_CTR(){
echo "========= Cifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CTR (256)          |"
echo "|2 - AES CTR (192)          |"
echo "|3 - AES CTR (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	aes256ctr ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192ctr ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128ctr ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""
else
clear
		CifraAES_CTR ""
		echo "Opção inválida"
fi
}

CifraAES_ECB(){
echo "========= Cifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES ECB (256)          |"
echo "|2 - AES ECB (192)          |"
echo "|3 - AES ECB (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	aes256ecb ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192ecb ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128ecb ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""
else
clear
		CifraAES_ECB ""
		echo "Opção inválida"
fi
}

CifraAES_OFB(){
echo "========= Cifra AES ========="
echo "|Escolha o tamanho da chave |"
echo "|                           |"
echo "|1 - AES OFB (256)          |"
echo "|2 - AES OFB (192)          |"
echo "|3 - AES OFB (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	aes256ofb ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192ofb ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128ofb ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraAES ""
else
clear
		CifraAES_OFB ""
		echo "Opção inválida"
fi
}

CifraDES(){
echo "======= Cifra DES ========"
echo "|                        |"
echo "|1 - DES                 |"
echo "|2 - DES EDE             |"
echo "|3 - DES EDE3            |"
echo "|0 - voltar              |"
echo "|========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	CifraDES ""
elif [ $operacao -eq 2 ]
then
	clear
	CifraDES_EDE ""
elif [ $operacao -eq 3 ]
then
	clear
	CifraDES_EDE3 ""
elif [ $operacao -eq 0 ]
then	
	clear
	Cifrar ""
else
clear
		CifraDES ""
		echo "Opção inválida"
fi
}

CifraDESM(){
echo "===== Cifra DES ====="
echo "|                   |"						
echo "|1 - DES (CBC)      |"
echo "|2 - DES (OFB)      |"
echo "|3 - DES (ECB)      |"
echo "|0 - voltar         |"
echo "|===================|" 
read operacao
if [ $operacao -eq 1 ]
then
	clear
	descbc ""
elif [ $operacao -eq 2 ]
then
	clear
	desofb ""
elif [ $operacao -eq 3 ]
then
	clear
	desecb ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraDES ""

else
clear
		CifraDESM ""
		echo "Opção inválida"
fi
}

CifraDES_EDE(){
echo "==== Cifra DES EDE ===="
echo "|                     |"						
echo "|1 - DES EDE (CBC)    |"
echo "|2 - DES EDE (CFB)    |"
echo "|3 - DES EDE (OFB)    |"
echo "|4 - DES EDE (ECB)    |"
echo "|0 - voltar           |"
echo "|=====================|"						
read operacao
if [ $operacao -eq 1 ]
then
	clear
	dedCBC ""
elif [ $operacao -eq 2 ]
then
	clear
	dedcfb ""
elif [ $operacao -eq 3 ]
then
	clear
	dedofb ""
	echo "aqui acontece a Cifra com os seguintes parâmetros $1, $2, $3, $4"		clear
	dedeecb ""
elif [ $operacao -eq 0 ]
then
	clear
	CifraDES ""
else
clear
		CifraDES_EDE ""
		echo "Opção inválida"
fi
}

CifraDES_EDE3(){
echo "==== Cifra DES EDE3 ===="
echo "|                      |"						
echo "|1 - DES EDE3 (CBC)    |"
echo "|2 - DES EDE3 (CFB)    |"
echo "|3 - DES EDE3 (OFB)    |"
echo "|4 - DES EDE3 (ECB)    |"
echo "|0 - voltar            |"
echo "|======================|"	
read operacao
if [ $operacao -eq 1 ]
then
	clear
	ded3CBC ""
elif [ $operacao -eq 2 ]
then
	clear
	aes128cbc ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128cbc ""
	echo "aqui acontece a Cifra com os seguintes parâmetros $1, $2, $3, $4"		aes128cbc ""
elif [ $operacao -eq 0 ]
then
clear
	CifraDES ""
else
clear
		CifraDES_EDE3 ""
		echo "Opção inválida"
fi
}

CifraRC4(){
echo "========== Cifra RC4 =========="
echo "|                             |"
echo "|1 - RC4 128                  |"
echo "|2 - RC4 64                   |"
echo "|3 - RC4 40                   |"
echo "|0 - voltar                   |"
echo "|=============================|"	
read operacao
if [ $operacao -eq 1 ]
then
	clear
	rc4 ""
elif [ $operacao -eq 2 ]
then
	clear
	rc464 ""
elif [ $operacao -eq 3 ]
then
	clear
	rc440 ""
elif [ $operacao -eq 0 ]
then
	clear
	Cifrar ""

else
clear
	CifraRC4 ""
	echo "Opção inválida"
fi
}

#=========================================================Fim cifra
#==================================================================
#==================================================================
#Inicio decifra====================================================
Decifrar(){
echo "=========Decifra========"
echo "|                    |"
echo "|Tipo de Cifra       |"
echo "|1 - AES             |"
echo "|2 - DES             |"
echo "|3 - RC4             |"
echo "|0 - voltar          |"
echo "|====================|"
read operacao
if [ $operacao -eq 1 ]
	then
		clear
		DecifraAES " "

elif [ $operacao -eq 2 ]
	then
		clear
		DecifraDES ""

elif [ $operacao -eq 3 ]
	then
		clear
		DecifraC4 ""

elif [ $operacao -eq 0 ]
then
clear
	MenuPrincipal ""

else
clear
	Decifrar ""
	echo "Opção inválida"
fi
}

#====================================================

DecifraAES(){
echo "======== Decifra AES ========="
echo "|                          |"
echo "|Escolha o modo de Cifra   |"
echo "|1 - AES (CBC)             |"
echo "|2 - AES (CFB)             |"
echo "|3 - AES (CFB1)            |"
echo "|4 - AES (CFB8)            |"
echo "|5 - AES (CTR)             |"
echo "|6 - AES (ECB)             |"
echo "|7 - AES (OFB)             |"
echo "|0 - voltar                |"
echo "|==========================|"		
read operacao
if [ $operacao -eq 1 ]
	then
		clear
		DecifraAES_CBC " "

elif [ $operacao -eq 2 ]
	then
		clear
		DecifraAES_CFB ""
elif [ $operacao -eq 3 ]
	then
		clear
		DecifraAES_CFB1 ""
elif [ $operacao -eq 4 ]
	then
		clear
		DecifraAES_CFB8 ""
elif [ $operacao -eq 5 ]
	then
		clear
		DecifraAES_CTR ""
elif [ $operacao -eq 6 ]
	then
		clear
		DecifraAES_ECB ""
elif [ $operacao -eq 7 ]
	then
		clear
		DecifraAES_OFB ""
elif [ $operacao -eq 0 ]
then
clear
	Decifrar ""

else
		clear
		DecifraAES ""
		echo "Opção inválida"	
	fi

}

#=====================================================

DecifraAES_CBC(){
echo "========= Decifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CBC (256)          |"
echo "|2 - AES CBC (192)          |"
echo "|3 - AES CBC (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear
	aes256cbc ""					
elif [ $operacao -eq 2 ]
then
	clear
	aes192cbc ""			
elif [ $operacao -eq 3 ]
then
	clear
	aes128cbc ""	
elif [ $operacao -eq 0 ]
then
clear
	DecifraAES ""

else
	clear
	DecifraAES_CBC ""
	echo "Opção inválida"	
fi

}

DecifraAES_CFB(){
echo "========= Decifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CFB (256)          |"
echo "|2 - AES CFB (192)          |"
echo "|3 - AES CFB (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear
	aes256cfb ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192cfb ""	
elif [ $operacao -eq 3 ]
then
	clear
	aes128cfb ""	
elif [ $operacao -eq 0 ]
then
clear
	DecifraAES ""

else
	clear
	DecifraAES_CFB ""
	echo "Opção inválida"
fi	
}

DecifraAES_CFB1(){
echo "========= Decifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CFB1 (256)         |"
echo "|2 - AES CFB1 (192)         |"
echo "|3 - AES CFB1 (128)         |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
aes256cfb1 ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192cfb1 ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128cfb1 ""
elif [ $operacao -eq 0 ]
then
	clear
	DecifraAES ""

else
	clear
	DecifraAES_CFB1 ""
	echo "Opção inválida"
fi
}

DecifraAES_CFB8(){
echo "========= Decifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CFB8 (256)         |"
echo "|2 - AES CFB8 (192)         |"
echo "|3 - AES CFB8 (128)         |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
then
	clear
	aes256cfb8 ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192cfb8 ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128cfb8 ""
elif [ $operacao -eq 0 ]
then
clear
	DecifraAES ""

else
	clear
	DecifraAES_CFB8 ""
	echo "Opção inválida"
fi
}

DecifraAES_CTR(){
echo "========= Decifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES CTR (256)          |"
echo "|2 - AES CTR (192)          |"
echo "|3 - AES CTR (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	aes256ctr ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192ctr ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128ctr ""
elif [ $operacao -eq 0 ]
then
	clear
	DecifraAES ""

else
	clear
	DecifraAES_CTR ""
	echo "Opção inválida"
fi
}

DecifraAES_ECB(){
echo "========= Decifra AES ========="
echo "|                           |"
echo "|Escolha o tamanho da chave |"
echo "|1 - AES ECB (256)          |"
echo "|2 - AES ECB (192)          |"
echo "|3 - AES ECB (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	aes256ecb ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192ecb ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128ecb ""
elif [ $operacao -eq 0 ]
then
	clear
	DecifraAES ""

else
	clear
	DecifraAES_ECB ""
	echo "Opção inválida"
fi
}

DecifraAES_OFB(){
echo "========= Decifra AES ========="
echo "|Escolha o tamanho da chave |"
echo "|                           |"
echo "|1 - AES OFB (256)          |"
echo "|2 - AES OFB (192)          |"
echo "|3 - AES OFB (128)          |"
echo "|0 - voltar                 |"
echo "|===========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	aes256ofb ""
elif [ $operacao -eq 2 ]
then
	clear
	aes192ofb ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128ofb ""
elif [ $operacao -eq 0 ]
then
clear
	DecifraAES ""

else
	clear
	DecifraAES_OFB ""
	echo "Opção inválida"
fi
}

DecifraDES(){
echo "======= Decifra DES ========"
echo "|                        |"
echo "|1 - DES                 |"
echo "|2 - DES EDE             |"
echo "|3 - DES EDE3            |"
echo "|0 - voltar              |"
echo "|========================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	DecifraDES ""
elif [ $operacao -eq 2 ]
then
	clear
	DecifraDES_EDE ""
elif [ $operacao -eq 3 ]
then
	clear
	DecifraDES_EDE3 ""
elif [ $operacao -eq 0 ]
then
clear
	Decifrar ""

else
	clear
	DecifraDES ""
	echo "Opção inválida"
fi
}

DecifraDESM(){
echo "===== Decifra DES ====="
echo "|                   |"						
echo "|1 - DES (CBC)      |"
echo "|2 - DES (OFB)      |"
echo "|3 - DES (ECB)      |"
echo "|0 - voltar         |"
echo "|===================|" 
read operacao
if [ $operacao -eq 1 ]
then
	clear
	descbc ""
elif [ $operacao -eq 2 ]
then
	clear
	desofb ""
elif [ $operacao -eq 3 ]
then
	clear
	desecb ""

elif [ $operacao -eq 0 ]
then
	clear
	DecifraDES ""

else
	clear
	DecifraDESM ""
	echo "Opção inválida"
fi
}

DecifraDES_EDE(){
echo "==== Decifra DES EDE ===="
echo "|                     |"						
echo "|1 - DES EDE (CBC)    |"
echo "|2 - DES EDE (CFB)    |"
echo "|3 - DES EDE (OFB)    |"
echo "|4 - DES EDE (ECB)    |"
echo "|0 - voltar           |"
echo "|=====================|"						
read operacao
if [ $operacao -eq 1 ]
then
	clear
	dedCBC ""
elif [ $operacao -eq 2 ]
then
	clear
	dedcfb ""
elif [ $operacao -eq 3 ]
then
	clear
	dedofb ""
	echo "aqui acontece a Cifra com os seguintes parâmetros $1, $2, $3, $4"		dedeecb ""
elif [ $operacao -eq 0 ]
then
	clear
	DecifraDES ""
else
clear
	DecifraDES_EDE ""
	echo "Opção não reconhecida"
fi
}

DecifraDES_EDE3(){
echo "==== Decifra DES EDE3 ===="
echo "|                      |"						
echo "|1 - DES EDE3 (CBC)    |"
echo "|2 - DES EDE3 (CFB)    |"
echo "|3 - DES EDE3 (OFB)    |"
echo "|4 - DES EDE3 (ECB)    |"
echo "|0 - voltar            |"
echo "|======================|"	
read operacao
if [ $operacao -eq 1 ]
then
	clear
	ded3CBC ""
elif [ $operacao -eq 2 ]
then
	clear
	aes128cbc ""
elif [ $operacao -eq 3 ]
then
	clear
	aes128cbc ""
	echo "aqui acontece a Cifra com os seguintes parâmetros $1, $2, $3, $4"		aes128cbc ""
elif [ $operacao -eq 0 ]
then
	clear
	DecifraDES ""
else
clear
	DecifraDES_EDE3 ""
	echo "Opção não reconhecida"
fi
}

DecifraC4(){
echo "========== Decifra RC4 =========="
echo "|                               |"
echo "|1 - RC4 128                    |"
echo "|2 - RC4 64                     |"
echo "|3 - RC4 40                     |"
echo "|0 - voltar                     |"
echo "|===============================|"	
read operacao
if [ $operacao -eq 1 ]
then
	clear
	rc4 ""
elif [ $operacao -eq 2 ]
then
	clear
	rc464 ""
elif [ $operacao -eq 3 ]
then
	clear
	rc440 ""
elif [ $operacao -eq 0 ]
then
	clear
	Decifrar ""
else
clear
	DecifraC4 ""
	echo "Opção não reconhecida"
fi
}

AssinDigit(){
echo "|===========Escolha a operação desejada===========|"
echo "|                                                 |"
echo "|1 - Calculo de assinaturas digitais RSA-SHA256   |"
echo "|2 - Verificação assinaturas digitais RSA-SHA256  |"
echo "|0 - voltar                                       |"
echo "|=================================================|"		
read operacao
if [ $operacao -eq 1 ]
then
	escoOper ""
elif [ $operacao -eq 2 ] 
then
echo "#Verificação de assinaturas digitais (RSA-SHA256)"
echo
read -p "#Introduza o ficheiro que contém a chave pública " pubchave
pubchave="${pubchave}"
echo "$pubchave"
echo
read -p "#Introduza o ficheiro assinado " assinado
assinado="${assinado}"
echo "$assinado"
echo
read -p "#Introduza o ficheiro original (não assinado) " original
original="${original}"
echo "$original"
echo
openssl dgst -sha256 -verify "$pubchave" -signature "$assinado" "$original"           

elif [ $operacao -eq 0 ]
then
	clear
	MenuPrincipal ""
else
clear
	AssinDigit ""
	echo "Opção não reconhecida"
fi
}

escoOper(){
echo "|===========Escolha a operação desejada===========|"
echo "|                                                 |"
echo "|1 - Gerar chaves (privada e publica)             |"
echo "|2 - Gerar chave publica                          |"
echo "|3 - Assinar digitalmente                         |"
echo "|0 - voltar                                       |"
echo "|=================================================|"
read operacao                       
if [ $operacao -eq 1 ]
then
#Geração da chave privada
openssl genrsa -out privkey.pem 2048	
#Geração da chave publica
openssl rsa -in privkey.pem -out pubkey.pem -outform PEM -pubout	
echo "Operação concluida com sucesso"
echo "OBS: A sua chave privada está no ficheiro ###PRIVKEY.PEM### (Poderá alterar o nome logo) e a chave pública ###PUBKEY.PEM####"

elif [ $operacao -eq 2 ]
then
read -p "#Introduza o nome do ficheiro que contém a chave privada: " privk
privk="${privk}"
echo "$privk"
openssl rsa -in "$privk" -out pubkey.pem -outform PEM -pubout
echo "Operação concluida com sucesso"
echo "OBS: A sua a chave pública está no ficheiro com o nome ###PUBKEY.PEM#### (Poderá alterar o nome logo) "

elif [ $operacao -eq 3 ]
then
	clear
read -p "#Introduza o nome to ficheiro que pretende assinar " tosignfile
tosignfile="${tosignfile}"
echo "$tosignfile"
echo
read -p "#Introduza o ficheiro com a chave privada " privkk
privkk="${privkk}"
echo "$privkk"
read -p "#Introduza o nome do ficheiro de saída " signedfile
signedfile="${signedfile}"
echo "$signedfile"
openssl dgst -sha256 -sign "$privkk" -out "$signedfile" "$tosignfile"  
echo "Operação concluida com sucesso"
elif [ $operacao -eq 0 ]
then
	clear
	AssinDigit ""
else
clear
	escoOper ""
	echo "Opção não reconhecida"
fi
}

#==============================================Calcular HASH ================================================================================
CalcHash(){
echo "|==Escolha a operação desejada==|"
echo "|                               |"
echo "|1 - MD5                        |"
echo "|2 - SHA1                       |"
echo "|3 - SHA256                     |"
echo "|4 - SHA512                     |"
echo "|0 - voltar                     |"
echo "|===============================|"
read operacao      
if [ $operacao -eq 1 ]
then
clear
hashMD5 ""
echo "HASH (MD5) calculado com sucesso"
elif [ $operacao -eq 2 ]
then
clear
hashSHA1 ""
echo "HASH (SHA1) calculado com sucesso"
elif [ $operacao -eq 3 ]
then
	clear
	hashSHA256 ""
echo "HASH (SHA256) calculado com sucesso"
elif [ $operacao -eq 4 ]
then
clear
	hashSHA512 ""
echo "HASH (SHA512) calculado com sucesso"
elif [ $operacao -eq 0 ]
then
	clear
	MenuPrincipal ""
else
clear
	CalcHash ""
	echo "Opção não reconhecida"
fi	
}

#====================================Calcular e verificar HMAC"=======================================
CalcVerifHMAC(){
echo "|==Escolha a operação desejada==|"
echo "|                               |"
echo "|1 - Calcular HMAC              |"
echo "|2 - Verificar HMAC             |"
echo "|0 - voltar                     |"
echo "|===============================|"
read operacao
if [ $operacao -eq 1 ]
then
	clear
	hmacSHA256 ""
elif [ $operacao -eq 2 ]
then
	clear
	verifHMAC ""
elif [ $operacao -eq 0 ]
then
	clear
	MenuPrincipal ""
else
	clear
	CalcVerifHMAC ""
	echo "Opção não reconhecida"	
fi
}

verifHMAC(){
echo "|===Verificação HMAC===|"
echo "|                      |"
echo "|1 - SHA256            |"
echo "|2 - SHA512            |"
echo "|0 - voltar            |"
echo "|======================|"     
read operacao
if [ $operacao -eq 1 ]
then
	hmacSHA256 ""
	echo "HMAC (SHA256) calculado com sucesso"
elif [ $operacao -eq 2 ]
then
	hmacSHA512 ""
	echo "HMAC (SHA512) calculado com sucesso"
elif [ $operacao -eq 0 ]
then
	clear
	CalcVerifHMAC ""
else
	clear
	verifHMAC ""
	echo "Opção não reconhecida"
fi	
}
AlgCodBase64(){
echo "|===Escolha a operação===|"
echo "|                        |"
echo "|1 - Codificar           |"
echo "|2 - Descodificar        |"
echo "|0 - voltar              |"
echo "|========================|"		
read operacao
if [ $operacao -eq 1 ]
then
	base64 ""
elif [ $operacao -eq 2 ]
then
	base64desc ""
elif [ $operacao -eq 0 ]
then
	clear
	MenuPrincipal ""
else
	clear
	AlgCodBase64 ""
	echo "Opção não reconhecida"
fi
}
gerCertX509(){
echo "|===operação com certificado X509====|"
echo "|                                    |"
echo "|1 - Gerar certificado auto-assinado |"
echo "|2 - Converter de PEM para DER       |"
echo "|0 - voltar                          |"
echo "|====================================|"		
read operacao
if [ $operacao -eq 1 ]
then
clear
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt
elif [ $operacao -eq 2 ]
then
clear
	openssl x509 -outform der -in certificate.pem -out certificate.der
else
	clear
	AlgCodBase64 ""
	echo "Opção não reconhecida"
fi
echo "Gerar um certificado auto-assinado"
 openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout privateKey.key -out certificate.crt
}
#=================================================================================FIM=========================================================
		
#==========================================Fim=======================================================


#=====================================Fim decifra

#==============================================Aqui inícia os scripts para as funções de cifra==============================================
 
#=============================================Inicio da função para cifra "AES256cbc"=======================================================
aes256cbc(){
        read -p "#Introduza a chave de cifra (deixe em branco para gerar uma aleatória):" chave
        chave="${chave}"
	tipo_cifra="CBC"
        echo "$chave"
        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"


        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -d -aes-256-cbc -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	clear
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo

	}

#================================fim das funções de cifra===============================================

#================================Inicio das funções de decifra=====================================



#=============================================Fim da função para cifra "AES256cbc"========================================================
#=============================================Inicio da função para cifra "AES192cbc"=======================================================
aes192cbc(){
        
        read -p "#Introduza a chave de cifra (deixe em branco para gerar uma aleatória):" chave
        chave="${chave}"
        echo "$chave"
	echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-192-cbc -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES192cbc"========================================================

#=============================================Inicio da função para cifra "AES128cbc"=======================================================
aes128cbc(){
        
        read -p "#Introduza a chave de cifra (deixe em branco para gerar uma aleatória):" chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI 
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-cbc -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128cbc"========================================================

#=============================================Inicio da função para cifra "AES256cfb"========================================================
aes256cfb(){
        
        read -p "#Introduza a chave de cifra (deixe em branco para gerar uma aleatória):" chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 256
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-256-cfb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES256cfb"========================================================

#=============================================Inicio da função para cifra "AES192cfb"=======================================================
aes192cfb(){
        
        read -p "#Introduza a chave de cifra (deixe em branco para gerar uma aleatória):" chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 192
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-192-cfb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES192cfb"========================================================

#=============================================Inicio da função para cifra "AES128cfb"=======================================================
aes128cfb(){
        
        read -p "#Introduza a chave de cifra (deixe em branco para gerar uma aleatória):" chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-cfb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128cbc"========================================================

#=============================================Inicio da função para cifra "AES256cfb1"=======================================================
aes256cfb1(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 256
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-256-cfb1 -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES256cfb1"========================================================

#=============================================Inicio da função para cifra "AES192cfb"========================================================
aes192cfb1(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 192
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-192-cfb1 -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES192cfb1"========================================================

#=============================================Inicio da função para cifra "AES128cfb1"======================================================
aes128cfb1(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-cfb1 -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128cfb1"=========================================================

#=============================================Inicio da função para cifra "AES256cfb8"======================================================
aes256cfb8(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 256
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-256-cfb8 -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#===============================================Fim da função para cifra "AES256cfb8"========================================================

#=============================================Inicio da função para cifra "AES192cfb8"=======================================================
aes192cfb8(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 192
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-192-cfb8 -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#===============================================Fim da função para cifra "AES192cfb8"========================================================

#=============================================Inicio da função para cifra "AES128cfb8"=======================================================
aes128cfb8(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-cfb8 -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128cfb8"========================================================

#=============================================Inicio da função para cifraAES256ctr"==========================================================
aes256ctr(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 256
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -aes-256-ctr -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}

#=============================================Fim da função para cifraAES256ctr"==========================================================

#=============================================Inicio da função para cifra "AES192ctr"========================================================
aes192ctr(){

        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
        if [ -Z $chave ]
                then
                        openssl rand -hex 192
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-192-ctr -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES192ctr"==========================================================

#=============================================Inicio da função para cifra "AES128ctr"=======================================================
aes128ctr(){

        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-ctr -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128ctr"==========================================================

#=============================================Inicio da função para cifra "AES256ecb"=======================================================
aes256ecb(){
	
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 256
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -aes-256-ecb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES256ecb"===========================================================

#=============================================Inicio da função para cifra "AES192ecb"========================================================
aes192ecb(){
	
	read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 192
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl enc -aes-192-ecb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES192ecb"===========================================================

#=============================================Inicio da função para cifra "AES128ecb"========================================================
aes128ecb(){
	
	read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl enc -aes-128-ecb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128ecb"===========================================================

#=============================================Inicio da função para cifra "AES256ofb"========================================================
aes256ofb(){
	
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 256
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -aes-256-ofb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES256ofb"===========================================================

#=============================================Inicio da função para cifra "AES192ofb"========================================================
aes192ofb(){
	
	read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 192
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl enc -aes-192-ofb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES192ofb"===========================================================

#=============================================Inicio da função para cifra "AES128ofb"========================================================
aes128ofb(){
	
	read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"
	if [ -Z $nomeE ]
                then
                    read -p "#Msg): " nomeE
        		nomeE="${nomeE}"
        		cat > "$nomeE"
                 fi

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl enc -aes-128-ofb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=============================================Fim da função para cifra "AES128ofb"===========================================================

#==========================================Inicio da função para codificação do algoritimo de "Base64"=======================================
base64(){
	echo "aqui acontece a Codificação de algoritimo de base64"
	
        read -p "#Introduza o nome de ficheiro de entrada com a extenção .bin: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída com a extenção .b64: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"
			     #.bin        #.b64
	openssl base64 -in "$nomeE" -out "$nomeS"
	echo
	echo "Ficheiro codificado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}
#=============================================Fim da função para cifra "Base64"===========================================================
descbc(){
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -des-cbc -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
descfb(){
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -des-ofb -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
desecb(){
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -des-ecb -K "$chave" -in "$nomeE" -out "$nomeS"
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}      
#=======================================================Inicio da função para cifra "RC4"====================================================
rc4(){

        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave #chave de cifra
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 128
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada ou deixe vazio para escrever uma mensagem: " nomeE #nome do ficheiro de entrada
        nomeE="${nomeE}"
        echo "$nomeE"
	if [-Z $nomeE]
		then
			openssln enc -rc4 -K "$chave" -in echo " " -out "$nomeS"
		fi

        read -p "#Introduza o nome do ficheiro de saida: " nomeS #nome do ficheiro de saida
        nomeS="${nomeS}"
        echo "$nomeS"

	tipo_cifra="RC4"


        openssl enc -rc4 -K "$chave" -in "$nomeE" -out "$nomeS"
 	
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=================================================Fim da função para cifra "RC4_128"=========================================================

#=================================================Inicio da função para cifra "RC4_64"======================================================
#Inicio da função para cifra "RC4_64"
rc464(){

        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave #chave de cifra
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 64
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada ou deixe vazio para escrever uma mensagem: " nomeE #nome do ficheiro de entrada
        nomeE="${nomeE}"
        echo "$nomeE"
	if [-Z $nomeE]
		then
			openssln enc -rc4 -K "$chave" -in echo " " -out "$nomeS"
		fi

        read -p "#Introduza o nome do ficheiro de saida: " nomeS #nome do ficheiro de saida
        nomeS="${nomeS}"
        echo "$nomeS"

	tipo_cifra="RC4"


        openssl enc -rc4 -K "$chave" -in "$nomeE" -out "$nomeS"
 	
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=================================================Fim da função para cifra "RC4_64"=========================================================

#=================================================Inicio da função para cifra "RC4_40"======================================================

#Inicio da função para cifra "RC4_40"
rc440(){

        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave #chave de cifra
        chave="${chave}"
        echo "$chave"
	if [ -Z $chave ]
                then
                        openssl rand -hex 40
                 fi
        echo

        read -p "#Introduza o nome de ficheiro de entrada ou deixe vazio para escrever uma mensagem: " nomeE #nome do ficheiro de entrada
        nomeE="${nomeE}"
        echo "$nomeE"
	if [-Z $nomeE]
		then
			openssln enc -rc4 -K "$chave" -in "$nomeE" -out "$nomeS"
		fi

        read -p "#Introduza o nome do ficheiro de saida: " nomeS #nome do ficheiro de saida
        nomeS="${nomeS}"
        echo "$nomeS"

	tipo_cifra="RC4"


        openssl enc -rc4-40 -K "$chave" -in "$nomeE" -out "$nomeS"
 	
	echo
	echo "Ficheiro cifrado com sucesso!"
	echo
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
	echo
}
#=================================================Fim da função para cifra "RC4_40"=========================================================


#====================================================================================================Fim das funções para operações de cifra



#Inicio das funções para DECifrar===========================================================================================================

#=============================================Inicio da função para DECifrar com RC4========================================================
rc4DEC(){

        read -p "#Introduza a chave de cifra: " chave #chave de cifra
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE #nome do ficheiro de entrada
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS #nome do ficheiro de saida
        nomeS="${nomeS}"
        echo "$nomeS"

	tipo_cifra="RC4"


        openssl enc -rc4 -K "$chave" -in "$nomeE" -out "$nomeS"
 	
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}
#=============================================Fim da função para DECifrar com RC4===========================================================


#=============================================Inicio da função para DECifrar com AES128ecb==================================================
aes128ecbDEC(){
	
	read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl enc -aes-128-ecb -d -K "$chave" -in "$nomeE" -out "$nomeS"
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}
#=============================================Fim da função para DECifrar com AES128ecb===================================================

aes128cbcDEC(){
        
        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-cbc -d -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}

	aes128crtDEC(){

        read -p "#Introduza a chave de cifra (ou deixe em branco para gerar uma aleatória): " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada (deixar em branco para cifrar uma mensagem do teclado): " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        read -p "#Introduza o vetor de inicialização: " vetorI
        vetorI="${vetorI}"
        echo "$vetorI"

        openssl enc -aes-128-crt -d -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}


aes256ecbDEC(){
	
        read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -aes-256-ecb -d -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}

aes256cbcDEC(){
        read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -aes-256-cbc -d -K "$chave" -in "$nomeE" -out "$nomeS" -iv "$vetorI"
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}

aes256crtDEC(){
        
        read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saida: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

        openssl enc -aes-256-crt -d -K "$chave" -in "$nomeE" -out "$nomeS"
	echo
	echo "Ficheiro DECifrado com sucesso:"
	echo "Cifra utilizada: $tipo_cifra"
	echo "Chave de cifra: $chave"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}

#=============================================Inicio da função para DECifrar "Base64"========================================================
base64desc(){
	echo "aqui acontece o algoritimo de descodificação base64"

        read -p "#Introduza o nome de ficheiro de entrada com a extenção .b64: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída com a extenção .bin: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"
			        #.b64        #.bin
        openssl base64 -d -in "$nomeE" -out "$nomeS"

	echo
	echo "Ficheiro cifrado com sucesso!"
	echo "Algorítimo utilizado: $tipo_cifra"
	echo "Ficheiro de saida: $nomE"
	echo "Ficheiro de entrada: $nomeS"
}
#=============================================Fim da função para Descodificar "Base64"=======================================================

#Fim dos scripts das operações para DECifrar-================================================================================================

#====================================================Inicio das funções de HASH==============================================================

hashMD5(){
        echo "HASH MD5"

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -md5 "$nomeE" > "$nomeS"
        
}


hashSHA1(){
        echo "HASH SHA1"

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha1 "$nomeE" > "$nomeS"
        
}

hashSHA256(){
        echo "HASH SHA256"

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha256 "$nomeE" > "$nomeS"
        
}

hashSHA512(){
        echo "HASH SHA512"

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha512 "$nomeE" > "$nomeS"
        
}

#====================================================================================



#=======================Inicio das funções para calcular HMAC==============================================
hmacSHA256(){
        echo "HMAC SHA256"

	read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha256 -hmac "$chave" "$nomeE" > "$nomeS"
        
}

hmacSHA512(){
	echo "HMAC SHA512"
        
	read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha512 -hmac "$chave" "$nomeE" > "$nomeS"
        
}
#===================================================================FIM======================================================================

#==========================================Inicio das funções para verificar HMAC============================================================
hmacSHA512Verificacao(){
	echo "Verificação de HMAC (SHA512)"
        
	read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha512 -hmac "$chave" "$nomeE" > "$nomeS"

        read -p "#Introduza o ficheiro com o HMAC calculado: " nomeSS
        nomeSS="${nomeSS}"
        echo "$nomeSS"

        if diff nomeSS nomeS >/dev/null 2>&1
                then
                echo "Os ficheiros são iguais"
        else
                echo "Os ficheiros são iguais"
        fi
        
}

hmacSHA256Verificacao(){
	echo "Verificação de HMAC (SHA256)"
        
	read -p "#Introduza a chave de cifra: " chave
        chave="${chave}"
        echo "$chave"
        echo

        read -p "#Introduza o nome de ficheiro de entrada: " nomeE
        nomeE="${nomeE}"
        echo "$nomeE"

        read -p "#Introduza o nome do ficheiro de saída: " nomeS
        nomeS="${nomeS}"
        echo "$nomeS"

	openssl dgst -sha256 -hmac "$chave" "$nomeE" > "$nomeS"

        read -p "#Introduza ficheiro com o HMAC calculado: " nomeSS
        nomeSS="${nomeSS}"
        echo "$nomeSS"

        if diff nomeSS nomeS >/dev/null 2>&1
                then
                echo "Os ficheiros são iguais"
        else
                echo "Os ficheiros são diferentes"
        fi       
}

#=====================================================FIM das funções de HMAC================================================================
#===============================================================Operações de Cifra==========================================================
biblioteca="openssl"
versao=1.0
#Tela inicial
echo "============Operar com openssl=============="
echo "|                                          |"
echo "|Bem-vindo ao OpenEasySSL	           |"
echo "|                                          |"
echo "|1 - Abrir                                 |"
echo "|2 - Sair                                  |"
echo "|==========================================|"
read operacao
echo "Opcao $operacao selecionada"
if [ $operacao -eq 1 ]
	then
		clear
		MenuPrincipal " "

elif [ $operacao -eq 2 ]
	then
		clear
		Sair ""

else
		clear
		./T3_JoseB_JoseP_Junior_Hermenegildo.sh
	fi
