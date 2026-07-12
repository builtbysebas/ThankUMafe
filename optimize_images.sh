#!/bin/bash
# Reduce el tamano de las imagenes en la carpeta images/ para que carguen mas rapido.
# Usa 'sips', que viene incluido en macOS (no requiere instalar nada).
# Controla el ANCHO (no el lado mas largo) para que las capturas verticales
# de WhatsApp no queden demasiado angostas y borrosas.
# Mantiene los mismos nombres de archivo, asi que no hay que tocar el HTML.

cd "$(dirname "$0")/images" 2>/dev/null || cd images || { echo "No encuentro la carpeta images/. Corre este script desde la carpeta del proyecto."; exit 1; }

echo "Tamano antes:"
du -sh . 2>/dev/null

count=0
for f in *; do
  [ -f "$f" ] || continue
  case "$f" in
    thumb_*) width=480 ;;    # miniaturas de video (16:9)
    gallery_*) width=600 ;;  # galeria de fotos
    testi_*) width=650 ;;    # capturas de WhatsApp / testimonios (necesitan mas ancho para texto legible)
    *) width=600 ;;
  esac
  sips --resampleWidth "$width" "$f" --out "$f" >/dev/null 2>&1 && count=$((count+1))
done

echo ""
echo "Imagenes procesadas: $count"
echo "Tamano despues:"
du -sh . 2>/dev/null
