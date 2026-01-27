<script setup>
    import loginfield from "./LoginBox.vue";
    import VersionBar from "./VersionBar.vue";
    import {ref} from 'vue';
    import ATC_management_window from "../management_page/management_window.vue";

    const emit = defineEmits(['permission','user'])
    function returnPermissions(value)
    {
        emit('permission',value)
    }
    function returnUser(value)
    {
        emit('user',value)
    }

    const props = defineProps({
        version: Number,
    })
</script>

<template>
    <section class="background_container">
        <div class="flt_container">
            <VersionBar :version="version" page="Filing System login"/>
            <div style="height: 60%;">
                <loginfield @user="returnUser" @permission="returnPermissions" LoginHeader="Login"/>
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