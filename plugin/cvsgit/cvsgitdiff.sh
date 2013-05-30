#
# cvsgitdiff
# por no .bashrc: . ~/.vim/plugin/cvsgit/cvsgitdiff.sh
# 
function cvsgitdiff() {

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

  if [ "$arquivo" = '' ]; then
    echo 'Arquivo nao informado ou invalido'
    return
  fi

  if [ "$vimparam" = '' ]; then
    echo 'Nenhuma versao informada'
    return
  fi

  vi $arquivo -c "CD$vimparam"
}

#
# Alias para cvsgitdiff
# 
function cgd() {
  cvsgitdiff $*
}
