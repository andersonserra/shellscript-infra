#!/bin/bash

#carregamento de variaveis de sistema
. /etc/os-release


case $ID in
centos)
echo -e "\n## Script para atualização manual de chaves rsa publicas de usuarios ###\n\n"
read -p 'Digite o nome do usuario: ' usuario
password=`openssl rand -base64 8`
useradd -m -s /bin/bash $usuario | grep -v exist
echo "$usuario:$password" | chpasswd
read -p 'Insira o conteudo da chave publica: ' chavepublica
mkdir /home/$usuario/.ssh | grep -v exist
echo "$chavepublica" > /home/$usuario/.ssh/authorized_keys
chmod 700 /home/$usuario/.ssh
chmod 600 /home/$usuario/.ssh/authorized_keys
chmod -R go= /home/$usuario/.ssh
chown $usuario:$usuario -R /home/$usuario/.ssh
groupadd clientes > /dev/null
usermod -aG wheel,clientes $usuario
passwd -e $usuario
echo -e "\nDados para informar ao cliente...\n\n\n"
echo -e "\n\n-----------------------------------------------------------------------------------------------"
echo "Servidor: `hostname -I`"
echo -e "\nDados do usuário:\nnome do usuario: $usuario\nSenha temporaria: $password\nChave pública: $chavepublica\n\n"
echo -e "--------------------------------------------------------------------------------"
        ;;
debian)
echo -e "\n## Script para atualização manual de chaves rsa publicas de usuarios ###\n\n"
read -p 'Digite o nome do usuario: ' usuario
password=`openssl rand -base64 8`
useradd -m -s /bin/bash $usuario
echo "$usuario:$password" | chpasswd
read -p 'Insira o conteudo da chave publica: ' chavepublica
mkdir /home/$usuario/.ssh | grep -v exist
echo "$chavepublica" > /home/$usuario/.ssh/authorized_keys
chmod 700 /home/$usuario/.ssh
chmod 600 /home/$usuario/.ssh/authorized_keys
chmod -R go= /home/$usuario/.ssh
chown $usuario:$usuario -R /home/$usuario/.ssh
addgroup clientes
apt-get install -y sudo > /dev/null
usermod -aG sudo,clientes $usuario
passwd -e $usuario
echo -e "\nDados para informar ao cliente...\n\n\n"
echo -e "\n\n-----------------------------------------------------------------------------------------------"
echo "Servidor: `hostname -I`"
echo -e "\nDados do usuário:\nnome do usuario: $usuario\nSenha temporaria: $password\nChave pública: $chavepublica\n\n"
echo -e "--------------------------------------------------------------------------------"
        ;;
ubuntu)
echo -e "\n## Script para atualização manual de chaves rsa publicas de usuarios ###\n\n"
read -p 'Digite o nome do usuario: ' usuario
password=`openssl rand -base64 8`
useradd -m -s /bin/bash $usuario | grep -v exist
echo "$usuario:$password" | chpasswd
read -p 'Insira o conteudo da chave publica: ' chavepublica
mkdir /home/$usuario/.ssh | grep -v exist
echo "$chavepublica" > /home/$usuario/.ssh/authorized_keys
chmod 700 /home/$usuario/.ssh
chmod 600 /home/$usuario/.ssh/authorized_keys
chmod -R go= /home/$usuario/.ssh
chown $usuario:$usuario -R /home/$usuario/.ssh
addgroup clientes
apt-get install -y sudo > /dev/null
usermod -aG sudo,clientes $usuario
passwd -e $usuario
echo -e "\nDados para informar ao cliente...\n\n\n"
echo -e "\n\n--------------------------------------------------------------------------------"
echo "Servidor: `hostname -I`"
echo -e "\nDados do usuário:\nnome do usuario: $usuario\nSenha temporaria: $password\nChave pública: $chavepublica\n\n"
echo -e "--------------------------------------------------------------------------------"
        ;;
esac

