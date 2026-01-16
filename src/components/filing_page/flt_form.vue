<script setup>
    import {ref} from 'vue';

    const testvar = ref();
    const Destination = ref();
    const Alternate = ref();
    
    const props = defineProps({
            filing_command: Text
        })
</script>

<template>
    <v-card variant="outlined" class="FLTInfoBox">
        <v-card variant="outlined" class="FLTInfoBoxLayer2">
            <v-label class="Category"> Origin </v-label>
            <hr>
            <v-text-field variant="filled" name="Origin" type="text" class="input" v-model="testvar" placeholder="ETNL"/>
        </v-card>

        <v-card variant="outlined" class="FLTInfoBoxLayer2">
            <v-label class="Category"> Destination </v-label>

        </v-card>

        <v-card variant="outlined" class="FLTInfoBoxLayer2">
             <v-label class="Category"> Alternate </v-label>

        </v-card>
    </v-card>
    <v-card variant="outlined" class="FLTInfoBox">

    </v-card>
</template>

<style scoped>
    .input {
        border-radius: 5%;
        margin: 3%;
    }

    .vertical {
        border-left: 2px solid rgb(200, 0, 200);
        height: 100%;              
        margin: 0 20px;   
    }

    hr {
        display: block;
        height: 1px;
        border: 0;
        border-top: 1px solid rgb(200, 0, 200);
        margin: 4px 0;
        padding: 0;
    }

    .FrequencyContainer {
        display: flex;
        justify-content: space-around;
        background-color: transparent;
    }
    .Category {
        color: rgb(200, 0, 200);;
        font-size: 90%;
        margin-left: 5%;
        font-weight: bold;
        text-align: center;
    }
    .Label {
        color: rgb(80, 180, 185);;
        font-size: 25%;
    }
    .Frequency {
        color: rgb(120, 220, 225);;
        font-size: 35%;
        margin-left: 7%;
        text-align: left;
    }
    .FLTInfoBoxLayer2 {
        align-content: top;
        height: fit-content;
        margin: 2%;
        padding-left: 2%;
        padding-right: 2%;
        width: 100%;
        color:rgb(200, 0, 200);
        background-color: rgb(80, 80, 100);
    }
    .FLTInfoBox {
        display: flex;
        justify-content: space-evenly;
        background-color: rgb(100,0,200);
        margin: 2vh;
        height:31vh;
        margin-top: 2vh;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(200, 0, 200);
        font-size: 3vw;
        background-image: repeating-linear-gradient(45deg,rgb(60, 60, 80),rgb(80, 80, 100));
    }
</style>