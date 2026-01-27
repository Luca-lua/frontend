<script setup>
    import { ref,reactive, onMounted } from 'vue';

    const flights = reactive(["Empty"]);

    const arrivalFilter = ref();
    const departureFilter = ref();
    const departureBeforeFilter = ref();
    const departureAfterFilter = ref();
    const arrivalBeforeFilter = ref();
    const arrivalAfterFilter = ref();
    const remarkFilter = ref();
    
    function editEntry(id)
    {
        console.log(id)
    }
    function boolToString(boolean,truestring,falsestring)
    {
        if(boolean == 1)
        {
            return truestring
        }
        else
        {
            return falsestring
        }
    }

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
            data.departure_time_earlier_than = replaceTimeDate(departureBeforeFilter);
        }
        if (checkNull(departureAfterFilter))
        {
            data.departure_time_later_than = replaceTimeDate(departureAfterFilter);
        }
        if (checkNull(arrivalBeforeFilter))
        {
            data.arrival_time_earlier_than = replaceTimeDate(arrivalBeforeFilter);
        }
        if (checkNull(arrivalAfterFilter))
        {
            data.arrival_time_later_than = replaceTimeDate(arrivalAfterFilter);
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
                console.log("Server response:", data);
                flights.splice(0, flights.length, ...data);
            })
            .catch(err => {
                console.error("Fetch error:", err);
            });
    }
    onMounted(()=>{
        refreshFlights();
    })
</script>


<template>
    <v-card elevation="0" variant="outlined" class="FLTInfoBox">
        <v-card elevation="0" variant="outlined" class="FLTInfoBoxLayer2">
            <v-label class="Category">HL ATC overview </v-label>
            <button class="button" @click="refreshFlights">Refresh</button>
        </v-card> 
        <div class="HorizontalContainer">
            <v-text-field v-model="departureFilter" autocomplete="off" label="Departure Airport" variant="filled" type="text" class="input" placeholder=""/>
            <v-card style="border-left: 2px solid rgb(200, 0, 200); height: 100%; width: 5px;"></v-card>
            <v-text-field v-model="arrivalFilter" autocomplete="off" label="Arrival Airport" variant="filled" type="text" class="input" placeholder=""/>
            <v-card style="border-left: 2px solid rgb(200, 0, 200); height: 100%; width: 5px;"></v-card>
            <v-text-field v-model="remarkFilter" autocomplete="off" label="Remarks" variant="filled" type="text" class="input" placeholder=""/>
        </div>
        <div class="HorizontalContainer">
            <v-text-field v-model="departureAfterFilter" autocomplete="off" label="Departure min" variant="filled" type="datetime-local" class="input2" placeholder=""/>
            <v-card style="border-left: 2px solid rgb(200, 0, 200); height: 100%; width: 10px;"></v-card>
            <v-text-field v-model="departureBeforeFilter" autocomplete="off" label="Departure max" variant="filled" type="datetime-local" class="input2" placeholder=""/>
            <v-card style="border-left: 2px solid rgb(200, 0, 200); height: 100%; width: 10px;"></v-card>
            <v-text-field v-model="arrivalAfterFilter" autocomplete="off" label="Arrival min" variant="filled" type="datetime-local" class="input2" placeholder=""/>
            <v-card style="border-left: 2px solid rgb(200, 0, 200); height: 100%; width: 10px;"></v-card>
            <v-text-field v-model="arrivalBeforeFilter" autocomplete="off" label="Arrival min" variant="filled" type="datetime-local" class="input2" placeholder=""/>
        </div>
        <v-table hover="true" class="table">
            <thead>
                <tr class="listCategories">
                    <th>Id</th>
                    <th>Departure</th>
                    <th>Departure Time</th>
                    <th>Arrival</th>
                    <th>Arrival Time</th>
                    <th>Alternate</th>
                    <th>Route</th>
                    <th>Altitude</th>
                    <th>Callsighn</th>
                    <th>Type</th>
                    <th>IFR-Flight</th>
                    <th>Formation-flight</th>
                    <th>Formation-elements</th>
                    <th>Block-fuel</th>
                    <th>Remarks</th>
                    <th>status</th>
                    <th>edit</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="flight in flights" :key="flight.id">
                    <td class="listEl2">{{ flight.id }}</td>
                    <td class="listEl1">{{ flight.departure }}</td>
                    <td class="listEl2">{{ flight.departure_time }}</td>
                    <td class="listEl1">{{ flight.arrival }}</td>
                    <td class="listEl2">{{ flight.arrival_time }}</td>
                    <td class="listEl1">{{ flight.alternate }}</td>
                    <td class="listEl2">{{ flight.route }}</td>
                    <td class="listEl1">{{ flight.altitude }}</td>
                    <td class="listEl2">{{ flight.callsign }}</td>
                    <td class="listEl1">{{ flight.type }}</td>
                    <td class="listEl2">{{ boolToString(flight.ifr_flight,"IFR","VFR") }}</td>
                    <td class="listEl1">{{ boolToString(flight.formation_flight,"Formation flight","Solo flight") }}</td>
                    <td class="listEl2">{{ flight.formation_elements }}</td>
                    <td class="listEl1">{{ flight.fuel_reserve }}</td>
                    <td class="listEl2">{{ flight.remarks }}</td>
                    <td class="listEl1">{{ flight.status }}</td>
                    <button v-on:click="editEntry(flight.id)" class="editButton">Edit</button>
                </tr>
            </tbody>
        </v-table>
    </v-card>
</template>

<style scoped>
    .table {
        background: transparent;
        border-collapse: collapse;
        border: 1px solid black;
        margin-bottom: 2%;
    }
    .listCategories {
        background-color: rgba(110,55,250,0.75);
        outline: 2px solid black;
    }
    .listEl1 {
        width: max-content;
        white-space: nowrap;
        height: min-content;
        font-size: 100%;
        padding-left: 1%;
        background-color: transparent;
        padding-right: 1%;
        color: rgb(200, 100, 255);
    }
    .listEl2 {
        width: max-content;
        white-space: nowrap;
        height: min-content;
        font-size: 100%;
        padding-left: 1%;
        background-color: transparent;
        padding-right: 1%;
        color: rgb(150, 80, 255);
    }
    .editButton {
        background-color: rgb(100,100,155);
        padding: 15%;
        display: flex;
        vertical-align:middle;
        border-radius: 15%;
        font-size: 125%;
        color: rgb(30,25,75);
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
    }
    .input2 {
        color: rgb(255, 30, 205);
        border-radius: 5%;
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
        font-size: 120%;
        margin-left: 0%;
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
        background-color: rgb(100,0,255);
        margin: 0vh;
        height:fit-content;
        margin-top: 2vh;
        padding-left: 2%;
        padding-right: 2%;
        color:rgb(100, 0, 255);
        font-size: 3vw;
        background-image: repeating-linear-gradient(45deg,rgb(60, 60, 80),rgb(80, 80, 100));
    }
</style>