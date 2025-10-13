# Python Module Completion for Zsh

A zsh plugin that provides intelligent tab completion for `python -m` commands with hierarchical module navigation and smart project detection.

[![asciicast](https://asciinema.org/a/748646.svg)](https://asciinema.org/a/748646)

## Features

- **Immediate Completion**: Works with both `python -m<TAB>` and `python -m <TAB>`
- **Hierarchical Navigation**: Navigate through nested modules with tab completion (e.g., `my_package.submodule.deeper`)
- **Smart Project Detection**: Automatically detects Python projects via virtual environments, `__init__.py` files, and project configuration files
- **Performance Optimized**: Caches module discovery results with configurable TTL
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

# Hierarchical navigation  
python -m mypackage<TAB>       # Completes to mypackage (no space if has submodules)
python -m mypackage.<TAB>      # Shows submodules in mypackage
python -m mypackage.sub<TAB>   # Completes to mypackage.sub
python -m mypackage.sub.<TAB>  # Shows modules in sub
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
1. `python -m <TAB>` → `my_module`
2. `python -m my_module<TAB>` → `my_module` (no space, has submodules)
3. `python -m my_module.<TAB>` → `sub_module`, `utils`
4. `python -m my_module.sub_module.<TAB>` → `deep_module`

## Configuration

Set these environment variables before sourcing the plugin:

```bash
# Cache directory (default: ~/.cache/zsh-python-module-completion)
export ZSH_PYTHON_MODULE_COMPLETION_CACHE_DIR="$HOME/.cache/my-completion"

# Cache TTL in seconds (default: 300)
export ZSH_PYTHON_MODULE_COMPLETION_CACHE_TTL=600
```

## Project Detection

The plugin detects Python projects by looking for:
- Virtual environments (`venv`, `.venv`, `env`, `.env`)
- Python project files (`pyproject.toml`, `setup.py`, `requirements.txt`, `Pipfile`, `poetry.lock`)
- Package directories (containing `__init__.py`)
- Active conda/virtual environments (`$CONDA_DEFAULT_ENV`, `$VIRTUAL_ENV`)
