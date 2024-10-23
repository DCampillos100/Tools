:: echo off desactiva el echo de la consola para los comandos, la @ es un alias  de echo off para el comando dodnde se ejecuta.
@echo off

:: title fija el titulo de la consola
title Limpieza de la memoria de windows

RAMMap64.exe -Et
RAMMap64.exe -Es
RAMMap64.exe -EM
RAMMap64.exe -E0
RAMMap64.exe -EW