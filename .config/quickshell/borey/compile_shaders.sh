#!/bin/bash

# Добавляем путь к qsb (если он там)
export PATH="/usr/lib/qt6/bin:$PATH"

SHADER_SRC_DIR="./shaders"
QSB="qsb"

GLSL_VERSION="440"
HLSL_VERSION="50"
MSL_VERSION="20"
OPTS="--glsl $GLSL_VERSION --hlsl $HLSL_VERSION --msl $MSL_VERSION"

echo "Compiling shaders in $SHADER_SRC_DIR ..."

if ! command -v $QSB &> /dev/null; then
    echo "ERROR: $QSB not found. Please install Qt Shader Tools or adjust PATH."
    exit 1
fi

for file in "$SHADER_SRC_DIR"/*.vert "$SHADER_SRC_DIR"/*.frag; do
    if [ -f "$file" ]; then
        basename=$(basename "$file")
        output="$SHADER_SRC_DIR/$basename.qsb"
        echo "  Compiling $file -> $output"
        $QSB $OPTS -o "$output" "$file"
        if [ $? -ne 0 ]; then
            echo "ERROR: Failed to compile $file"
            exit 1
        fi
    fi
done

echo "All shaders compiled successfully."
