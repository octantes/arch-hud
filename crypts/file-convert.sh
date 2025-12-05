#!/usr/bin/env bash

if [ -z "$1" ]; then
    echo "error: tenés que especificar un archivo de entrada."
    echo "uso: $0 nombredelasset.extension"
    exit 1
fi

INPUT_FILE="$1"
OUTPUT_FILE="${INPUT_FILE%.*}.webm"

echo "convirtiendo $INPUT_FILE a $OUTPUT_FILE..."

if [ ! -f "$INPUT_FILE" ]; then
    echo "error: archivo no encontrado: $INPUT_FILE"
    exit 1
fi

# -an: asegura que se quita el audio, lo que es óptimo para webm/gifs sin sonido
# -c:v libvpx: codec vp8 (webm)
# -b:v 4M: bitrate de video
# -pix_fmt yuv420p: formato de pixel compatible
# -y: sobrescribe sin preguntar

ffmpeg -i "$INPUT_FILE" \
       -c:v libvpx \
       -b:v 4M \
       -pix_fmt yuv420p \
       -an \
       -y \
       "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "conversión exitosa: $OUTPUT_FILE"
else
    echo "error: ffmpeg falló durante la conversión de $INPUT_FILE"
    exit 1
fi
