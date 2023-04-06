<template>
  <img alt="Vue logo" src="./assets/logo.png">
<!--  <HelloWorld msg="Welcome to Your Vue.js App"/>-->
<!--  <StartWare />-->
  <Ether/>
<!--    <Aptos/>-->
<!--  <Sui/>-->
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
// import StartWare from "@/components/StartWare";
import Ether from "@/components/Ether"
// import Aptos from "@/components/Aptos";
// import Sui from "@/components/Sui.vue";

export default {
  name: 'App',
  components: {
    // Sui
    // Aptos,
    // HelloWorld
    // StartWare
    Ether
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
