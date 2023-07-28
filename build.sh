#!/usr/bin/env bash
set -eo pipefail
IFS=$'\n\t'

# create build directory
mkdir -p build

# copy assets
# cp -r assets build/assets

# copy styles
cp *.css build/

# copy index.html
cp index.html build/index.html

# replace all <component-<component-name> /> tags with the component's html from components/ using a for loop
for component in components/*; do
  component_name="$(basename "$component")"
  component_name="${component_name%.*}"
  echo "Replacing <component-$component_name/> with $component"
  sed -i "/<component-$component_name\ *\/>/r"<(cat "$component") build/index.html
  sed -i "/<component-$component_name\ *\/>/d" build/index.html
done
