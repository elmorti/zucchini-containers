#!/bin/bash

SUPERVISOR_CONF=PANEL_ROOT/etc/supervisord.conf 

supervisord -c ${SUPERVISOR_CONF} -n
