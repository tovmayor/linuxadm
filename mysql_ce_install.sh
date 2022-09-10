
#!/bin/bash
rpm -Uvh https://repo.mysql.com/mysql80-community-release-el7-7.noarch.rpm
sed -i 's/enabled=1/enabled=0/' /etc/yum.repos.d/mysql-community.repo
yum --enablerepo=mysql80-community install mysql-community-server -y
systemctl start mysqld
systemctl enable mysqld
grep "A temporary password" /var/log/mysqld.log
mysql_secure_installation
