#!/bin/bash
set -euo pipefail


ls *.tar | xargs -I {} docker load -i {}
