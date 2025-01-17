# checks if the first argument received by the function
# is contained in the rest of the arguments received
contains(){
    for i in "${@:2}"
    do
        [[ $i == $1 ]] && return
    done
    false
}

# trims all leading and trailing whitespace from stdout
trim(){
    tac | sed '/./,$!d' | tac | sed '/./,$!d'
}

# obtains the lines in stdout between two regex patterns,
# including the first and excluding the second
extract(){
    sed "0,/$1/b; /$2/Q" | tac | sed "/$1/Q" | tac
}

# obtains the first line in stdout that matches a pattern
line(){
    sed "0,/$1/b; Q" | tail -n 1
}

# turns the text received lowercase, then capitalizes the first letter
title(){
    echo ${1,,} | sed 's/./\u&/'
}

# gets the list of the filter's style names
get_styles(){
    find src/styles -mindepth 1 -maxdepth 1 -type d | sed -rn 's/.*\/(.*)/\1/p'
}

# gets the list of the filter's strictness names and values
get_strictness_values(){
    cat src/conditions/constants.filter | \
    sed -rn 's/^[[:space:]]*#\.alias[[:space:]]*([[:alnum:]]+)[[:space:]]*=[[:space:]]*([[:digit:]]+)/\1 \2/p'
}