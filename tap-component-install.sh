!/bin/bash  

echo "######################## Type: AKS for Azure, EKS for Amazon, GKE for Google ########################"
echo "############################ If you choose EKS, Keep docker.io credentials handy ######################"
read -p "Enter the destination K8s cluster: " cloud
echo "#####################################################################################################"
echo "##### Pivnet Token: login to tanzu network, click on your username in top right corner of the page > select Edit Profile, scroll down and click on Request New Refresh Token ######"
read -p "Enter the Pivnet token: " pivnettoken
read -p "Enter the Tanzu network username: " tanzunetusername
read -p "Enter the Tanzu network password: " tanzunetpassword
echo " ######  You choose to deploy the kubernetes cluster on $cloud ########"
echo "#####################################################################################################"
echo "############# Installing Pivnet ###########"
     wget https://github.com/pivotal-cf/pivnet-cli/releases/download/v3.0.1/pivnet-linux-amd64-3.0.1
     chmod +x pivnet-linux-amd64-3.0.1
     sudo mv pivnet-linux-amd64-3.0.1 /usr/local/bin/pivnet

     echo "########## Installing Tanzu CLI  #############"
     pivnet login --api-token=${pivnettoken}
         pivnet download-product-files --product-slug='tanzu-cluster-essentials' --release-version='1.4.0' --product-file-id=1407185
     mkdir $HOME/tanzu-cluster-essentials
     tar -xvf tanzu-cluster-essentials-linux-amd64-1.4.0.tgz -C $HOME/tanzu-cluster-essentials
     export INSTALL_BUNDLE=registry.tanzu.vmware.com/tanzu-cluster-essentials/cluster-essentials-bundle@sha256:2354688e46d4bb4060f74fca069513c9b42ffa17a0a6d5b0dbb81ed52242ea44
     export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
     export INSTALL_REGISTRY_USERNAME=$tanzunetusername
     export INSTALL_REGISTRY_PASSWORD=$tanzunetpassword
     cd $HOME/tanzu-cluster-essentials
     ./install.sh
     echo "######## Installing Kapp ###########"
     sudo cp $HOME/tanzu-cluster-essentials/kapp /usr/local/bin/kapp
     sudo cp $HOME/tanzu-cluster-essentials/imgpkg /usr/local/bin/imgpkg
         kapp version
     echo "#################################"
         pivnet download-product-files --product-slug='tanzu-application-platform' --release-version='1.4.0' --product-file-id=1404618

     mkdir $HOME/tanzu
         tar -xvf tanzu-framework-linux-amd64-v0.25.4.tar -C $HOME/tanzu
     export TANZU_CLI_NO_INIT=true
     cd $HOME/tanzu
         sudo install cli/core/v0.25.4/tanzu-core-linux_amd64 /usr/local/bin/tanzu
         tanzu version
     tanzu plugin install --local cli all
         tanzu plugin list
     echo "######### Installing Docker ############"
     sudo apt-get update
     sudo apt-get install  ca-certificates curl  gnupg  lsb-release
     curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
     echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
     sudo apt-get update
     sudo apt-get install docker-ce docker-ce-cli containerd.io -y
     sudo usermod -aG docker $USER
         echo "####### Verify Docker Version  ###########"
         sudo apt-get install jq -y
         export INSTALL_REGISTRY_USERNAME=$tanzunetusername
         export INSTALL_REGISTRY_PASSWORD=$tanzunetpassword
         export INSTALL_REGISTRY_HOSTNAME=registry.tanzu.vmware.com
         tanzu secret registry add tap-registry --username ${INSTALL_REGISTRY_USERNAME} --password ${INSTALL_REGISTRY_PASSWORD} --server ${INSTALL_REGISTRY_HOSTNAME} --export-to-all-namespaces --yes --namespace tap-install
         echo "#####################################################################################################"
         echo "########### Rebooting #############"
         sudo reboot
     
