
activate-env () {
  source ../env/bin/activate
  if [ -f ../.env ]; then
    source ../.env
  else
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
  fi
}

workspace () {
  cd $HOME/workspace/$1/src
  activate-env
}
