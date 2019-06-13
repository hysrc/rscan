#!/bin/bash

W12SCAN_BASE=/opt/w12scan
cd $W12SCAN_BASE
python3 ${W12SCAN_BASE}/manage.py makemigrations
python3 ${W12SCAN_BASE}/manage.py migrate
python3 ${W12SCAN_BASE}/pipeline/elastic.py
nohup gunicorn Server.wsgi:application -b 127.0.0.1:8080 > ${W12SCAN_BASE}/web.log &
python3 ${W12SCAN_BASE}/pipeline/user_add.py admin admin@hysrc.com admin
nginx
/usr/bin/tail -f /dev/null
