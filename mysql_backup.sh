#!/bin/bash
user='root'
pwd='CoolPasswd@2022'
MYSQL='mysql --skip-column-names --defaults-extra-file=/home/admin/my_sql.cnf'

if [ ! -d backup ]; 
    then 
        mkdir backup
    else 
        rm -rf ./backup/*
fi

for s in `$MYSQL -e "SHOW DATABASES LIKE '%_db'"`;
    do
        mkdir ./backup/$s;
#        echo -e "$s\n";
        for t in `$MYSQL -e "SHOW TABLES FROM $s"`;
            do
                echo -e "$s.$t\n";

        done

done
