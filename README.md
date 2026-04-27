# Python Module Completion for Zsh

A zsh plugin that provides intelligent tab completion for `python -m` commands with hierarchical module navigation and smart project detection.

[![asciicast](https://asciinema.org/a/748646.svg)](https://asciinema.org/a/748646)

## Features

- **Immediate Completion**: Works with both `python -m<TAB>` and `python -m <TAB>`
- **Full Module Path Completion**: See and complete full import paths directly (e.g., `my_package.submodule.deeper`)
- **fzf Integration**: If `fzf` is installed, completion list is shown in an interactive picker
- **Smart Project Detection**: Automatically detects Python projects via virtual environments, `__init__.py` files, and project configuration files
- **Cross-Platform**: Works on Linux, macOS, and other Unix-like systems
- **Intelligent Filtering**: Excludes virtual environments and build directories from completion
- **Smart Suffix Handling**: Modules with submodules complete without space, final modules complete with space

## Installation

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/UshioA/zsh-python-module-completion.git ~/.zsh/zsh-python-module-completion
   ```

2. Add to your `.zshrc`:
   ```bash
   source ~/.zsh/zsh-python-module-completion/python-module-completion/python-module-completion.plugin.zsh
   ```

3. Restart your shell or run `exec zsh`

### Oh My Zsh

1. Clone into Oh My Zsh custom plugins directory:
   ```bash
   git clone https://github.com/UshioA/zsh-python-module-completion.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-python-module-completion
   ```

2. Add to your plugins in `.zshrc`:
   ```bash
   plugins=(... zsh-python-module-completion)
   ```

3. Restart your shell

### Zinit

Add to your `.zshrc`:
```bash
zinit light UshioA/zsh-python-module-completion
```

### Antigen

Add to your `.zshrc`:
```bash
antigen bundle UshioA/zsh-python-module-completion
```

### Zplug

Add to your `.zshrc`:
```bash
zplug "UshioA/zsh-python-module-completion"
```

## Usage

In any Python project, use tab completion with `python -m`:

```bash
# Basic completion (both work)
python -m<TAB>           # Shows available top-level modules  
python -m <TAB>          # Shows available top-level modules

# Full path completion
python -m mypackage<TAB>          # Shows full matches: mypackage.api, mypackage.cli, ...
python -m mypackage.sub<TAB>      # Shows full matches: mypackage.sub.tools, ...

# If fzf is installed
python -m <TAB>                   # Opens interactive fzf picker of full module paths
```

## Example

For a project structure like:
```
my_project/
├── my_module/
│   ├── __init__.py
│   ├── sub_module/
│   │   ├── __init__.py
│   │   └── deep_module.py
│   └── utils.py
└── setup.py
```

Tab completion works as:
1. `python -m <TAB>` -> `my_module`, `my_module.sub_module`, `my_module.sub_module.deep_module`, `my_module.utils`
2. `python -m my_module.sub<TAB>` -> `my_module.sub_module`
3. If `fzf` is installed, pressing `<TAB>` opens an interactive picker with these full module paths


## Activation

**Important**: This plugin only activates when you create a `.local_module_completion` file in your Python project root. This ensures that zsh's default Python completion (including all command-line options and module completion) continues to work normally in directories without this marker file.

To enable local module completion for a project:
```bash
# In your project root directory
touch .local_module_completion
```

### Completion Behavior

**Without `.local_module_completion` file:**
- The plugin completely defers to zsh's built-in Python completion
- `python -<TAB>` -> Shows all Python options (`-c`, `-m`, `-V`, etc.)
- `python -m <TAB>` -> Shows installed packages from your Python environment
- `python <TAB>` -> Shows Python files in current directory
- All other completions work as normal

**With `.local_module_completion` file:**
- `python -<TAB>` -> Shows all Python options (same as default)
- `python -m <TAB>` -> Shows **local project modules** (custom behavior)
- `python <TAB>` -> Shows files in current directory (same as default)
- `python -c <TAB>` -> File completion (same as default)
- `python -m some.module.name <TAB>` -> Show files in current directory (same as default)
- All other completions fall back to default behavior

The plugin only customizes the module completion after `-m` when the marker file is present. All other completion scenarios use zsh's default Python completion.

## Project Detection

When the `.local_module_completion` file is present, the plugin detects Python projects by looking for:
- Virtual environments (`venv`, `.venv`, `env`, `.env`)
- Python project files (`pyproject.toml`, `setup.py`, `requirements.txt`, `Pipfile`, `poetry.lock`)
- Package directories (containing `__init__.py`)