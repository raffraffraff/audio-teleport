#!/bin/sh
sudo systemctl stop audio-teleport-listener.socket
sudo systemctl disable audio-teleport-listener.socket
