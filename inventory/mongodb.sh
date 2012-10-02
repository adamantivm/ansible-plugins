#!/bin/sh
#
##############################################################
# This is a very basic ansible inventory plug-in for using 
# the configuration from a MongoDB database.
# In order to use it, please copy this file as /etc/ansible/hosts
# and also copy mongodb.list.js as /etc/ansible/mongodb.list.js
#
# By default, the plug-in will try to connect to MongoDB
# on the local server and use the 'test' database.
# The plug-in will read all the entries in the 'servers'
# collection and look for the 'hostname' parameter on each
# object of the collection.
#
# Some of those details can be modified by configuring
# the variables below:
#
# MONGO_HOSTNAME: Host name or IP address of your MongoDB server
#
MONGO_HOSTNAME=localhost
# 
# MONGO_DATABASE: Name of the database where you are storing your
# server records
#
MONGO_DATABASE=test
#
# MONGO_OBJECTS: One or many pairs of collection-name: hostname
# parameter pairs, separated by comma.
# 
MONGO_OBJECTS="servers: 'hostname'"
# 
##############################################################

case "$*" in
    *--list*)
        mongo $MONGO_DATABASE --host $MONGO_HOSTNAME --quiet --eval "var config = { $MONGO_OBJECTS };" /etc/ansible/mongodb.list.js
    ;;
    *--host*)
        echo "{}"
    ;;
    *)
        echo "usage: $0 --list  ..OR.. --host <hostname>"
    ;;
esac
