#!/bin/bash
user='root'
pwd='CoolPasswd@2022'
MYSQL='mysql --skip-column-names'

if [ ! -d backup ]; 
    then 
        mkdir backup
    else 
        rm -rf ./backup/*
fi

for s in `$MYSQL -u$user -p$pwd -e "SHOW DATABASES LIKE '%_db'"`;
    do
        mkdir ./backup/$s;
#        echo -e "$s\n";
        for t in `$MYSQL -u$user -p$pwd -e "SHOW TABLES FROM $s"`;
            do
                echo -e "$s.$t\n";

        done

done
