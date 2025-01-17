#!/usr/bin/env bash

# Copied from https://github.com/PaperMC/Paper/blob/d54ce6c17fb7a35238d6b9f734d30a4289886773/scripts/paperclip.sh
# License from Paper applies to this file

(
set -e
basedir="$(cd "$1" && pwd -P)"
workdir="$basedir/Tuinity/Paper/work"
mcver=$(cat "$workdir/BuildData/info.json" | grep minecraftVersion | cut -d '"' -f 4)
paperjar="$basedir/Airplane-Server/target/airplane-$mcver.jar"
vanillajar="$workdir/Minecraft/$mcver/$mcver.jar"

(
    cd "$workdir/Paperclip"
    mvn clean package "-Dmcver=$mcver" "-Dpaperjar=$paperjar" "-Dvanillajar=$vanillajar"
)
cp "$workdir/Paperclip/assembly/target/paperclip-${mcver}.jar" "$basedir/launcher-airplane.jar"

echo ""
echo ""
echo ""
echo "Build success!"
echo "Copied final jar to $(cd "$basedir" && pwd -P)/launcher-airplane.jar"
) || exit 1
