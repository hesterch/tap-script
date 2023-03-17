#!/bin/bash 

export INSTALL_REGISTRY_USERNAME=taptestdemoacr
export INSTALL_REGISTRY_PASSWORD=yy2n1woGlAOP6fWOrqb+R9Ev4M7eY52eU6KZEcDzwz+ACRDEJ0Q+
export INSTALL_REGISTRY_HOSTNAME=taptestdemoacr.azurecr.io
export TAP_VERSION=1.3.2
export INSTALL_REPO=tap13
imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:${TAP_VERSION} --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tap-packages
imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/full-tbs-deps-package-repo:1.7.4 \
  --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tbs-full-deps
