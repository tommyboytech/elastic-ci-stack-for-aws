#!/bin/bash
set -eu -o pipefail

cd /tmp/t3
./salt/etc/bootstrap-local.sh bk.umt.io
sudo systemctl enable supervisord.service
sudo rm -rf /opt/t3
