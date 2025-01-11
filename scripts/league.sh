source scripts/utils.sh

pattern="^#[[:space:]]*"
cat changelog.md | line $pattern | sed "s/$pattern//"