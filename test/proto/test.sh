set -e

./write FOO 42 data.bin 2>&1

echo
echo Binary encoding
xxd data.bin

echo
echo Verifying read
./read data.bin | grep foo=FOO
./read data.bin | grep bar=42
