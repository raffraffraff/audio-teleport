#!/bin/sh
sudo systemctl daemon-reload
sudo systemctl enable audio-teleport-receiver.socket
sudo systemctl start audio-teleport-receiver.socket

