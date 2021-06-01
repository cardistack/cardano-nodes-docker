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
          
          
### Set
- ### Import the variables into the environment 
        
       -  CONTEXT=$PWD NETWORK=testnet         (and enter . change to mainnet if yoou want to build for mainnet etc)
       -  source scripts/export_env.sh         ( this should load the enviroment variables into the current shell)
       -  test you have the right network imported by typing, echo $NETWORK. this should echo the network you are connected to
