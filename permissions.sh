#!/bin/bash

sudo chmod -R o+w var &&
sudo chmod -R o+w bin &&
sudo chmod -R o+w vendor &&
sudo chmod -R o+w web
sudo chmod -R o+w composer.json
sudo chmod -R o+w composer.lock
