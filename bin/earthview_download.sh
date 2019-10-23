#!/bin/bash

TMPDIR=$(mktemp --directory)

earthview_url=https://raw.githubusercontent.com/limhenry/earthview/master/earthview.json
while IFS= read -r json; do
  country=$(echo "$json" | jq -r -c '.country')
  region=$(echo "$json" | jq -r -c '.region')
  url=$(echo "$json" | jq -r '.image')
  echo "Downloading ${url}"
  filename="${url##*/}"
  coordinates=$(echo "$json" | jq -r '.map' | grep -E -o '(-?[[:digit:]]{1,5}\.[[:digit:]]{1,10},-?[[:digit:]]{1,5}\.[[:digit:]]{1,10})')
  curl -s -o "$TMPDIR"/"$filename" "$url"
  if [ -z "$region" ];then
    text="$country\n$coordinates"
  else
    text="$region, $country\n$coordinates"
  fi
  placement="+40+150"
  convert "$TMPDIR"/"$filename" -gravity SouthEast -stroke "#000C" -strokeWidth 2 -annotate "$placement" "$text" -stroke none -fill white -annotate "$placement" "$text" "$(basename "$filename" .jpg).jpg"
  #convert "$TMPDIR"/"$filename" -gravity Center -stroke "#000C" -strokeWidth 2 -annotate 0 "${text}" -stroke none -fill white -annotate 0 "$text" "$filename"
  printf "%s,%s\n%s" "$region" "$country" "$coordinates" > "$PWD"/"$(basename "$filename" .jpg)".txt
  #cp "$TMPDIR"/"$filename" "$PWD"/"$filename"
done < <(curl -s $earthview_url | jq -c '.[]')
