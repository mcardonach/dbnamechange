#!/bin/bash

# mysql -u $1 -p$2 $3 -sNe 'show tables' | while read table; do mysql -u $1 -p$2 -sNe "rename table $3.$table to $4.$table"; done

### Functions
usage()
{
    echo "usage: sysinfo_page [[[-u user ] [-p password]] | [-h]]"
}
rename_db()
{
	mysql -u $userdb -p$passdb $olddb -sNe 'show tables' | while read table; do mysql -u $userdb -p$passdb -sNe "rename table $olddb.$table to $newdb.$table"; done
}

## Main
userdb="root"
passdb=""
olddb=""
newdb=""
while [ "$1" != "" ]; do
    case $1 in
        -u | --user )           shift
                                userdb=$1
                                ;;
        -p | --password )    	shift
								passdb=$1
                                ;;
        -n | --newdb )			shift
        						newdb=$1
        						;;
        -o | --olddb )			shift
        						olddb=$1
        						;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

rename_db