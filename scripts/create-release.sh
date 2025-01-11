source scripts/utils.sh

[ ! -d "release" ] && mkdir "release"
get_styles | while read style; do
    title_style=$(title $style)
    powershell "Compress-Archive -Force -Path build/$title_style/* -DestinationPath release/$title_style.zip"
done