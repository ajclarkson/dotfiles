(( $+commands[npm] )) && {
    __NPM_COMPLETION_FILE="/tmp/npm_completion"

    if [[ ! -f $__NPM_COMPLETION_FILE ]]; then
        npm completion >! $__NPM_COMPLETION_FILE 2>/dev/null
        [[ $? -ne 0 ]] && rm -f $__NPM_COMPLETION_FILE
    fi

    [[ -f $__NPM_COMPLETION_FILE ]] && source $__NPM_COMPLETION_FILE

    unset __NPM_COMPLETION_FILE
}

# Install dependencies globally
alias npmg="npm i -g "

# npm package names are lowercase
# Thus, we've used camelCase for the following aliases:

# Install and save to dependencies in your package.json
# npms is used by https://www.npmjs.com/package/npms
alias npmis="npm i -S "

# Install and save to dev-dependencies in your package.json
# npmd is used by https://github.com/dominictarr/npmd
alias npmid="npm i -D "

# Execute command from node_modules folder based on current directory
# i.e npmE gulp
alias npme='PATH="$(npm bin)":"$PATH"'

# Check which npm modules are outdated
alias npmo="npm outdated"

# Check package versions
alias npmv="npm -v"

# List packages
alias npmls="npm list"

# Run npm start
alias npmst="npm start"

# Run npm test
alias npmt="npm test"

# Run npm scripts
alias npmr="npm run"

# Run linting
alias npml="npm run lint"
