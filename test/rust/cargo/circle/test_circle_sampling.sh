set -e

for _ in `seq 1 100`
do
    ./bin/sample >> sampled
done

python3 verify.py sampled
