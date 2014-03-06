activate-env () {
  source "../env$1/bin/activate"  # e.g. 'env2.7', 'env3.3'

  # Set global variables for project paths.
  PROJECT=`dirname $(pwd)`
  export PROJECT
  ENVFILE="$PROJECT/.env"
  export ENVFILE
  SRC="$PROJECT/src"
  export SRC
  APP="$SRC/$(basename $PROJECT)"
  if [ -d $APP ]; then
    export APP
  else
    unset APP
  fi

  # Source project's custom environment file.
  if [ -f $ENVFILE ]; then
    source $ENVFILE
  fi

  base-deactivate-env () {
    # Reset old virtualenv variables and functions.
    unset PROJECT
    unset ENVFILE
    unset SRC
    unset APP
    unset -f base-deactivate-env 2> /dev/null
    unalias deactivate 2> /dev/null

    # Project's custom deactivating.
    if [ `type -t deactivate-env`"" == 'function' ]; then
      deactivate-env
      unset -f deactivate-env 2> /dev/null
    fi
  }

  alias deactivate='base-deactivate-env; deactivate' 
}

workspace () {
  cd $HOME/workspace/$1/src
  activate-env
}

mkproject () {
  cd $HOME/workspace
  mkd $1
  if [ $2 ]; then
    virtualenv env -p $2
  else
    virtualenv env
  fi
  mkd src
  activate-env
}

ovpn () {
  sudo openvpn --config $HOME/.ovpn/$1/conf.ovpn --cd $HOME/.ovpn/$1/ --daemon openvpn-$1
}

# Create a new directory and enter it.
function mkd() {
  mkdir -p "$@" && cd "$@"
}

# Run PyTest with coverage and linting on specified application part.
#
# Useful shortcut when you're working at one class/function/module and you
# don't want to run all your tests and need to measure coverage only for what
# you're currently testing.
#
# Example::
#
#     $ test_part tests/test_views.py app/views.py -vsk LoginView
#
# 1st param: file or directory with tests to run
# 2nd param: path to measure coverage for
# Any additional params will be added as py.test params
test_part () {
  py.test --cov $2 --cov-report term-missing --cov-report html --pep8 --flakes $1 ${@:3}
}

alias pysmtp='sudo python -m smtpd -n -c DebuggingServer localhost:25'
alias :q='exit'
