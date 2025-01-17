source scripts/utils.sh
source .env

get_strictness_number() {
    get_strictness_values | while read strictness number; do
        if [ ${STRICTNESS^^} = "$strictness" ]; then
            echo $number
            break
        fi
    done
}

DOT_STAND_IN="%"
STYLE=${2:-"beam"}
STRICTNESS=${1:-"base"}
VERSION=$(scripts/version.sh | sed "s/\./\\$DOT_STAND_IN/")

STRICTNESS_NUMBER=$(get_strictness_number)
[ -z "$STRICTNESS_NUMBER" ] \
    && echo "Error: '$STRICTNESS' does not correspond to any strictness value in the filter." \
    && exit

touch "$OUTPUT" && code "$OUTPUT"
pfg.exe :watch "src/_main.filter" "$OUTPUT" \
    .import STYLE=styles \> $STYLE \
    .alias VARIANT=${STRICTNESS^}, STYLE=${STYLE^}, VERSION=$VERSION .index .alias $DOT_STAND_IN=. \
    .strict $STRICTNESS_NUMBER .if