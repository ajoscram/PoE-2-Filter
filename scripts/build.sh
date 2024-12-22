[ ! -d "build" ] && mkdir "build"
pfg.exe "src/_main.filter" "build/output.filter" .import .index .choose || exit
pfg.exe "build/output.filter" .format || exit