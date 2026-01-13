<script setup>
    import { array, string } from 'i/lib/util';

    const props = defineProps({
        name: Text,
        code: Text,
    })
</script>


<template>
    <v-card variant="outlined" elevation="1" class="apt_full_name">{{ name }} - <span class="apt_icao_code">{{ code }}</span>  </v-card>
    
    <v-card variant="outlined" class="APTInfoBox">
        <v-card variant="outlined" class="APTInfoBoxLayer2">
                
        </v-card>    
    </v-card>
    
    <v-card variant="outlined" elevation="" class="APTInfoBox"> 

    </v-card>
</template>

<style scoped>
    .Category {
        font-size: 2vw;
        font-weight: bold;
    }
    .apt_icao_code {
        background-image: linear-gradient(to right,rgb(150, 150, 255),rgb(150, 250, 255));
        -webkit-background-clip: text;
        background-clip: text;
        color:transparent;
        font-size: 5vw;
    }
    .apt_full_name {
        margin: 2vh;
        width: max-content;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(255, 0, 255);
        font-size: 3vw;
        background-image: repeating-linear-gradient(45deg,rgb(80, 80, 100),rgb(100, 100, 120));
        opacity: 0.5;
    }
    .APTInfoBoxLayer2 {
        width: 45%;
        margin: 2.5%;
        color:rgb(200, 0, 200);
        height: 48%;
        background-color: rgb(80, 80, 100);
    }
    .APTInfoBox {
        background-color: rgb(100,0,200);
        margin: 2vh;
        height:29vh;
        margin-top: 3vh;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(200, 0, 200);
        font-size: 3vw;
        background-image: repeating-linear-gradient(45deg,rgb(80, 80, 100),rgb(100, 100, 120));
        opacity: 0.5;
    }
</style>