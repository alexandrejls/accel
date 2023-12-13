#!/bin/bash
#
# Certifique-se de que o script está salvo em UTF-8. No terminal, você pode verificar e alterar a codificação usando:
  # file -bi seu_script.sh
# Se a codificação não estiver correta, você pode convertê-la para UTF-8 usando iconv:
  # iconv -f ISO-8859-1 -t UTF-8 seu_script.sh > seu_script_utf8.sh
# Configurações iniciais -*- ENCODING: UTF-8 -*-
export LC_CTYPE=pt_BR.UTF-8
export LANG=pt_BR.UTF-8
export LC_ALL=pt_BR.UTF-8
force_color_prompt=yes # Permite ativar cores no prompt do terminal
export DEBIAN_FRONTEND="noninteractive" # Não solicitar telas de configuração

SCRIPT_LOG='/root/script/accel-ppp/concluido/'
MODIFICADOS='/root/script/accel-ppp/modificados/'

mkdir -p /root/script/accel-ppp/log/
mkdir -p $SCRIPT_LOG
mkdir -p $MODIFICADOS

ERRO='\e[31m'
SUCESSO='\e[32m' 
INFO='\e[34m'
AGUARDE='\e[36m'
FEITO='\e[5m \e[33m'
SEPARADOR='echo -e "\e[0m#=========================================================================================#"'
LIMPA='\e[0m'
ESPACO="           "
clear
# CORES
# https://misc.flogisoft.com/bash/tip_colors_and_formatting
S2='sleep 1'
S3='sleep 2'
clear
###########################################################################################################################
# AUTOR
AUTOR="Script feito por: Alexandre Jorge"
CRIACAO="Criado em: 22/06/2022"
ATUALIZACAO="Atualizado em: 12/12/2023"
$SEPARADOR
echo $AUTOR && echo $CRIACAO && echo $ATUALIZACAO
###########################################################################################################################
$SEPARADOR 
###########################################################################################################################
echo -e "${INFO} ::::: Verificando ifconfig ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
COMANDO="ifconfig"
if ! command -v ifconfig &> /dev/null; then
    echo "${ESPACO}${COMANDO} não está instalado. Instalando..."
    # Instala o pacote ifconfig
    apt-get update &> /dev/null
    apt-get install net-tools -y &> /dev/null
    echo -e "${ESPACO}${FEITO}${COMANDO}${LIMPA} instalado com sucesso!"
else
    echo -e "${ESPACO}${FEITO}${COMANDO}${LIMPA} está instalado."
fi
###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
echo -e "${INFO} ::::: Verificando vim ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
COMANDO="vi"
apt-get autoremove vim-tiny -y  &> /dev/null
if ! command -v vi &> /dev/null; then
    echo "${ESPACO}${COMANDO} não está instalado. Instalando..."
    
    # Instala o pacote ifconfig
    apt-get update &> /dev/null
    apt-get install vim -y &> /dev/null
    echo -e "${ESPACO}${FEITO}${COMANDO}${LIMPA} instalado com sucesso!"
else
    echo -e "${ESPACO}${FEITO}${COMANDO}${LIMPA} está instalado."
fi
###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
echo -e "${INFO} ::::: Remove apt cdrom do sources.list ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
# Linha
linha="cdrom"
# Caminho
arquivo="/etc/apt/sources.list"

if grep -qF "$linha" "$arquivo"; then
    # Remove a linha do arquivo
    sed -i "/$linha/d" "$arquivo"
    echo "${ESPACO}linha foi removida do $arquivo"
else
    echo "${ESPACO}linha não existe no $arquivo"
fi
###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
echo -e "${INFO} ::::: Verificando dependência ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
COMANDO="libsnmp-dev"
# Verifica se o libsnmp-dev está instalado
if dpkg -l | grep -q libsnmp-dev; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}${COMANDO} não está instalado."
    apt-get update &> /dev/null
    apt-get install libsnmp-dev -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi
echo
COMANDO="build-essential"
# Verifica se o build-essential está instalado
if dpkg -l | grep -q build-essential; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}${COMANDO} não está instalado."
    apt-get install build-essential -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi
echo
COMANDO="cmake"
# Verifica se o cmake está instalado
if dpkg -l | grep -q cmake; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}${COMANDO} não está instalado."
    apt-get install cmake -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi
echo
COMANDO="gcc"
# Verifica se o gcc está instalado
if dpkg -l | grep -q gcc; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}${COMANDO} não está instalado."
    apt-get install gcc -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi  
echo
COMANDO="linux-headers-`uname -r`"
# Verifica se o gcc está instalado
if dpkg -l | grep -q linux-headers-`uname -r`; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}${COMANDO} não está instalado."
    apt-get install linux-headers-`uname -r` -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi  
echo
COMANDO="git"
# Verifica se o gcc está instalado
if dpkg -l | grep -q git; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install git -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi  
echo
COMANDO="git-man"
# Verifica se o gcc está instalado
if dpkg -l | grep -q git-man; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install git-man -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi  
echo
COMANDO="liberror-perl"
# Verifica se o gcc está instalado
if dpkg -l | grep -q liberror-perl; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install liberror-perl git -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi    
echo
COMANDO="libpcre3-dev"
# Verifica se o gcc está instalado
if dpkg -l | grep -q libpcre3-dev; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install libpcre3-dev -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi    
echo
COMANDO="libssl-dev"
# Verifica se o gcc está instalado
if dpkg -l | grep -q libssl-dev; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install libssl-dev -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi   
echo
COMANDO="liblua5.1-0-dev"
# Verifica se o gcc está instalado
if dpkg -l | grep -q liblua5.1-0-dev; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install liblua5.1-0-dev -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi  
echo
COMANDO="curl"
# Verifica se o curl está instalado
if dpkg -l | grep -q curl; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}$COMANDO não está instalado."
    apt-get install curl -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi   
###########################################################################################################################
$SEPARADOR 
###########################################################################################################################
echo -e "${INFO} ::::: Verificando Webmin ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
COMANDO="webmin"
# Verifica se o webmin está instalado
if dpkg -l | grep -q webmin; then
    echo "${ESPACO}${COMANDO} está instalado."
else
    echo "${ESPACO}${COMANDO} não está instalado."
    bash webmin.sh
    echo -e "Iniciando instalação. \n Aguarde..."
  apt-get install --install-recommends webmin -y &> /dev/null
    echo "${ESPACO}${COMANDO} foi instalado com sucesso."
fi
###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
echo -e "${INFO} ::::: Instalação do accel-ppp ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
echo -e "fim 90"
echo -e "fim aqui sleep"
sleep 90
echo -e "falta 3"
sleep 90
echo -e "falta 2"
sleep 90
echo -e "falta 1"
sleep 90
mkdir -p /usr/local/src/accel/build
cd /usr/local/src/accel/build
git clone https://github.com/xebd/accel-ppp.git accel-ppp.git
cp -a build/accel-ppp.git accel-ppp
cmake \
-DCPACK_TYPE=${RELEASE} \
-DBUILD_IPOE_DRIVER=TRUE \
-DBUILD_VLAN_MON_DRIVER=TRUE \
-DLUA=TRUE \
-DRADIUS=TRUE \
-DNETSNMP=TRUE \
-DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_INSTALL_PREFIX=/usr \
-DKDIR=/usr/src/linux-headers-`uname -r` \
../accel-ppp
make
cpack -G DEB






cp -avx drivers/ipoe/driver/ipoe.ko /lib/modules/$(uname -r)
 cp -avx drivers/ipoe/driver/ipoe.ko /lib/modules/$(uname -r)/kernel/drivers/net
cp drivers/vlan_mon/driver/vlan_mon.ko /lib/modules/$(uname -r)
cp drivers/vlan_mon/driver/vlan_mon.ko /lib/modules/$(uname -r)/kernel/drivers/net
depmod -a
modprobe  vlan_mon
 modprobe  ipoe
 echo "vlan_mon" >> /etc/modules
 echo "ipoe" >> /etc/modules
  

 cpack -G DEB &>>$SCRIPT_LOG/08-accel-ppp-cfg2
 apt install ./accel-ppp.deb &>>$SCRIPT_LOG/08-accel-ppp-cfg2
 systemctl enable accel-ppp &>>$SCRIPT_LOG/08-accel-ppp-cfg2
 echo -e "${SUCESSO}  Realizado com sucesso!!! ${LIMPA}"
$S3 && $S3 && $S3
fi
echo -e "${INFO} ::::: Libera root logar no SSH ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
if [ -f "$SCRIPT_LOG/02-root_ssh" ]; then
    echo -e "${FEITO} Realizado anteriormente!!"  && $S3
    echo -e "${ERRO}   Limpa tela ${LIMPA}" && $S3
    clear
    echo $AUTOR && echo $CRIACAO && echo $ATUALIZACAO
    else
touch $SCRIPT_LOG/02-root_ssh    
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
echo -e "### Libera root logar no SSH" &> $SCRIPT_LOG/02-root_ssh
grep PermitRootLogin /etc/ssh/sshd_config | grep -v "#" &>> $SCRIPT_LOG/02-root_ssh
/etc/init.d/ssh restart 
echo -e "${SUCESSO}  Realizado com sucesso!!! ${LIMPA}"
$S3 && $S3 && $S3
fi
###########################################################################################################################
$SEPARADOR 
###########################################################################################################################

###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################

###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################

###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
echo -e "${INFO} ::::: Criando arquivos do accel-ppp ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
if [ -f "$SCRIPT_LOG/09-arquivos-accel-ppp" ]; then
    echo -e "${FEITO} Realizado anteriormente!!"  && $S3
    echo -e "${ERRO}   Limpa tela ${LIMPA}" && $S3
    clear
    echo $AUTOR && echo $CRIACAO && echo $ATUALIZACAO
    else
touch $SCRIPT_LOG/09-arquivos-accel-ppp
touch /etc/accel-ppp.conf 
touch /etc/chap-secrets 
cat $MODIFICADOS/accel-ppp.conf > /etc/accel-ppp.conf 
cat $MODIFICADOS/chap-secrets > /etc/chap-secrets 
 systemctl restart accel-ppp &>>$SCRIPT_LOG/08-accel-ppp-cfg2
 systemctl status accel-ppp &>>$SCRIPT_LOG/08-accel-ppp-cfg2
echo -e "${SUCESSO}  Realizado com sucesso!!! ${LIMPA}"
$S3 && $S3 && $S3
fi
###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
 echo -e "${INFO} ::::: Criando arquivos do Firewall ::::: ${AGUARDE}\n Aguarde... ${LIMPA}" && $S2
if [ -f "$SCRIPT_LOG/10-firewall" ]; then
    echo -e "${FEITO} Realizado anteriormente!!"  && $S3
    echo -e "${ERRO}   Limpa tela ${LIMPA}" && $S3
    clear
    echo $AUTOR && echo $CRIACAO && echo $ATUALIZACAO
    else
touch $SCRIPT_LOG/10-firewall
apt-get install -y net-tools iptables &>$SCRIPT_LOG/10-firewall
touch /etc/init.d/firewall.sh
ip addr add 100.64.0.1 dev lo && route add -host 100.64.0.1 dev lo
echo "ip addr add 100.64.0.1 dev lo && route add -host 100.64.0.1 dev lo" > /etc/init.d/firewall.sh
ip addr add 100.64.1.1 dev lo && route add -host 100.64.1.1 dev lo
echo "ip addr add 100.64.1.1 dev lo && route add -host 100.64.1.1 dev lo" >> /etc/init.d/firewall.sh
ip addr add 100.64.2.1 dev lo && route add -host 100.64.2.1 dev lo
echo "ip addr add 100.64.2.1 dev lo && route add -host 100.64.2.1 dev lo" >> /etc/init.d/firewall.sh
echo "1" > /proc/sys/net/ipv4/ip_forward
echo "echo "1" > /proc/sys/net/ipv4/ip_forward" >> /etc/init.d/firewall.sh >> /etc/init.d/firewall.sh
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
echo "iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE" >> /etc/init.d/firewall.sh >> /etc/init.d/firewall.sh 
chmod +x /etc/init.d/firewall.sh && chmod 777 /etc/init.d/firewall.sh && chmod +X /etc/init.d/firewall.sh
/etc/init.d/accel-ppp restart
accel-cmd show sessions
echo -e "${SUCESSO}  Realizado com sucesso!!! ${LIMPA}"
$S3 && $S3 && $S3
fi
###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################

###########################################################################################################################
$SEPARADOR && $S3
###########################################################################################################################
