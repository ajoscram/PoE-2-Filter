source .env

touch "$OUTPUT"
code "$OUTPUT"
pfg.exe :watch "src/_main.filter" "$OUTPUT" .import .alias .choose .if .index