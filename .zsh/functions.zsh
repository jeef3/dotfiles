# Start an HTTP server from a directory, optionally specifying the port
function server() {
    local port="${1:-8000}"
    open "http://localhost:${port}/"

    # Set the default Content-Type to `text/plain` instead of `application/octet-stream`
    # And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
    python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}

function gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

function movToMp4() {
  ffmpeg -i "$1" -vcodec copy -acodec copy "$2"
}

function port() {
  ps -o pid,command -p $(lsof -i:$1 -t)
}

function pngToBase64() {
  local prefix="url('data:image/png;base64,"
  local encoded=$(openssl base64 -in $1 | tr -d '\n')
  local suffix="')"

  echo $prefix$encoded$suffix
}

function isSquashed() {
  branch="$1"
  main="${2:-main}"

  if [ -z $branch ]; then
    echo "No branch specified. Usage:"
    echo "isSquashed <branch> [main]"
    return 1;
fi

  ancestor_hash=$(git merge-base ${main} "${branch}")
  tree_id=$(git rev-parse "${branch}^{tree}")

  dangling_commit_id=$(git commit-tree "$tree_id" -p "$ancestor_hash" -m "Temp commit for ${branch}")
  out=$(git cherry ${main} "$dangling_commit_id")

  expr "$out" : -. >/dev/null
}

function listMerged() {
  main="${1:-main}"
  for branch in $(git for-each-ref refs/heads/ --format="%(refname:short)"); do
    if isSquashed "$branch" "$main"; then
      echo "$branch"
    fi
  done
}

PROG='@a = split " ";
print join " ", @a[0..($#a-1)];
if (rindex($a[$#a], "/") != -1) {
  if (scalar @a > 1) { print " "; }
  @b = split "/", $a[$#a];
  print join "/", @b[0..($#b-1)]
}'

function _up-dir {
    if [ -z $BUFFER ]; then
        parent="$(dirname $(pwd))"
        cd $parent
        zle reset-prompt
    else
        BUFFER=$(echo $BUFFER | perl -ne $PROG)
    fi

}
zle -N _up-dir
bindkey "^h" _up-dir
