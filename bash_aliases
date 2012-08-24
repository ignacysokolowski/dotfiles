activate-env () {
  source ../env/bin/activate

  # Set global variables for project paths.
  PROJECT=`dirname $(pwd)`
  export PROJECT
  SRC="$PROJECT/src"
  export SRC
  APP="$SRC/$(basename $PROJECT)"
  if [ -d $APP ]; then
    export APP
  else
    unset APP
  fi

  # Source project's custom environment file.
  if [ -f ../.env ]; then
    source ../.env
  fi

  base-deactivate-env () {
    # Reset old virtualenv variables and functions.
    unset PROJECT
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

ovpn () {
  sudo openvpn --config $HOME/.ovpn/$1/conf.ovpn --cd $HOME/.ovpn/$1/ --daemon openvpn-$1
}

# Create a new directory and enter it.
function mkd() {
  mkdir -p "$@" && cd "$@"
}
