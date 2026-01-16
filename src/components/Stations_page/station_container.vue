<template>
    <section class="apt_container">
        <button v-if="apt_counter_selection > 0" v-on:click="apt_counter_selection--" class="apt-previous"> < </button>
        <button v-if="apt_counter_selection < apt_data.length-1" v-on:click="apt_counter_selection++" class="apt-next"> > </button>
        <div class="station_container">
            <VersionBar page="ATC Status" :version="version"/>
            <div v-for="apt in apt_data" :key="apt.code">
                <div v-if="apt.id == apt_counter_selection" style="height: 60%" >
                  <APTInfoPanel :name="apt.name" :code="apt.code" :positions="apt.positions" :state="apt.state" :qnh="apt.qnh" :rnw="apt.rnw" :metar="apt.metar" :misc="apt.misc" />
                </div>
            </div>
        </div>
    </section>
</template>

<style scoped>
.apt-previous {
  margin: 1%;
  margin-top: 50vh;
  width: 3%;
  height: 3vw;
  color: rgb(100, 200, 100);
  float:left;
  border-radius: 30%;
  transition:
    width 0.5s,
    height 0.5s,
    background-color 0.5s,
    rotate 0.5s;
}
.apt-previous:hover {
  cursor:pointer;
  background-color: rgba(100, 200, 100, 0.5);
  margin: 1%;
  margin-top: 50vh;
  width: 2.9%;
  height: 2.9vw;
  color: rgb(100, 200, 100);
  float:left;
  rotate: -2deg;
}

.apt-next {
  margin: 2%;
  margin-top: 50vh;
  width: 3%;
  height: 3vw;
  color: rgb(100, 200, 100);
  float:right;
  border-radius: 30%;
  transition:
    width 0.5s,
    height 0.5s,
    background-color 0.5s,
    rotate 0.5s;
}
.apt-next:hover {
  cursor:pointer;
  background-color: rgba(100, 200, 100, 0.5);
  margin: 2%;
  margin-top: 50vh;
  width: 2.9%;
  height: 2.9vw;
  color: rgb(100, 200, 100);
  float:right;
  rotate: 2deg;
}

.station_container {
  background-color: rgb(40, 50, 60);
  height: 90%;
  padding-bottom: 1%;
  margin-left: 7%;
  margin-right: 7%;
  border-radius: 2%;
  margin-bottom: 50%;
}

.apt_container {
  flex: 1;
  height: 100%;
  width: 100%;
  background-color: rgb(50, 50, 50);
  padding: 0%;
  padding-top: 2%;
  float: left;
}
</style>

<script setup>
    import {ref} from "vue"
    import VersionBar from "../BackBox/VersionBar.vue";
    import APTInfoPanel from "./APTInfo.vue"
    const apt_counter_selection = ref(0);

    const props = defineProps({
        apt_data: Array,
        version: Number,
    })
</script>