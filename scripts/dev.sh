source .env

STYLE=${1:-"classic"}
VERSION=$(scripts/version.sh)

touch "$OUTPUT" && code "$OUTPUT"
pfg.exe :watch "src/_main.filter" "$OUTPUT" \
    .import STYLE=styles \> $STYLE \
    .alias VERSION=$VERSION \
    .choose .index .if