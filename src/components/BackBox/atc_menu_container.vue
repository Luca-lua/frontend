<script setup>
    import ATC_login from "../management_page/ATC_login.vue";
    import VersionBar from "./VersionBar.vue";
    import {ref} from 'vue';
    import ATC_management_window from "../management_page/ATC_management_window.vue";

    const selected_page = ref("ATC-Login");

    const props = defineProps({
        version: Number,
    })
</script>

<template>
    <section class="background_container">
        <div class="flt_container">
            <VersionBar :version="version" :page="selected_page"/>
            <div style="height: 60%;">
                <ATC_management_window v-if="selected_page=='logged_in'"/>
                <ATC_login v-if="selected_page=='ATC-Login'"/>
            </div>
        </div>
    </section>
</template>


<style scoped>
    .flt_container {
      background-color: rgb(40, 50, 60);
      height: 90%;
      padding-bottom: 1%;
      margin-left: 7%;
      margin-right: 7%;
      border-radius: 2%;
      margin-bottom: 50%;
    }

    .background_container {
      flex: 1;
      height: 100%;
      width: 100%;
      background-color: rgb(50, 50, 50);
      padding: 0%;
      padding-top: 2%;
      float: left;
    }
</style>