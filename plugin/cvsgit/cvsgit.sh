
#
# cvsgit
# por no .bashrc: . ~/.vim/plugin/cvsgit/cvsgit.sh
# 
function cvsgit() {

  if [ "$1" = 'diff' ]; then

    arquivo=''
    vimparam=''

    for param in $*; do

      if [ $param = 'diff' ]; then
        continue
      fi

      if [ -a "$param" ]; then
        arquivo=$param
        continue
      fi

      vimparam="$vimparam $param"
    done

    if [ "$vimparam" = '' ]; then
      echo 'Nenhuma versao informada'
      return
    fi

    if [ "$arquivo" = '' ]; then
      echo 'Arquivo nao informado'
      return
    fi

    vi $arquivo -c "CD$vimparam"
    return
  fi

  php -f ~/.vim/plugin/cvsgit/cvsgit $*
}

#
# Alias para cvsgit
# 
function cg() {
  cvsgit $*
}

