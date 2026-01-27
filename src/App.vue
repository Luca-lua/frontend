<script setup>
  import { ref } from 'vue'
  import station_view from "@/components/Stations_page/station_container.vue"
  import flt_view from "@/components/BackBox/flt_container.vue"
  import file_view from "@/components/BackBox/file_container.vue"
  import LoginScreen from "./components/BackBox/LoginContainer.vue"
  import management_container from './components/BackBox/management_container.vue'

  const permission = ref(0);
  const version = ref(0.25);
  const user = ref("");
  const lockpage = ref(true);
  const lockfilingpage = ref(true);
  const lockmanagementpage = ref(true);
  const tab = ref('login');

  function handleUserChange(value)
  {
    user.value = value
  }
  function handlePermission(value) // Permission returned for the Database "logininfo" 0 = Spectator 1 = Filing, 2 = Atc
  {
    permission.value = value
    if(value >= 0)
    {
      tab.value = "stations"
      lockpage.value = false
    }
    if(value >= 1)
    {
      lockfilingpage.value = false
    }
    if(value >=2)
    {
      lockmanagementpage.value = false
    }
  }
  function resetPermission()
  {
    user.value = ""
    tab.value = "login"
    permission.value = 0
    lockfilingpage.value = true
    lockmanagementpage.value = true
    lockpage.value = true
  }
</script>

<template>
  <section class="background">
    <!-- Page Selection bar -->
    <v-sheet elevation="1" class="header_fade_strip">
      <v-tabs color="rgba(255,0,180,1)" v-model="tab">
        <v-tab value='stations' :disabled="lockpage" class="tab">Manned Stations</v-tab>
        <v-tab value='search' :disabled="lockpage" class="tab">Flight Search</v-tab>
        <v-tab value='filer':disabled="lockfilingpage" class="tab">File a flight</v-tab>
        <v-tab value='atc_configs' :disabled="lockmanagementpage" class="tab">ATC menu</v-tab>
      </v-tabs>
  
    
      <!-- Pages -->
      <v-tabs-window v-model="tab">
        <v-tabs-window-item value='login'>
          <login-screen @user="handleUserChange" @permission="handlePermission" :version="version" />
        </v-tabs-window-item>
        <v-tabs-window-item value='stations'>
          <station_view :version="version" />
        </v-tabs-window-item>
        <v-tabs-window-item value='search'>
          <flt_view :version="version"/> 
        </v-tabs-window-item>
        <v-tabs-window-item value='filer'>
          <file_view :version="version" :user="user"/>
        </v-tabs-window-item>
        <v-tabs-window-item value='atc_configs'>
          <management_container :version="version"/>        
        </v-tabs-window-item>
      </v-tabs-window>
    </v-sheet>    

  <button class="bottom_bar" style="text-align: right;" v-on:click="resetPermission">log out</button>
  </section>
</template>

<style scoped>
.bottom_bar {
  width: 20%;
  float: right;
  color: rgb(150,100,250);
  font-size: 150%;
}
.tab {
  background-color: transparent;
  color: rgb(200,0,200);
}
.header_fade_strip {
  background-image: linear-gradient(to right, rgb(0,100,240), rgb(200,0,200));
  width: 100%;
  outline: 1px;
  outline-style: solid;
  outline-color: gray;
}

.background {
  background-color: rgb(25, 25, 50);
  height: 100vh;
  width: 100vw;
  min-height: 100%;
  touch-action: none;
  overflow: scroll;
  scroll-behavior: auto;
}

.body {
  flex: 1;
  height: 100%;
  width: 100%;
  background-color: rgb(50, 50, 50);
  padding: 6%;
  padding-top: 2%;
}
</style>
