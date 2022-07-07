#!/bin/sh
sudo systemctl daemon-reload
sudo systemctl enable audio-teleport-listener.socket
sudo systemctl start audio-teleport-listener.socket

