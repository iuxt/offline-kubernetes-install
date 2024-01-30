#!/bin/bash

ls *.tar | xargs -I {} docker load -i {}
