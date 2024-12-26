source .env

touch "$OUTPUT"
code "$OUTPUT"
VERSION=$(scripts/version.sh)
pfg.exe :watch "src/_main.filter" "$OUTPUT" .import .alias VERSION=$VERSION .choose .index .if