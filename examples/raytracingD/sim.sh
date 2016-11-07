#!/bin/sh

# Path to AVX simulator
SDE=/home/syoyo/src/sde/sde

INPUT=./render

${SDE} -- ${INPUT}
