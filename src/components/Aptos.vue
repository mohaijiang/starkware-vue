<template>
  <h1> aptos</h1>
</template>

<script setup>
import { PetraWallet } from "petra-plugin-wallet-adapter";
import {WalletCore} from '@aptos-labs/wallet-adapter-core'
import {onMounted} from "vue";

onMounted(()=>{

  const arr = [ new PetraWallet()]
  const wallet = new WalletCore(arr)
  console.log(wallet)
  wallet.connect("Petra").then(() => {
    console.log('connect functioned ')

    console.log(wallet.account)
  })

})

</script>

<style scoped>

</style>
