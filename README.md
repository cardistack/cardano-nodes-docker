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

### scenario:

- Build 1 x docker block producing node

- Build 1 x docker relay node

- create a docker network to allow nodes to communicate

- manually update topoloy files to get nodes talking

