#!/bin/sh

echo "Copying database config"
cp -n /sidewalks/config/database.example.yml /sidewalks/config/database.yml

echo "Copying application config"
cp -n /sidewalks/config/application.example.yml /sidewalks/config/application.yml