#!/usr/bin/env bash
set -eo pipefail
IFS=$'\n\t'

# create build directory
mkdir -p build

# copy assets
# cp -r assets build/assets

# copy styles
cp *.css build/

# copy html files
cp *.html build/

# replace all <component-<component-name> /> tags with the component's html from components/ using a for loop
for component in components/*; do
  component_name="$(basename "$component")"
  component_name="${component_name%.*}"
  echo "Replacing <component-$component_name/> with $component"
  for html_file in build/*.html; do
    sed -i "/<component-$component_name\ *\/>/r"<(cat "$component") "$html_file"
    sed -i "/<component-$component_name\ *\/>/d" "$html_file"
  done
done
