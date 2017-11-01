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
### Others
* [rbenv](https://github.com/rbenv/rbenv): ruby virtual environments manager
  * [ruby-build](https://github.com/rbenv/ruby-build#readme): ruby version manager plugin for rbenv
* [nvm](https://github.com/creationix/nvm): node version manager
* [rustup](https://github.com/rust-lang-nursery/rustup.rs#installation): rust version manager (try https://www.rustup.rs/)
* [gvm](https://github.com/moovweb/gvm): go version manager (not being updated)

## Installation
1. `git clone https://github.com/zephyrthenoble/config.git`
2. `cd config`
3. `bash install.sh`

## Update
Run `git pull`

## Unique .bashrc stuff
The installed `.bashrc` will source a `.localbashrc` if it exists.  Put any code that needs to run for a specific host, but not all hosts, in this file.
