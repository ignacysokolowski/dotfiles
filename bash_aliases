alias activate-env='source ../env/bin/activate'

if [ -d ~/workspace/bin ]; then
  for item in $(ls -1 ~/workspace/bin); do
    alias $item="source ~/workspace/bin/$item"
  done
fi
