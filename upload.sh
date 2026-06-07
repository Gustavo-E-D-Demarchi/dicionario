#!/bin/bash

echo "== Git Upload =="

git add .

echo ""
read -p "Mensagem do commit: " msg

git commit -m "$msg"

git push

echo ""
echo "Upload concluido."
