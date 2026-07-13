#!/usr/bin/env bash

> completo.txt

find . -type f ! -name "completo.txt" | while read FILE; do
echo "|| componente: $(basename "$FILE") -------------------------------------" >> completo.txt
echo "" >> completo.txt
cat "$FILE" >> completo.txt
echo "" >> completo.txt
echo "" >> completo.txt
echo "---" >> completo.txt
echo "" >> completo.txt

done