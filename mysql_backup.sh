#!/bin/bash
# adding client config file  with mesql username & password /home/admin/my_sql.cnf like:
#[client]
#user = "some"
#password = "very complex"

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

        for t in `$MYSQL -e "SHOW TABLES FROM $s"`;
            do
                echo -e "$s.$t\n";
                $DUMP $s $t | gzip -3 > ./backup/$s/$s.$t.gz;
        done

done
