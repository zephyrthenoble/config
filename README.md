# zephyrthenoble's home directory config files

## Setup
Install several elements to get full functionality
### [pyenv](https://github.com/pyenv/pyenv-installer)
* `curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash`
* settings in `.bashrc` should be enabled after installation
### [pyenv-virtualenvwrapper](https://github.com/pyenv/pyenv-virtualenvwrapper)
* `git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git $(pyenv root)/plugins/pyenv-virtualenvwrapper`
* after each install of Python, run `pyenv shell $NEW_PYTHON; pyenv virtualenvwrapper`
* Use `pyenv shell $PYTHON_VERSION; mkvirtualenv $NEW_VIRTENV` to create a new environment

## Installation
1. `git clone https://github.com/zephyrthenoble/config.git`
2. `cd config`
3. `bash install.sh`

## Update
Run `git pull`

## Unique .bashrc stuff
The installed `.bashrc` will source a `.localbashrc` if it exists.  Put any code that needs to run for a specific host, but not all hosts, in this file.
