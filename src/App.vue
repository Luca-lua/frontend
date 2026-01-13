<script setup>
  import { ref } from 'vue'
  import { reactive } from 'vue'
  import station_view from "@/components/station_container/station_container.vue"

  const version = ref(0.25);

  const apt_data = reactive([
    {id:0 ,code: "ETNW",name: "Wunstorf Airport",positions: {TWR: { active: true,freq: 123.4},GND: {active: false,freq: 243.5}},metar: "TEST"},
    {id:1 ,code: "ETNL",name: "Laage Airport",positions: {TWR: {active: false,freq: 123.4},APR: {active: false,freq: 33.250}},metar: "TEST"},
  ])

  const tab = ref('stations')
</script>

<template>
  <section class="background">
    <!-- Page Selection bar -->
    <v-sheet elevation="1" class="header_fade_strip">
      <v-tabs color="rgba(255,0,180,1)" v-model="tab">
        <v-tab value="stations"  class="tab">Manned Stations</v-tab>
        <v-tab value="search"  class="tab">Flight Search</v-tab>
        <!--<img class="header_fade_strip">-->
      </v-tabs>
  
    
      <!-- Pages -->
      <v-tabs-window v-model="tab">
        <v-tabs-window-item value="stations">
          <station_view :apt_data="apt_data" :version="version" />
        </v-tabs-window-item>
        <v-tabs-window-item value="search">
          <v-sheet class="pa-5" color="orange">Two</v-sheet>
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
  overflow: hidden;
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
