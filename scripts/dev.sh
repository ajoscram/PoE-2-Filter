source .env

STYLE=${1:-"beam"}
STRICTNESS=${2:-"base"}
VERSION=$(scripts/version.sh | sed 's/\./\%/')

touch "$OUTPUT" && code "$OUTPUT"
pfg.exe :watch "src/_main.filter" "$OUTPUT" \
    .import STYLE=styles \> $STYLE \
    .alias VARIANT=${STRICTNESS^}, STYLE=${STYLE^}, VERSION=$VERSION \
    .index .alias %=. .choose .if