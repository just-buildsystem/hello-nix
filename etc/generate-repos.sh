#!/bin/sh


readonly ROOT=$(readlink -f $(dirname $0)/..)

: ${RULES_CC_REPO:=https://github.com/just-buildsystem/rules-cc}
: ${RULES_CC_BRANCH:=master}

just-import-git -C ${ROOT}/etc/repos.template.json \
                --as rules -b ${RULES_CC_BRANCH} ${RULES_CC_REPO} rules \
    | hdump > ${ROOT}/etc/repos.json
