#!/bin/sh
# JBoss Control Script
#
# To use this script run it as root

export DISPLAY=localhost:0.0
export LANG=en_US
export TERM=xterm
INSTANCIA=comdoc
JBOSS_HOME=${JBOSS_HOME:-"{{unc_jboss_home}}"}
JBOSSCP=${JBOSSCP:-"$JBOSS_HOME/bin/shutdown.jar:$JBOSS_HOME/client/jnet.jar"}
JBOSS_CMD_STOP=${JBOSS_CMD_STOP:-"java -classpath $JBOSSCP org.jboss.Shutdown --
shutdown"}
JBOSS_CONSOLE=${JBOSS_CONSOLE:-"/dev/null"}
JBOSS_CMD_START="{{unc_jboss_home}}/bin/run.sh -b 0.0.0.0 -c $INSTANCIA -Djboss.partition.name=PartComdoc -Dcomdoc.dir={{unc_comdoc_home}}"

case "$1" in

start)
	rm -r $JBOSS_HOME/server/$INSTANCIA/tmp
	rm -r $JBOSS_HOME/server/$INSTANCIA/work
	rm -r $JBOSS_HOME/server/$INSTANCIA/data
	#rm -r $JBOSS_HOME/server/$INSTANCIA/log
	cd $JBOSS_HOME/bin
# 	./run.sh -b 0.0.0.0 -c $INSTANCIA -Djboss.partition.name=PartComdoc -Dcomdoc.dir=/usr/local/comdoc >${JBOSS_CONSOLE} 2>&1 &
	eval $JBOSS_CMD_START >${JBOSS_CONSOLE} 2>&1 &
	;;
stop)
    if [ -z "$SUBIT" ]; then
        $JBOSS_CMD_STOP
    else
        $SUBIT "$JBOSS_CMD_STOP"
    fi
    ;;
restart)
    $0 stop
    $0 start
    ;;
*)
    echo "usage: $0 (start|stop|restart|help)"
esac
