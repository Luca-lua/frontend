<script setup>
  import { ref } from 'vue'
  import { reactive } from 'vue'
  import station_view from "@/components/Stations_page/station_container.vue"
  import flt_view from "@/components/BackBox/flt_container.vue"
  import file_view from "@/components/BackBox/file_container.vue"

  const version = ref(0.25);

  const filing_command = ref('curl -v -X POST "http://127.0.0.1:5000/post-flightplan/TestUser" -H "Content-Type: application/json" -d @Data.json');

  const apt_data = reactive([
    {id:0 ,code: "ETNW",name: "Wunstorf Airport",positions: {TWR: {note:"TestNote" ,active: true ,user: "TestUser" ,emergency: false ,Freq: {freq1:'123.400',freq2:'322.250'}},GND: {note:"" ,active: false ,user: "TestUser" ,emergency: true ,Freq: {freq:'243.5'}}},rnw: 27 ,qnh: '29.29' ,state: "Test" ,metar: "TEST", misc: "-"},
    {id:1 ,code: "ETNL",name: "Laage Airport",positions: {TWR: {note:"" ,active: false ,user: "" ,emergency:false ,Freq: { freq:'123.4'}},APR: {note:"" ,active: false ,user: "" ,emergency: false, Freq: {freq:'33.250'}}},rnw: 27 ,state: "Test" ,qnh: '29.92' ,metar: "TEST",misc: "-"},
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
        <v-tab value="filer"  class="tab">File a flight</v-tab>
        <v-tab value="station_settings"  class="tab">Station editor</v-tab>
        <!--<img class="header_fade_strip">-->
      </v-tabs>
  
    
      <!-- Pages -->
      <v-tabs-window v-model="tab">
        <v-tabs-window-item value="stations">
          <station_view :apt_data="apt_data" :version="version" />
        </v-tabs-window-item>
        <v-tabs-window-item value="search">
          <flt_view :version="version"/> 
        </v-tabs-window-item>
        <v-tabs-window-item value="filer">
          <file_view :version="version"/>
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
