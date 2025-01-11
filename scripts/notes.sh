source scripts/utils.sh

start="^##[[:space:]]"
end="^#\(#\)\?[[:space:]]"
cat changelog.md | extract $start $end | trim | sed "s/###/##/g"