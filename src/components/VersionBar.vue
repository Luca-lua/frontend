<template>
    <v-card class="top_bar">
        <label class="VersionLine"> ATC status <span class="VersionNumber">V{{ version }}</span> </label>
    </v-card>
</template>

<style>
    .top_bar {
    width: 100%;
    height: 10%;
    padding-top: 0.5%;
    background-color: rgb(20, 20, 20);
    border-top-left-radius: 2vh;
    border-top-right-radius: 2vh;
    opacity: 0.3;
    }
    .VersionLine {
        font-size: min(4vh,9vw);
        background-image: linear-gradient(to right,rgb(150, 150, 255),rgb(150, 250, 255));
        -webkit-background-clip: text;
        background-clip: text;
        color:transparent;
        margin-left: 3%;
    }
    .VersionNumber {
        font-size: min(5vh,10vw);
        background-image: linear-gradient(to right,rgb(120, 100, 255),rgb(255, 0, 255));
        -webkit-background-clip: text;
        background-clip: text;
        color:transparent;
    }
</style>

<script setup>
    const props = defineProps({
        version: Number
    })
</script>