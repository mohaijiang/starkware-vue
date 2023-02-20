<template>
  <img alt="Vue logo" src="./assets/logo.png">
<!--  <HelloWorld msg="Welcome to Your Vue.js App"/>-->
  <StartWare />
</template>

<script>
// import HelloWorld from './components/HelloWorld.vue'
import StartWare from "@/components/StartWare";

export default {
  name: 'App',
  components: {
    // HelloWorld
    StartWare
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
