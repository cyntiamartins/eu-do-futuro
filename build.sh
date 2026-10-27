#!/bin/sh
# Gera index.html (para GitHub Pages) a partir de app.html (fonte única).
{ printf '<!doctype html>\n<html lang="pt-BR">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover">\n<link rel="icon" href="icon.svg">\n<link rel="apple-touch-icon" href="icon.svg">\n</head>\n<body>\n'; cat app.html; printf '\n</body>\n</html>\n'; } > index.html
echo "index.html gerado"
