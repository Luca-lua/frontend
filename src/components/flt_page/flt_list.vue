<script setup>
    import { skipPartiallyEmittedExpressions } from 'typescript';
import { ref,reactive } from 'vue';

    const flights = reactive(["Empty"]);

    const arrivalFilter = ref();
    const departureFilter = ref();
    const departureBeforeFilter = ref();
    const departureAfterFilter = ref();
    const arrivalBeforeFilter = ref();
    const arrivalAfterFilter = ref();
    const remarkFilter = ref();
    
    function replaceNullSTR(Var)
    {
        if (!Var.value) { 
            return null;
        } else {
            return Var.value;
        }
    }
    function replaceTimeDate(Var)
    {
        if (!Var.value) { 
            return null;
        } else {
            return Var.value.replace("T"," ") + ":00";
        }
    }
    function replaceNullNMB(Var)
    {
        if (!Var.value) { 
            return null;
        } else {
            return Var.value;
        }
    }

    function checkNull(Var,ErrorVar)
    {
        if (!Var.value) { 
            return false;
        } else {
            return true;
        }
    }

    function refreshFlights(event)
    {
        alert("start");
        var data = new Object;
        if (checkNull(arrivalFilter))
        {
            data.arriving_at = arrivalFilter.value;
        }
        if (checkNull(departureFilter))
        {
            data.departing_from = departureFilter.value;
        }
        if (checkNull(departureBeforeFilter))
        {
            data.departure_time_earlier_than = departureBeforeFilter.value;
        }
        if (checkNull(departureAfterFilter))
        {
            data.departure_time_later_than = departureAfterFilter.value;
        }
        if (checkNull(arrivalBeforeFilter))
        {
            data.arrival_time_earlier_than = arrivalBeforeFilter.value;
        }
        if (checkNull(arrivalAfterFilter))
        {
            data.arrival_time_later_than = arrivalAfterFilter.value;
        }
        if (checkNull(remarkFilter))
        {
            data.remarks = remarkFilter.value;
        }
        else
        {
            data.remarks = "%";
        }

        const queryString = new URLSearchParams(data).toString();
        const url = `http://127.0.0.1:5000/get-flightplan?${queryString}`;
        console.log(url);
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
                console.log("Server response:", data);
                flights.splice(0, flights.length, ...data);
            })
            .catch(err => {
                console.error("Fetch error:", err);
            });
    }
</script>


<template>
    <v-card elevation="0" variant="outlined" class="FLTInfoBox">
        <v-card elevation="0" variant="outlined" class="FLTInfoBoxLayer2">
            <v-label class="Category">Flights</v-label>
            <button class="button" @click="refreshFlights">Refresh</button>
        </v-card> 
        <v-card class="listContainer">
            <div v-for="flight in flights" class="listPartContainer">
                <v-label class="listEl1" style="width: 7%;">{{ flight.departure }}</v-label>
                <v-label class="listEl2" style="width: 37%;">{{ flight.departure_time }}</v-label>
                <v-label class="listEl1" style="width: 7%;">{{ flight.arrival }}</v-label>
                <v-label class="listEl2" style="width: 24;">{{ flight.arrival_time }}</v-label>

                <v-label class="listEl1">{{ flight.alternate }}</v-label>
                <v-label class="listEl2">{{ flight.route }}</v-label>
                <v-label class="listEl1">{{ flight.altitude }}</v-label>

                <v-label class="listEl2">{{ flight.callsighn }}</v-label>
                <v-label class="listEl1">{{ flight.squawk }}</v-label>
                <v-label class="listEl2">{{ flight.type }}</v-label>
                <v-label class="listEl1">{{ flight.user }}</v-label>

                <v-label class="listEl2">{{ flight.ifr_flight }}</v-label>
                <v-label class="listEl1">{{ flight.formation_flight }}</v-label>
                <v-label class="listEl2">{{ flight.formation_elemnts}}</v-label>

                <v-label class="listEl1">{{ flight.fuel_reserve }}</v-label>
                <v-label class="listEl2">{{ flight.remarks}}</v-label>
            </div>
        </v-card>
    </v-card>
</template>

<style scoped>
    .listPartContainer {
        width: 100%;
        height: fit-content;
        display: flex;
        justify-content: space-around;
    }
    .listContainer {
        width: fit-content;
        height: fit-content;
        align-content: top;
        margin: 2%;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(200, 0, 200);
        background-color: rgb(80, 80, 100);
        overflow: scroll;
        scroll-behavior: smooth;
    }
    .listEl1 {
        width: fill;
        font-size: 50%;
        padding-left: 1%;
        padding-right: 1%;
        color: rgb(200, 100, 255);
        background-color:  rgb(100, 00, 155);;
    }
    .listEl2 {
        width: fill;
        font-size: 50%;
        padding-left: 1%;
        padding-right: 1%;
        color: rgb(100, 00, 155);
        background-color: rgb(200, 100, 255);
    }
    .button {
        font-size: 55%;
        color: rgba(0,0,0,0);
        border-radius: 10%;
        margin-left: 3%;
        float:right;
        background-image: url("../../assets/Images/Refresh.png");
        background-position: center;
        background-size: 50%;
        padding: 2%;
    }

    .input {
        color: rgb(200, 100, 255);
        border-radius: 5%;
        margin-left: 3%;
        margin-right: 3%;
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
        width: 96%;
        color:rgb(200, 0, 200);
        background-color: rgb(80, 80, 100);
    }

    .HorizontalContainer {
        margin-top: 2%;
        display: flex;
        justify-content:space-around;
        height: fit-content;
    }

    .FLTInfoBox {
        background-color: rgb(100,0,200);
        margin: 2vh;
        height:fit-content;
        margin-top: 2vh;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(200, 0, 200);
        font-size: 3vw;
        background-image: repeating-linear-gradient(45deg,rgb(60, 60, 80),rgb(80, 80, 100));
    }
</style>