# zsh-python-module-completion plugin
#
# This plugin provides completions for `python -m` and `python3 -m`.

# Get the directory of the script
PLUGIN_DIR="${${(%):-%x}:A:h}"

# Add the plugin's functions directory to fpath
fpath=("$PLUGIN_DIR/functions" $fpath)

autoload -U compinit && compinit

# Save the original _python completion before we override it
autoload +X _python 2>/dev/null
typeset -g _PYTHON_ORIGINAL_COMPLETION="$functions[_python]"

# Load the completion function
autoload -U _python_module_completion

# # Register the completion function for python -m and python3 -m
# compdef _python_module_completion python
# compdef _python_module_completion python3

# Register the completion function for all Python version variants
# This matches python, python2, python3, python3.10, python3.13, etc.
compdef _python_module_completion -P 'python[0-9.]#'