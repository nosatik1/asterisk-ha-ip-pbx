#!/bin/bash
# Скрипт синхронизации конфигураций Asterisk с Master на Backup сервер.
# Запускается по cron каждую минуту: * * * * * /path/to/sync_asterisk.sh
LOG_FILE="/var/log/asterisk-sync.log"
echo "$(date): Запуск синхронизации Asterisk" >> $LOG_FILE

rsync -avz --delete -e ssh /etc/asterisk/ nos@pbx-slave:/etc/asterisk/ >> $LOG_FILE 2>&1

rsync -avz --delete -e ssh /var/spool/asterisk/ nos@pbx-slave:/var/spool/asterisk/ >> $LOG_FILE 2>&1
rsync -avz --delete -e ssh /var/lib/asterisk/ nos@pbx-slave:/var/lib/asterisk/ >> $LOG_FILE 2>&1

echo "$(date): Синхронизация Asterisk завершена" >> $LOG_FILE
