# Print Welcome Message
clear
echo "----------------------------------------------------"
echo "  Cpanel Auto Installer - Centos 7.x"
echo "  Author: ZarinNegah"
echo "  Telegram: https://t.me/MTProtoConfiger"
echo "----------------------------------------------------"
echo ""

#Check OS
if [ -n "$(grep 'Aliyun Linux release' /etc/issue)" -o -e /etc/redhat-release ]; then
  OS=CentOS
  [ -n "$(grep ' 7\.' /etc/redhat-release)" ] && CentOS_RHEL_version=7
  [ -n "$(grep ' 6\.' /etc/redhat-release)" -o -n "$(grep 'Aliyun Linux release6 15' /etc/issue)" ] && CentOS_RHEL_version=6
  [ -n "$(grep ' 5\.' /etc/redhat-release)" -o -n "$(grep 'Aliyun Linux release5' /etc/issue)" ] && CentOS_RHEL_version=5
elif [ -n "$(grep 'Amazon Linux AMI release' /etc/issue)" -o -e /etc/system-release ]; then
  OS=CentOS
  CentOS_RHEL_version=6
else
  echo "${CFAILURE}Does not support this OS, Please contact the author! ${CEND}"
  kill -9 $$
fi

# Firewalld
if [ ${OS} == CentOS ];then
  yum install firewalld -y
  systemctl enable firewalld
  systemctl start firewalld
  systemctl status firewalld
fi

# Update and Install Package
if [ ${OS} == CentOS ];then
  yum update -y
  yum upgrade -y
  yum install yum* wget nano curl tmux perl setuptool ntsysv system-config-firewall system-config-network-tui* -y
  yum install -y gcc gcc-c++ gettext strace automake strace64 gdb bison libtool tar zip perl curl tmux tcp_wrappers-devel wget
  sudo yum install epel-release -y
  sudo yum search htop -y
  sudo yum info htop -y
  sudo yum install htop -y
fi

# Get Native IP Address
IP=$(curl -4 -s ip.sb)

# Set Hostname
hostnamectl set-hostname server.connecttome.click

# Cpanel Configer
if [ ${OS} == CentOS ];then
  curl -o latest -L https://securedownloads.cpanel.net/latest
  tmux new-session -s foo 'sh latest'
fi

# Plugin
cd
/usr/local/cpanel/scripts/install_lets_encrypt_autossl_provider
cd
cd /bin
wget https://getcomposer.org/installer
chmod 777 installer
php installer --check
php installer

# Finnish
echo ""
echo "Cpanel Successful auto Installation！"
echo ""
