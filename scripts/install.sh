#!/bin/bash
apt-get update && apt-get upgrade -y

sleep 30

# docker
apt-get install net-tools apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
apt-get update && apt install docker-ce
systemctl enable docker
systemctl start docker

apt install figlet lolcat tmate python proxychains openvpn golang nmap masscan recon-ng awscli python3-pip build-essential -y

# prettify motd
ln -s /usr/games/locat /usr/local/bin
git clone https://github.com/xero/figlet-fonts.git /tmp/ffonts
mv /tmp/ffonts/* /usr/share/figlet/
rm /etc/update-motd.d/*
echo '#!/bin/bash' > /etc/update-motd.d/01-prism
echo 'figlet -f s-relief prism | /usr/games/lolcat -p 2 -f' >> /etc/update-motd.d/01-prism
chmod +x /etc/update-motd.d/01-prism
cp /home/ubuntu/.bashrc /root/.bashrc

# covenant
# cd /opt/Covenant && dotnet run
wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
dpkg -i packages-microsoft-prod.deb
apt-get update
apt install dotnet-sdk-3.1 -y
mkdir /opt/Covenant
git clone --recurse-submodules https://github.com/cobbr/Covenant /opt/Covenant

# empire
# to start run ./empire --rest (--headless?) and login empireadmin/password123
mkdir /opt/Empire
git clone https://github.com/BC-SECURITY/Empire.git /opt/Empire

# metasploit
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > /tmp/msfinstall
chmod 755 /tmp/msfinstall
bash /tmp/msfinstall

# env
mkdir -p /opt/git
mkdir -p $HOME/go/src
echo "GOPATH=$HOME/go" >> /home/ubuntu/.bashrc
export "GOPATH=$HOME/go" >> /home/ubuntu/.bashrc
mkdir /opt/windows-resources
mkdir /opt/windows-binaries
mkdir /opt/linux-resources
mkdir /opt/linux-binaries
mkdir -p /opt/shells/webshells
mkdir /opt/wordlists

# main prism resource files
git clone https://github.com/g0x0dvibes/prism-resources.git /opt/prism-resources
mv /opt/prism-resources/* /opt
mv /opt/linux-binaries/x64/impacket/* /usr/local/bin
rm -rf /opt/linux-binaries/x64/impacket/

# go stuff
go get github.com/ffuf/ffuf && mv "$GOPATH/bin/ffuf" /usr/local/bin/
go get github.com/OJ/gobuster && mv "$GOPATH/bin/gobuster" /usr/local/bin/
go get github.com/hakluke/hakrawler && mv "$GOPATH/bin/hakrawler" /usr/local/bin/
go get github.com/haccer/subjack && mv "$GOPATH/bin/subjack" /usr/local/bin/
GO111MODULE=on go get -u github.com/projectdiscovery/chaos-client/cmd/chaos && mv $GOPATH/bin/chaos /usr/local/bin/

# webapp tools
git clone https://github.com/maurosoria/dirsearch.git /opt/dirsearch
ln -s /opt/dirsearch/dirsearch.py /usr/local/bin/dirsearch
git clone https://github.com/flozz/p0wny-shell.git /opt/shells

#spiderfoot
wget https://github.com/smicallef/spiderfoot/archive/v3.1.tar.gz
tar zxvf v3.1.tar.gz
cd spiderfoot-3.1/
pip3 install -r requirements.txt
cd ../
mv spiderfoot-3.1/ /opt/spiderfoot
ln -s /opt/spiderfoot/sf.py /usr/local/bin/spiderfoot 

# pspy
git clone https://github.com/DominicBreuker/pspy.git /opt/linux-resources/pspy

# sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git /opt/sqlmap/ && ln -s /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap
chmod +x /opt/sqlmap/sqlmap.py
ln -s /opt/sqlmap/sqlmap.py /usr/local/bin/sqlmap

wget https://github.com/Edu4rdSHL/findomain/releases/latest/download/findomain-linux -O /tmp/finddomain && chmod +x /tmp/finddomain && mv /tmp/finddomain /usr/local/bin/

# privesc scripts
git clone --branch dev https://github.com/PowerShellMafia/PowerSploit.git /opt/windows-resources/PowerSploit
git clone https://github.com/pentestmonkey/windows-privesc-check.git /opt/windows-resources/windows-privesc-check
git clone https://github.com/bitsadmin/wesng.git /opt/windows-resources/wesng
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite.git /opt/PEAS

git clone https://github.com/diego-treitos/linux-smart-enumeration.git /opt/linux-resources/linux-smart-enumeration
git clone https://github.com/rebootuser/LinEnum.git /opt/linux-resources/LinEnum
git clone https://github.com/sleventyeleven/linuxprivchecker.git /opt/linux-resources/linuxprivchecker


# wordlists
git clone https://github.com/danielmiessler/SecLists.git /opt/wordlists/seclists
git clone https://github.com/SilverPoision/a-full-list-of-wordlists.git /opt/wordlists/burp-pack

# cleanup
rm packages-microsoft-prod.deb
rm install.sh
rm v3.1.tar.gz
rm -rf go/src/*