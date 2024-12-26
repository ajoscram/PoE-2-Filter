VERSION=$(scripts/version.sh)
[ ! -d "build" ] && mkdir "build"
pfg.exe "src/_main.filter" "build/output.filter" .import .alias VERSION=$VERSION .index .choose .if || exit
pfg.exe "build/output.filter" .format || exit