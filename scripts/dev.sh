source .env

DOT_STAND_IN="%"
STYLE=${1:-"beam"}
STRICTNESS=${2:-"base"}
VERSION=$(scripts/version.sh | sed "s/\./\\$DOT_STAND_IN/")

touch "$OUTPUT" && code "$OUTPUT"
pfg.exe :watch "src/_main.filter" "$OUTPUT" \
    .import STYLE=styles \> $STYLE \
    .alias VARIANT=${STRICTNESS^}, STYLE=${STYLE^}, VERSION=$VERSION \
    .index .alias $DOT_STAND_IN=. .choose .if