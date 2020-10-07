#!/bin/bash
# extract text from a screenshot taken of a console

OCR_INPUT="$(mktemp)"
TESSERACT_OPTS='-l eng+deu'
OUTPUT=
SOURCE=
INVERT=
STDOUT=

usage() {
cat <<EOF
$0 [ -i ] -s source_image -o output
-i: invert input image
-s: the image to extract text from
-o: the path to the output base file (without .txt extension)
If output is 'stdout', output the text directly to the console
EOF
exit 1
}

for cmd in tesseract convert;do
  which $cmd &>/dev/null || {
    echo "Command $cmd is not in \$PATH, exiting"
    exit 1
  }
done

while getopts 'is:o:' cmdargs; do
  case $cmdargs in
    i)
      INVERT=1
      ;;
    s)
      SOURCE="$OPTARG"
      ;;
    o)
      OUTPUT="$OPTARG"
      ;;
    *)
      usage
  esac
done

[[ -z "$OUTPUT" ]] && usage
[[ -z "$SOURCE" ]] && usage


if [[ -n "$INVERT" ]]; then
  convert "$SOURCE" -channel RGB -negate "$OCR_INPUT"
else
  cp "$SOURCE" "$OCR_INPUT"
fi

if [[ "$OUTPUT" = 'stdout' ]]; then
  STDOUT=1
  OUTPUT=$(mktemp)
fi

tesseract "$OCR_INPUT" "$OUTPUT" $TESSERACT_OPTS &>/dev/null

rm "$OCR_INPUT"

if [[ -n "$STDOUT" ]]; then
  cat "${OUTPUT}.txt"
  rm "${OUTPUT}.txt"
fi
