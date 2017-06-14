pdfgrep() {
if [ "$#" -ge 2 ]; then
  find "$1" -name '*.pdf' -exec sh -c 'pdftotext "{}" - | grep --with-filename --label="{}" --color "$2"' \;
fi
}

movie()
{

  for prog in redshift xscreensaver; do killall $prog;done
  xset -dpms
  xset s off
  xset s noblank

}

genmac()
{
  echo 52:54:00$(hexdump -e '/1 ":%02x"' -n 3 /dev/urandom)
}

unssh()
{
[[ $# -lt 1 ]] && return 1

known_hosts=~/.ssh/known_hosts
cp $known_hosts{,-bak}
sed -i -e "${1}d" $known_hosts

}

patchprep()
{

# patchprep extracts an archive and creates to copies, -orig and -patched in our cwd

[[ $# -lt 1 ]] && return 1

# first, get the basename
basefile=${1/\/*\//}
# discard the suffixes
case $basefile in
  *.tar.bz2)
      basedir=$(basename $basefile .tar.bz2)
      ;;
  *.tar.gz)
      basedir=$(basename $basefile .tar.gz)
      ;;
  *)
      basedir=${basefile/.*/}
esac

extract $1

cp -R $basedir{,-patched}
mv $basedir{,-orig}

}

#some stolen functions from phractured.net
mkcd() { mkdir "$1" && cd "$1"; }
calc(){ awk "BEGIN{ print $* }" ;}
hex2dec() { awk 'BEGIN { printf "%d\n",0x$1}'; }
dec2hex() { awk 'BEGIN { printf "%x\n",$1}'; }
mktar() { tar cjf "${1%%/}.tar.bz2" "${1%%/}/"; }
function :h () {  vim -c "silent help $@" -c "only"; }

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

vnctunnel()
{

remotehost=${1:-lc@s99.be}
vncpasswd=$(uuidgen)
vnclog=$HOME/x11vnc.log

echo Opening SSH-Tunnel for ${remotehost} in background
ssh -N -Rlocalhost:15900:localhost:5900 $remotehost &>/dev/null &

echo Starting x11vnc in background, the password is $vncpasswd
x11vnc -noremote -ncache -viewonly -shared -forever -localhost -passwd $vncpasswd &> $vnclog &

}


rs() {

[[ $# -lt 1 ]] && return 1

case $1 in
    on)
      redshift -l 51.151786:10.415039 -o
      ;;
    off)
      redshift -x
      ;;
esac

}

psgrep() {
        if [ ! -z $1 ] ; then
                echo "Grepping for processes matching $1..."
                ps aux | grep $1 | grep -v grep
        else
                echo "!! Need name to grep for"
        fi
}

bu () { cp $1 ~/.backup/`basename $1`-`date +%Y%m%d%H%M`.backup ; }

yaml_check() {
  if [ $# -lt 1 ];then
    echo Usage: yaml_check file
    return
  fi
  ruby -e "require 'yaml';require 'pp';pp YAML.load_file('$1')"
}

mylast () {
  re='^[0-9]+$'
  if ! [[ $1 =~ $re ]] ; then
     echo "error: $1 not a number" >&2
  else
     history | awk '{a[$4]++} END {for (i in a) print a[i], i}' | sort -rn | head -n $1
  fi
}
