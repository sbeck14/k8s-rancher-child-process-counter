#!/bin/bash

# https://superuser.com/questions/363169/ps-how-can-i-recursively-get-all-child-process-for-a-given-pid

pidtree () {
  [ -n "$ZSH_VERSION"  ] && setopt shwordsplit
  declare -A CHILDS
  while read P PP;do
      CHILDS[$PP]+=" $P"
  done < <(ps -e -o pid= -o ppid=)

  walk() {
      for i in ${CHILDS[$1]};do
          echo $i
          walk $i
      done
  }

  for i in "$@";do
      walk $i
  done
}

cd /proc

for process in $(docker ps --format '{{.ID}},{{.Label "io.kubernetes.pod.name"}}-{{.Label "io.kubernetes.pod.namespace"}},{{.Names}},{{.Command}}' --filter "label=app" | grep -v -e pause -e calico -e fluentd -e prometheus -e kubelet -e kube-proxy -e proxymon -e cattle -e canal | awk -F',' '{print $1","$2}')
do
  containerID=`echo "$process" | awk -F',' '{print $1}'`
  name=`echo "$process" | awk -F',' '{print $2}'`
  pid=`echo "$(docker top $containerID -o pid,pgid | tail -n +2)" | awk '{print $2; exit}'`

  childids=`pidtree "$pid"`

  SAVEIFS=$IFS   # Save current IFS
  IFS=$'\n'      # Change IFS to new line
  childarr=($childids)
  IFS=$SAVEIFS   # Restore IFS

  if [ "${#childarr[@]}" -ge 1 ]; then
    printf '%-8s\t%-50s\t%s\n' "$pid" "$name" "${#childarr[@]}"
  fi
done
echo ""