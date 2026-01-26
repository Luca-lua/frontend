<script setup>
    import {onMounted, reactive, ref} from "vue"
    import VersionBar from "../BackBox/VersionBar.vue";
    import APTInfoPanel from "./APTInfo.vue"
    import { array } from "i/lib/util";
    const apt_counter_selection = ref(1);

    class apt {
      constructor(id,code,name,stations,rnw,qnh,state,metar,misc) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.stations = stations;
        this.rnw = rnw;
        this.qnh = qnh;
        this.state = state;
        this.metar = metar;
        this.misc = misc;
      }
    }
    const apt_data = reactive({});
    function getAptData()
    {
      const url = "http://127.0.0.1:5000/get-airportdata";
      console.log(url)
      let response = fetch(url,{
        method: 'GET',
        mode: 'cors',
      });
     response
      .then(res => {
        if (!res.ok) {
          throw new Error(`HTTP error! status: ${res.status}`);
        }
        return res.json();
      })
      .then(data => {
        console.log(apt_data);
        console.log("Server response:", data);
        Object.values(data).map(a =>
          apt_data[a.id] = new apt(
            a.id,
            a.code,
            a.name,
            a.stations,
            a.rnw,
            a.qnh,
            a.state,
            a.metar,
            a.misc
          )
        );
        console.log(apt_data);
        apt_data.length = Object.keys(apt_data).length;
      })
      .catch(err => {
        console.error("Fetch error:", err);
      });
    console.log(apt_data)
  }

    const props = defineProps({
        version: Number,
    })
    onMounted(() => {
      getAptData();
      window.setInterval(()=>{
        getAptData();
      },30000)
    })
</script>

<template>
    <section class="apt_container">
        <button v-if="apt_counter_selection > 1" v-on:click="apt_counter_selection--" class="apt-previous"> < </button>
        <button v-if="apt_counter_selection < apt_data.length-1" v-on:click="apt_counter_selection++" class="apt-next"> > </button>
        <div class="station_container">
            <VersionBar page="ATC Status" :version="version"/>
            <div v-for="apt in apt_data" :key="apt.id">
                <div v-if="apt.id == apt_counter_selection" style="height: 60%" >
                  <APTInfoPanel :name="apt.name" :code="apt.code" :positions="apt.stations" :state="apt.state" :qnh="apt.qnh" :rnw="apt.rnw" :metar="apt.metar" :misc="apt.misc" />
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