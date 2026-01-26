<script setup>
import { array, string } from 'i/lib/util';
import { Box } from 'vuetify/lib/util/box';

    const props = defineProps({
        name: Text,
        code: Text,
        qnh: Text,
        rnw: Number,
        state: Text,
        metar: Text,
        misc: Text,
        positions: Array,
    })
</script>


<template>
    <v-card variant="outlined" elevation="1" class="apt_full_name">{{ name }} - <span class="apt_icao_code">{{ code }}</span>  </v-card>
    
    <v-card variant="outlined" class="APTInfoBox">
        <v-card variant="outlined" v-for="(position,index) in positions" class="APTInfoBoxLayer2">
            <v-label class="Category"> {{position.position}} &nbsp;
                <span v-if="position.emergency" class="emergency"> ▇ </span>
                <span v-else-if="position.active" class="active"> ▇ </span>
                <span v-else="position.active" class="offline"> ▇ </span>
            </v-label>
            <div class="FrequencyContainer"> 
                <v-label class="Label"> Controller </v-label>
                <v-label class="Frequency"> {{ position.user }}</v-label>
            </div>
            <hr>
            <div  v-for="(freq,name) in position.freq" class="FrequencyContainer"> 
                <v-label class="Label"> {{ freq.note }} </v-label>
                <v-label class="Frequency"> {{ freq.frequency }}</v-label>
            </div>
            <hr>
            <div class="FrequencyContainer"> 
                <v-label class="Label"> Remarks </v-label>
                <v-label class="Frequency"> {{ misc }} </v-label>
            </div>
        </v-card>    
    </v-card>
    
    <v-card variant="outlined" elevation="" class="APTInfoBox"> 
        <v-card variant="outlined" class="APTInfoBoxLayer2">
            <v-card elevation="0" class="FrequencyContainer">
                <v-label class="Label"> QNH </v-label>
                <v-label class="Frequency"> {{ qnh }}</v-label>
                <v-card style="border-left: 2px solid rgb(200, 0, 200); height: 100%; width: 1px;"></v-card>
                <v-label class="Label"> State </v-label>
                <v-label class="Frequency"> {{ state }}</v-label>
            </v-card>
            <hr>
            <v-card elevation="0" class="FrequencyContainer">
                <v-label class="Label"> Metar </v-label>
                <v-label class="Frequency"> {{ metar }}</v-label>
            </v-card>
            <hr>
            <v-card elevation="0" class="FrequencyContainer">
                <v-label class="Label" style="font-size: 45%;"> Additional Notes </v-label>
            </v-card>
            <v-card elevation="0" class="FrequencyContainer">
                <v-label class="Frequency"> {{ misc }}</v-label>
            </v-card>
        </v-card>
    </v-card>
</template>

<style scoped>
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

    .active {
        color: rgb(100, 255, 150);
        text-shadow:
        -1px -1px 0 rgb(200, 0, 200),  
         1px -1px 0 rgb(200, 0, 200),
        -1px  1px 0 rgb(200, 0, 200),
         1px  1px 0 rgb(200, 0, 200); 
    }
    
    .emergency {
        color: rgb(255, 25, 125);
        text-shadow:
        -1px -1px 0 rgb(200, 0, 200),  
         1px -1px 0 rgb(200, 0, 200),
        -1px  1px 0 rgb(200, 0, 200),
         1px  1px 0 rgb(200, 0, 200); 
    }
    .offline {
        color: gray;
        text-shadow:
        -1px -1px 0 rgb(200, 0, 200),  
         1px -1px 0 rgb(200, 0, 200),
        -1px  1px 0 rgb(200, 0, 200),
         1px  1px 0 rgb(200, 0, 200); 
    }
    .Category {
        color: rgb(200, 0, 200);;
        font-size: 80%;
        margin-left: 5%;
        text-align: left;
        font-weight: bold;
    }
    .Label {
        color: rgb(80, 180, 185);;
        font-size: 25%;
        width: 25%;
        display: flex;
        justify-content: center;
        align-items: center;
        text-align: center;
    }
    .Frequency {
        color: rgb(120, 220, 225);;
        font-size: 35%;
        margin-left: 0%;
        display: flex;
        justify-content: center;
        align-items: center;
        width: 25%;
        text-align: center;
    }
    .apt_icao_code {
        background-image: linear-gradient(to right,rgb(150, 150, 255),rgb(150, 250, 255));
        -webkit-background-clip: text;
        background-clip: text;
        color:transparent;
        font-size: 4vw;
    }
    .apt_full_name {
        margin: 2vh;
        width: max-content;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(255, 0, 255);
        font-size: 2vw;
        background-image: repeating-linear-gradient(45deg,rgb(80, 80, 100),rgb(100, 100, 120));
        opacity: 0.5;
        float: top;
    }
    .APTInfoBoxLayer2 {
        display: flex;
        flex-direction: column;
        margin: 2.5%;
        width: 100%;
        color:rgb(200, 0, 200);
        background-color: rgb(80, 80, 100);
    }
    .APTInfoBox {
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