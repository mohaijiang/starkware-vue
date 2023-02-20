<template>
    <h1>Hello StarkWare</h1>

    <div>
      <h2> l2IsConnected:  {{ l2IsConnected }}</h2>
    </div>
    <button @click="l2Connect">connect</button>
    <button @click="handlerAddress">Get Address</button>
    <button @click="declare">Declare</button>
    <button @click="deployContract">Deploy Contract</button>

    <div>
      <h2>
        <label>contract address: {{contract_address}} </label>
      </h2>
      <div>
        <button @click="executeGet">get_balance</button>
        <button @click="executeSet">increase_balance</button>
      </div>
    </div>
</template>

<script  setup >
import { useStore, mapActions} from 'vuex'
import { connect, getStarknet } from "@argent/get-starknet"


import compiledContract from '../constracts/ERC20.cairo.starknet.output.json'
import {onMounted, ref} from "vue";
import {stark,number} from "starknet";

const wallet = ref({})
const contract = ref({})
const contract_address = ref('0x72e5a285631a6b94afc0f78ce3161c884516e8204daecc05a423f1088076470')

// contract_compiled.json classHash
const classHash = "0x0399998c787e0a063c3ac1d2abac084dcbe09954e3b156d53a8c43a02aa27d35"

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

  const receiptResponsePromise = await wallet.value.account.waitForTransaction(response.transaction_hash,undefined, ['ACCEPTED_ON_L2'])
  if (receiptResponsePromise.status === 'ACCEPTED_ON_L2') {
    contract_address.value = response.contract_address[0]
  }
}

const executeGet = async ()=> {

  const callResp = await wallet.value.account.callContract({
    contractAddress: contract_address.value,
    calldata: stark.compileCalldata({
    }),
    entrypoint: 'get_balance',
  })
  const firstReturnData = callResp.result[0]
  console.log(number.toFelt( firstReturnData))

}

const executeSet = async () => {
  const invokeResponse = await wallet.value.account.execute({
    contractAddress: contract_address.value,
    entrypoint: 'increase_balance',
    calldata: stark.compileCalldata({
      amount: '10'
    })
  })

  console.log(invokeResponse.transaction_hash)
}

const declare = async () => {
  const resp = await wallet.value.account.declare({
    contract: ``,
    classHash: classHash,
  })

  console.log(resp.transaction_hash)
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
