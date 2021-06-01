# cardano-nodes-docker
Run BP and Relay nodes in Docker using compose files

# Intro

This guide to enable users quickly spin up a cardano block producer node on the testnet , mainnet or mary_era using docker compose files. 
the beauty about using yaml files is you can easily bring up nodes and detroy nodes with one command. You can also easily test out different node versions on the fly without having to install etc

# Credits

Special shout out to the guys at nessusio who have created one of the best cardano docker images i find as the images already come with scripts and tools like gLiview. [nessusio dockerhub images](https://hub.docker.com/r/nessusio/cardano-node)

Another massive shout out to (tdiesler?). who has put together this wonderful guide on using the nessusio images to create a relay and block producing node using docker. All i have done is taking that guide and adapted it to use docker-compose yaml files. 
[refer to this guide if you get stuck](https://tdiesler.gitbook.io/cardano/plain-docker/running-the-nodes).

Right, now thats out of the way lets get started!!

### Scenario:

- Build 1 x docker block producing node version 1.27.0

- Build 1 x docker relay node version 1.27.0

- Create a docker network to allow nodes to communicate

- Manually update topoloy files to get nodes communicating

- Create docker volumes that will be mounted in the docker containers when started

- Download the docker images

### Prerequisites

- Install docker if not already installed for you distribution.  [docker](https://docs.docker.com/engine/install/)
- install docker-compose if not already installed.  [docker-compose](https://docs.docker.com/compose/install/)
- ensure you have adequate disk space to download and store the cardano blockchain data, 10Gb +


### Start
- first clone thos reposotory and cd into the directory. got clone https://github.com/cardistack/cardano-nodes-docker.git && cardano-nodes-docker
- #### Directory structure 
      
      - config

        - bin ( store any executables you want in here. Currently not used)
        
        - logs (if you decide to log to files insted of console (default)).
        
        - network(contains the topology files download from IOHK for the networks mentioned https://hydra.iohk.io/build/5416636/download/1/index.html into   
          folders. You can manually modify these files like you would in a real node installation.
        
        - nodekeys (use this folder for your Block producer keys . Kes skey etc . ### WARNING!! this is ok for testnet . For mainnet dont store any private keys             here. If you do for mainnet and get hacked you will lose funds. 
        
      - scripts 
        - export_env.sh  (contains some environmental variables. Defaults are fine but you can edit to suite your needs)

- #### Docker-compose main file
 
        - Docker-compose.yml ( this file contains the settings that will be used to build the nodes using version 1.27.0). Almost all the settings are 
          autmatically passed using variables so you dont really have to change anythng in this file. However, if you want a node version other the 1.27 edit the           section image: nessusio/cardano-node:1.27.0 to reflect.
        
        - i have manually defined the networks because i find its easier to use ip addresses in the topololy files to get the nodes communicating.

        - TIP: on the first run till the blockchain is synced on both nodes, leave the environmental variable  CARDANO_BLOCK_PRODUCER=false under the cardano-               node-BP: section .this is because you will not have the kes and vrf keys generated. if you do already have them, then you can place them under the                 nodekeys folder and modify the compose file accordinly. If not set both to sections to off , wait for the blockchain to sync, use cardano-cli in the               nodes to generate the keys, stop the nodes, then set the  CARDANO_BLOCK_PRODUCER=true under the ardano-node-BP section.

          
          
### Set
- ### Import the variables into the environment 
        
       -  CONTEXT=$PWD NETWORK=testnet         (and enter . change to mainnet if yoou want to build for mainnet etc)
       -  source scripts/export_env.sh         ( this should load the enviroment variables into the current shell)
       -  test you have the right network imported by typing, echo $NETWORK. this should echo the network you are connected to



### Go 
- ### Spin up the nodes.
       
       - docker-compose up -d && docker-compose logs -f
       
       - if all goes well the nodes will be created and automatically started . just wait for the blockchain to sync

     ![dockerstart](https://user-images.githubusercontent.com/83215574/120376705-19876d00-c314-11eb-9d65-6278f81cb159.png)
     
       - you can exit out of console logging by pressing ctrl + c .  reconnect anytime, docker-compose logs -f
       
       - docker ps (will show you list of running nodes) 
    
    ![image](https://user-images.githubusercontent.com/83215574/120377118-9d415980-c314-11eb-94f4-c495ae967bcf.png)
     
       -  e.g  connect to the BP by typing  docker exec -it cardano-node-testnet-BP /bin/bash
       
    ![image](https://user-images.githubusercontent.com/83215574/120377462-0f19a300-c315-11eb-9ee2-c9d1b9554fbf.png)
    ![image](https://user-images.githubusercontent.com/83215574/120378044-d5956780-c315-11eb-96cd-19aeb4437780.png)
    
       - launch gLiview
    ![image](https://user-images.githubusercontent.com/83215574/120379216-599c1f00-c317-11eb-8d6a-1d039c1c19ef.png)

       - after blockchain is synced, change into the nodekeys directory and create the necessary keys for a block producer paying attention to the naming.
       - [How to create stakepool keys etc](https://docs.cardano.org/projects/cardano-node/en/latest/stake-pool-operations/keys_and_addresses.html)
       - once you have the keys, you can the shutdown the nodes and update the docker-compose.yml file by setting the nvironmental variable                                CARDANO_BLOCK_PRODUCER=true. start the nodes as before


### Cool Down
- Stopping the nodes.
       
       -  docker-compose down ( This will remove the containes and networks but not delete the docker volumes)
       
     ![image](https://user-images.githubusercontent.com/83215574/120378926-f7431e80-c316-11eb-8c9c-635caea95633.png)
     
       - you can now stop and start the nodes when you want. 
       - 
       - you can delete the volumes. Not this will clear all blockchain download and volumes will get recreated once you start the compose files. 
       
         - docker volume rm  (and volume name) . the  volume names are defined in the yaml file. 
         - volumes:
              node-mainnet-RELAY-db:
              node-testnet-RELAY-db:
              node-mainnet-RELAY-ipc:
              node-testnet-RELAY-ipc:
              node-mainnet-BP-db:
              node-testnet-BP-db:
              node-mainnet-BP-ipc:
              node-testnet-BP-ipc:


### Post work
- Edit the topology files by using the IP adresses of the nodes defined in the docker yaml files. 
-  e.g BP on mainnet will be 192.168.33.13  etc
-  ensure you also checkout the documents credited above . 







  

  
