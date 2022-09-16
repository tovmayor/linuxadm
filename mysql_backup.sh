#!/bin/bash
user='root'
pwd='CoolPasswd@2022'
MYSQL='mysql --defaults-extra-file=/home/admin/my_sql.cnf --skip-column-names'
DUMP='mysqldump --defaults-extra-file=/home/admin/my_sql.cnf --source-data=2'

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
                $DUMP $s $t > ./backup/$s/$s.$t.sql
        done

done
