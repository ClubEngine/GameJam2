:: Build love file
:: Need 7z
@echo OFF
set EXEC=main.love
cd src
7z a ../%EXEC% *
cd ..
