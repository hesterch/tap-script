#!/bin/bash 
docker login registry.tanzu.vmware.com -u tanzunet-username -p password
docker login you-container-repo-url -u you-container-repo-username -p you-container-repo-passwrod

export INSTALL_REGISTRY_USERNAME=you-container-repo-username
export INSTALL_REGISTRY_PASSWORD=you-container-repo-passwrod
export INSTALL_REGISTRY_HOSTNAME=you-container-repo-url
export TAP_VERSION=1.4.2
export INSTALL_REPO=tap14
imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/tap-packages:${TAP_VERSION} --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tap-packages

imgpkg copy -b registry.tanzu.vmware.com/tanzu-application-platform/full-tbs-deps-package-repo:1.7.4 \
  --to-repo ${INSTALL_REGISTRY_HOSTNAME}/${INSTALL_REPO}/tbs-full-deps
