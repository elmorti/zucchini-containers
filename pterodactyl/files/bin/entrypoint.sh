#!/bin/bash

ARTISAN=APP_ROOT/artisan
SUPERVISOR_CONF=PANEL_ROOT/etc/supervisord.conf 

if [ ! -f APP_ROOT/initialized.dev ]
then
        php ${ARTISAN} cache:clear
        php ${ARTISAN} key:generate -n --force
        php ${ARTISAN} migrate --seed --force -n
        php ${ARTISAN} p:user:make \
                --email=zucchini@panel-dev.casita \
                --username=zucchini \
                --name-first=Zucchini \
                --name-last=Universe \
                --password=zucchini \
                --admin=1 -n

        touch APP_ROOT/initialized.dev
	supervisord -c ${SUPERVISOR_CONF} -n
fi

php ${ARTISAN} cache:clear
supervisord -c ${SUPERVISOR_CONF} -n
