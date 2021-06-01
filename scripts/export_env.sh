# Source this with the CONTEXT and NETWORK env set, containing the full path and
# supported network name.
# e.g.
# CONTEXT=$PWD NETWORK=mainnet testnet or mary_qa etc  scripts/export_env.sh

export BIN_DIR=${CONTEXT}/bin
export CONFIG_DIR=${CONTEXT}/config/network/${NETWORK}

case "$NETWORK" in
        mainnet)
            RELAY_PORT=3001
            BP_PORT=3002
            SUBNET=192.168.33
            ;;
        testnet)
            RELAY_PORT=3003
            BP_PORT=3004
            SUBNET=192.168.34   
            ;;
        mary_qa)
            RELAY_PORT=3005
            BP_PORT=3006
            SUBNET=192.168.35
            ;;
esac

export ALLOW_INTROSPECTION=true
export RELAY_PORT
export BP_PORT
export SUBNET
export NETWORK
