#!/bin/bash
user=repluser
pwd=CoolPasswd@2022
MYSQL='mysql --skip-column-names'

for s in mysql '$MYSQL -u$user -p$pwd -e SHOW DATABASES';
    do
#        mkdir $s;
        echo -e "$s\n";
done
