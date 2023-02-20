<template>
    <h1>Hello StarkWare</h1>

    <div>
      <h2> l2IsConnected:  {{ l2IsConnected }}</h2>
    </div>
    <button @click="l2Connect">connect</button>
    <button @click="handlerAddress">Get Address</button>
    <button @click="deployContract">Deploy Contract</button>
</template>

<script  setup >
import { useStore, mapActions} from 'vuex'
import { connect, getStarknet } from "@argent/get-starknet"


import compiledContract from '../constracts/contract_compiled.json'
import {onMounted, ref} from "vue";

const wallet = ref({})

// contract_compiled.json classHash
const classHash = "0x399998c787e0a063c3ac1d2abac084dcbe09954e3b156d53a8c43a02aa27d35"

const store = useStore();

const l2Connect = mapActions("stark",['l2ConnectWallet']).l2ConnectWallet.bind({
  $store: store
});

const l2IsConnected = store.state["stark/l2IsConnected"]

console.log(compiledContract)

const handlerAddress = () => {

  const chainName = store.getters["stark/l2ChainName"]

  console.log(chainName)
}

const connectWallet = async () => {
  const windowStarknet = await connect({
    include: ["argentX"],
  })
  await windowStarknet?.enable({ starknetVersion: "v4" })
  return windowStarknet
}

const deployContract = async () => {

  const response = await wallet.value.account.deploy({
    classHash: classHash,
    constructorCalldata: []
  })
  console.log(response.transaction_hash)
  console.log(response.contract_address)
  // const provider = new Provider({
  //   sequencer: {
  //     baseUrl: 'https://alpha4.starknet.io',
  //     feederGatewayUrl: 'feeder_gateway',
  //     gatewayUrl: 'gateway',
  //   }
  // })
  //
  // const activeAccount = "0x215e3d4c42b32b05429902adf90137fe3ca62056ea51a8d026165bf140f9fa2"
  // //TODO... Here use keypair with ec and privateKey . How Can I get keypair from wallet ?
  // const account = new Account(provider,activeAccount,starkKeyPair)
  // account.declare({
  //   classHash: classHash,
  //   contract: compiledContractObj
  // }).then(resp => {
  //   console.log(resp.transaction_hash)
  // })
}
//
onMounted(()=>{
  connectWallet().then(data => {
    wallet.value = data
  })
})

</script>

<style scoped>

</style>
