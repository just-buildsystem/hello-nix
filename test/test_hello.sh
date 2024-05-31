set -e

./hello | grep -i world
./hello Universe | grep Universe
./hello Universe | grep -i world && exit 1 || :
