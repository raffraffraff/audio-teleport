#!/bin/sh
sudo systemctl stop audio-teleport-receiver.socket
sudo systemctl disable audio-teleport-receiver.socket
