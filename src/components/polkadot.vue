<script setup>
  import { ApiPromise, WsProvider } from '@polkadot/api';
  import { web3Accounts, web3Enable, web3FromAddress } from '@polkadot/extension-dapp';
  const allInjected = await web3Enable('my cool dapp');
  console.log(allInjected)
  const allAccounts = await web3Accounts();
  console.log(allAccounts)
  const SENDER = '5Cta923XaZyEpXvG2dqpexSGtnFDqPbJdos84m9nB7NAkCsS'
  const wsProvider = new WsProvider('ws://127.0.0.1:9944');
  // const wsProvider = new WsProvider('wss://ws.aishow.hamsternet.io');
  const api = await ApiPromise.create({provider: wsProvider});
  console.log(api)

  const transfer = async () => {

      const injector = await web3FromAddress(SENDER)
      console.log(api)
      await api.tx.balances
          .transfer({Id: SENDER}, '10000000000000000')
          .signAndSend(SENDER, {signer: injector.signer}, (status) => {
              console.log(status)
          });
    // .transfer({Id: '5FHneW46xGXgs5mUiveU4sbTyGBzmstUspZC92UhjJM694ty'}, '10000000000000000')
  }

  const uploadModel = async () => {
      const injector = await web3FromAddress(SENDER)
      await api.tx.aiModel.createAiModel(
          'a2',
          'name',
          'some_link',
          ['image'],
          ['image_link'],
          2000,
          'some-comment'
      ).signAndSend(SENDER, {signer: injector.signer}, (result) => {
          console.log(result.status)
      });
  }

  const uploadImage = async ()=> {
      const injector = await web3FromAddress(SENDER)
      const unsub =  await api.tx.aiModel.createAiImage(
          'a2',
          'name',
          ['image'],
          ['image_link'],
          'some-comment'
      ).signAndSend(SENDER, {signer: injector.signer}, (result) => {
          console.log(result.status)
          if (result.status.isInBlock) {
              console.log(`Transaction included at blockHash ${result.status.asInBlock}`);
          } else if (result.status.isFinalized) {
              console.log(`Transaction finalized at blockHash ${result.status.asFinalized}`);
              unsub();
          }
      });
  }

  const buyModel = async ()=> {
      const injector = await web3FromAddress(SENDER)
      const unsub =  await api.tx.aiModel.buyModel(
          '1'
      ).signAndSend(SENDER, {signer: injector.signer}, (result) => {
          console.log(result.status)
          if (result.status.isInBlock) {
              console.log(`Transaction included at blockHash ${result.status.asInBlock}`);
          } else if (result.status.isFinalized) {
              console.log(`Transaction finalized at blockHash ${result.status.asFinalized}`);
              unsub();
          }
      });
  }

  const create = async () => {

      const injector = await web3FromAddress(SENDER)
      const unsub =  await api.tx.nfts.create(
          {Id: SENDER},
          {
              settings: "1",
              maxSupply: null,
              mintSettings: {
                  defaultItemSettings: "0",
                  endBlock: null,
                  mintType: "Issuer",
                  price: null,
                  startBlock: null,
              }
          },
      ).signAndSend(SENDER, {signer: injector.signer}, (result) => {
          console.log(result.status)
          if (result.status.isInBlock) {
              console.log(`Transaction included at blockHash ${result.status.asInBlock}`);
          } else if (result.status.isFinalized) {
              console.log(`Transaction finalized at blockHash ${result.status.asFinalized}`);
              unsub();
          }
      });
  }

  const mint = async () => {
      const injector = await web3FromAddress(SENDER)
      const unsub =  await api.tx.nfts.mint(
          '1',
          '1',
          {Id: '5Cta923XaZyEpXvG2dqpexSGtnFDqPbJdos84m9nB7NAkCsS'},
          null,
      ).signAndSend(SENDER, {signer: injector.signer}, (result) => {
          console.log(result.status)
          if (result.status.isInBlock) {
              console.log(`Transaction included at blockHash ${result.status.asInBlock}`);
          } else if (result.status.isFinalized) {
              console.log(`Transaction finalized at blockHash ${result.status.asFinalized}`);
              unsub();
          }
      });
  }

  const modelList = async () => {

      const result = await api.query.aiModel.aiModels("a1")
      console.log(result.toHuman())
  }

  const postList = async () => {
      const result = await api.query.aiModel.modelPost("a1")
      console.log(result.toHuman())
  }

  const setCollectionMetadata = async () => {
      const injector = await web3FromAddress(SENDER)
      const unsub =  await api.tx.nfts.setCollectionMetadata(
          '3',
          'this is collection 3 metadata',
      ).signAndSend(SENDER, {signer: injector.signer}, (result) => {
          console.log(result.status)
          if (result.status.isInBlock) {
              console.log(`Transaction included at blockHash ${result.status.asInBlock}`);
          } else if (result.status.isFinalized) {
              console.log(`Transaction finalized at blockHash ${result.status.asFinalized}`);
              unsub();
          }
      });
  }

  const nftCollectionList = async () => {
      const result = await api.query.nfts.collection.entries()
      for(let item of result){
          console.log(item)
      }
  }
</script>

<template>
  <div>
      <label>hello</label>
      <h1>polkadot</h1>
      <button @click="transfer">transfer</button>

      <div>
          <label>操作</label>
          <ul>
              <li><label>上传模型</label><button @click="uploadModel">upload model</button></li>
              <li><label>上传图片</label><button @click="uploadImage">upload image</button></li>
              <li><label>购买模型</label><button @click="buyModel">buy model</button></li>
              <li><label>NFT 创建作品集</label><button @click="create">create</button></li>
              <li><label>NFT 作品集配置备注：<button @click="setCollectionMetadata">setCollectionMetadata</button></label></li>
              <li><label>NFT mint</label><button @click="mint">mint</button></li>
              <li><label>模型列表：<button @click="modelList">modelList</button></label></li>
              <li><label>post 列表： <button @click="postList">postList</button></label></li>
              <li><label>nft列表：<button @click="nftCollectionList">nftCollectionList</button></label></li>
          </ul>
      </div>
  </div>
</template>

<style scoped>

</style>
