#!/bin/bash
user='root'
pwd='CoolPasswd@2022'
MYSQL='mysql --skip-column-names'

if [ ! -d backup ]; then 
    mkdir backup
fi

for s in mysql `$MYSQL -u$user -p$pwd -e "SHOW DATABASES LIKE '%_db'"`;
    do
        mkdir ./backup/$s;
#        echo -e "$s\n";
        for t in mysql `$MYSQL -u$user -p$pwd -e "SHOW TABLES FROM $s"`;
            do
                echo -e "$s.$t\n";

        done

done
