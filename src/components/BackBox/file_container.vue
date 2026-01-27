<script setup>
    import VersionBar from "./VersionBar.vue";
    import FilingForm from "../filing_page/flt_form.vue";

    const props = defineProps({
        version: Number,
        user: Text
    })
</script>

<template>
    <section class="background_container">
        <div class="flt_container">
            <VersionBar :version="version" page="Flight filing"/>
            <div style="height: 60%;">
                <FilingForm :user="user"/>
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