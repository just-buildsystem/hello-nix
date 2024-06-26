#!/bin/sh


readonly ROOT=$(readlink -f $(dirname $0)/..)

: ${RULES_CC_REPO:=https://github.com/just-buildsystem/rules-cc}
: ${RULES_CC_BRANCH:=master}
: ${RULES_RUST_REPO:=https://github.com/just-buildsystem/rules-rust}
: ${RULES_RUST_BRANCH:=master}

just-import-git -C ${ROOT}/etc/repos.template.json \
                --as rules -b ${RULES_CC_BRANCH} ${RULES_CC_REPO} rules \
    | just-import-git -C - \
                --as rules-rust -b ${RULES_RUST_BRANCH} ${RULES_RUST_REPO} rules-rust \
    | just-deduplicate-repos \
    | hdump > ${ROOT}/etc/repos.json
