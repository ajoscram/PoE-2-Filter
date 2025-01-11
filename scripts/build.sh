source scripts/utils.sh
source .env

get_strictness_values(){
    cat src/conditions/constants.filter | \
    sed -rn 's/^[[:space:]]*#\.alias[[:space:]]*([[:alnum:]]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)/\1 \2/p'
}

get_craft_bases(){
    find src/conditions -type f | while read filepath ; do
        cat $filepath | \
        sed -rn 's/^[^#]*#.*\.tag[[:space:]]+craft[[:space:]]+([[:alnum:]_]+)\s*.*$/\1/p' | \
        sed -rn 's/[^_]/\0/p'
    done
}

DOT_STAND_IN="%"
VERSION=$(scripts/version.sh | sed "s/\./\\$DOT_STAND_IN/")
BASES=($(get_craft_bases))

get_styles | while read style; do
    title_style=$(title $style)
    pfg.exe "src/_main.filter" "$OUTPUT" .import STYLE=styles \> $style || exit

    get_strictness_values | while read strictness number; do
        title_strictness=$(title $strictness)
        pfg.exe "$OUTPUT" "build/$title_style/$title_strictness.filter" \
            .alias VERSION=$VERSION, STYLE=$title_style, VARIANT=$title_strictness .index .alias $DOT_STAND_IN=. \
            .strict $number .if .format || exit

        for base in "${BASES[@]}"; do
            pfg.exe "$OUTPUT" "build/$title_style/$title_strictness/$base.filter" \
                .alias VERSION=$VERSION, STYLE=$title_style, VARIANT=$title_strictness \($base\) .index .alias $DOT_STAND_IN=. \
                .strict $number .tag craft $base .if .format || exit
        done
    done
done

rm "$OUTPUT"