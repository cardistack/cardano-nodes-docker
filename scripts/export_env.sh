# Source this with the CONTEXT and NETWORK env set, containing the full path and
# supported network name.
# e.g.
# CONTEXT=$PWD NETWORK=mainnet testnet or mary_qa, alonzo_blue etc  scripts/export_env.sh

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
        alonzo_blue)
            RELAY_PORT=3007
            BP_PORT=3008
            SUBNET=192.168.36
            ;;
         alonzo)
            RELAY_PORT=3008
            BP_PORT=3009
            SUBNET=192.168.37
            ;;
esac

export ALLOW_INTROSPECTION=true
export RELAY_PORT
export BP_PORT
export SUBNET
export NETWORK
