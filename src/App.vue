<script setup>
  import { ref } from 'vue'
  import { reactive } from 'vue'
  import station_view from "@/components/Stations_page/station_container.vue"
  import flt_view from "@/components/BackBox/flt_container.vue"
  import file_view from "@/components/BackBox/file_container.vue"
  import atc_configs_container from "@/components/BackBox/atc_menu_container.vue"

  const version = ref(0.25);
  const tab = ref('stations');
</script>

<template>
  <section class="background">
    <!-- Page Selection bar -->
    <v-sheet elevation="1" class="header_fade_strip">
      <v-tabs color="rgba(255,0,180,1)" v-model="tab">
        <v-tab value='stations'  class="tab">Manned Stations</v-tab>
        <v-tab value='search'  class="tab">Flight Search</v-tab>
        <v-tab value='filer'  class="tab">File a flight</v-tab>
        <v-tab value='atc_configs'  class="tab">ATC menu</v-tab>
      </v-tabs>
  
    
      <!-- Pages -->
      <v-tabs-window v-model="tab">
        <v-tabs-window-item value='stations'>
          <station_view :version="version" />
        </v-tabs-window-item>
        <v-tabs-window-item value='search'>
          <flt_view :version="version"/> 
        </v-tabs-window-item>
        <v-tabs-window-item value='filer'>
          <file_view :version="version"/>
        </v-tabs-window-item>
        <v-tabs-window-item value='atc_configs'>
          <atc_configs_container :version="version"/>
        </v-tabs-window-item>
      </v-tabs-window>
    </v-sheet>    
  </section>
</template>

<style scoped>
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
