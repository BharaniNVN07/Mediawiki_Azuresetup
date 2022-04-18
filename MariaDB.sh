#! /bin/bash
# DB and User Creation
newUser='testuser'
newDbPassword='testpwd'
newDb='MediawikiDB'
host=localhost
commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}';GRANT ALL ON \`${newDb}\`.* TO '${newUser}'@'${host}';FLUSH PRIVILEGES;"
echo "${commands}" | /usr/bin/mysql -u root -p
