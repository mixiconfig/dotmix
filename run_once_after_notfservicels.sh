#!/bin/bash

sudo touch /usr/share/dbus-1/services/org.freedesktop.Notifications.service
echo -e '[D-BUS Service]\nName=org.freedesktop.Notifications\nExec=/usr/lib/notification-daemon-1.0/notification-daemon' >/usr/share/dbus-1/services/org.freedesktop.Notifications.service
