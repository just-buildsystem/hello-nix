set -e

TOOLS_DIR=`pwd`/additionalTools
mkdir -p ${TOOLS_DIR}
cat > ${TOOLS_DIR}/mytool <<'EOF'
#!/bin/sh

echo using my CuStOm tool
EOF
chmod 755 ${TOOLS_DIR}/mytool

./withExtendedPath ${TOOLS_DIR} mytool | grep CuStOm
