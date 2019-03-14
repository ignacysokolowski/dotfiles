activate-env () {
  local env_version=$1

  local project=`dirname $(pwd)`
  local envfile="$project/.env"
  local src="$project/src"
  local envdir="$project/env$env_version"  # e.g. 'env2.7', 'env3.3'
  local venvdir="$src/venv"
  local app="$src/$(basename $project)"

  if [ -d $venvdir ]; then
    source "$venvdir/bin/activate"
  elif [ -d $envdir ]; then
    source "$envdir/bin/activate"
  fi

  export PROJECT=$project
  export ENVFILE=$envfile
  export SRC=$src
  if [ -d $app ]; then
    export APP=$app
  fi

  # Source project's custom environment file.
  if [ -f $envfile ]; then
    source $envfile
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

  if [ `type -t deactivate`"" == 'function' ]; then
    alias deactivate='base-deactivate-env; deactivate'
  else
    alias deactivate='base-deactivate-env'
  fi
}

workspace () {
  local name=$1
  cd $HOME/workspace/$name/src &&
  activate-env
}

mkproject () {
  local OPTIND
  local name
  local python_executable=python3.7
  local github_url

  while getopts "p:g:" option; do
    case "$option" in
      p) python_executable=$OPTARG
        ;;
      g) github_url=$OPTARG
        ;;
    esac
  done

  shift $((OPTIND-1))

  name=$1

  cd $HOME/workspace
  mkd $name
  $python_executable -m venv env
  if [ $github_url ]; then
    git clone $github_url src && cd src
  else
    mkd src
  fi
  activate-env
}

ovpn () {
  sudo /usr/local/sbin/openvpn --config $HOME/.ovpn/$1/conf.ovpn --cd $HOME/.ovpn/$1/ --daemon openvpn-$1 --log-append $HOME/.ovpn/$1/openvpn.log
}

# Create a new directory and enter it.
function mkd() {
  mkdir -p "$@" && cd "$@"
}

alias ls='ls -G'
alias pysmtp='sudo python -m smtpd -n -c DebuggingServer localhost:25'
alias :q='exit'
alias mvim='reattach-to-user-namespace open -a MacVim'
alias rmpycache="find . -depth -name '__pycache__' -exec rm -rf '{}' \;"
alias rmpyc='find . -name '\''*.pyc'\'' -delete && rmpycache'
alias find-empty-dirs="find . -regex '\.\/[^.].*' -type d -empty -print"
