<script setup>
    import {onMounted, reactive, ref} from 'vue';

    const ButtonColor = ref("rgb(200, 50, 255)");

    const Origin = ref();
    const User = ref();
    const Destination = ref();
    const Alternate = ref();
    const Route = ref();
    const Alt = ref();
    const DepTime = ref();
    const ArrTime = ref();
    const Call = ref();
    const Type = ref();
    const Squawk = ref(0);
    const IFR = ref();
    const Fuel = ref();
    const Formation = ref();
    const Formation_elements = ref();
    const Remarks = ref();

    //
    const ErrorOrigin = ref(false);
    const ErrorDestination = ref(false);
    const ErrorUsr = ref(false);
    const ErrorFormFli = ref(false);
    const ErrorIFRFli = ref(false);
    const ErrorCall = ref(false);
    const ErrorType = ref(false);

    //
    const Flight_rules_preset = reactive(['IFR-Flight','VFR-Flight']);
    const Flight_rules_true = reactive([true,false]);
    const Flight_types_preset = reactive(['Formation-Flight','Solo-Flight']);
    const Flight_types_true = reactive([true,false]);

    const apt_data = reactive({});

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

    })      

    function checkNull(Var,ErrorVar)
    {
        if (!Var.value) { 
            ButtonColor.value = "rgb(255, 0, 0)";
            ErrorVar.value = true;
            return true;
        } else {
            ErrorVar.value = false;
            return false;
        }
    }
    function stringToTrue(value,stringArr,trueArr)
    {
        var return_value = false;
        var counter = 0;
        stringArr.forEach(element => {
            if(value == element)
            {
                var nested_counter = 0;
                trueArr.forEach(element => {
                    if(counter == nested_counter)
                    {
                        return_value = element;
                    }
                    nested_counter++;
                });
            }
            counter++;
        });
        return return_value;
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
            ButtonColor.value = "rgb(255, 0, 0)";
            return null;
        } else {
            return Var.value;
        }
    }

    function checkDestination(destination,CustomError)
    {
        let exists = false;
        console.log(Object.values(apt_data));
        Object.values(apt_data).forEach(key=>{
            console.log(key);
            if (key.code == destination)
            {
                exists = true;
            }
        })
        if (exists == false)
        {
            CustomError.value = true;
            ButtonColor.value = "rgb(255, 0, 0)";
            return true;
        }
        else
        {
            CustomError.value = false;
            return false;
        }
    }

    function filePlan(event)
    {
        User.value = "Undefined";
        if (checkNull(Origin,ErrorOrigin)) {return 0;}
        if (checkNull(Destination,ErrorDestination)) {return 0;}
        if (checkNull(User,ErrorUsr)) {return 0;}
        if (checkNull(Formation,ErrorFormFli)) {return 0;}
        if (checkNull(IFR,ErrorIFRFli)) {return 0;}
        if (checkNull(Call,ErrorCall)) {return 0;}
        if (checkNull(Type,ErrorType)) {return 0;}
        if (checkDestination(Origin.value,ErrorOrigin)) {return 0;}
        if (checkDestination(Destination.value,ErrorDestination)) {return 0;}
        var data = new Object();
        data.departure = Origin.value;
        data.arrival = Destination.value;
        data.alternate = Alternate.value;
        data.route = replaceNullSTR(Route);
        data.altitude = replaceNullNMB(Alt);
        data.formation_flight = stringToTrue(Formation.value,Flight_types_preset,Flight_types_true);
        data.Formation_elements = replaceNullNMB(Formation_elements);
        data.ifr_flight = stringToTrue(IFR.value,Flight_rules_preset,Flight_rules_true);
        data.departure_time = replaceTimeDate(DepTime);
        data.arrival_time = replaceTimeDate(ArrTime);
        data.callsign = Call.value;
        data.type = Type.value;
        data.squawk = replaceNullNMB(Squawk);
        data.fuel_reserve = replaceNullNMB(Fuel);
        data.remarks = replaceNullSTR(Remarks);

        var jsonString = JSON.stringify(data);

        let response = fetch('http://127.0.0.1:5000/post-flightplan/' + User.value,{
            method: 'POST',
            mode: 'cors',
            body: jsonString,
            headers: {
                'Content-Type': 'application/json'
            }
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
                ButtonColor.value = "rgb(0, 255, 0)";
            })
            .catch(err => {
                console.error("Fetch error:", err);
                ButtonColor.value = "rgb(255, 0, 0)";
            }); 
        }
    onMounted(()=>{
        getAptData();
    })
</script>

<template>
    <v-card variant="outlined" class="FLTInfoBox">
        <div class="HorizontalContainer"> 
            <v-card variant="outlined" class="FLTInfoBoxLayer2">
                <v-label class="Category"> Origin* </v-label>
                <hr>
                <v-text-field variant="filled" :error="ErrorOrigin" name="Origin" type="text" class="input" v-model="Origin" placeholder="ETNL"/>
            </v-card>

            <v-card variant="outlined" class="FLTInfoBoxLayer2">
                <v-label class="Category"> Destination* </v-label>
                <hr>
                <v-text-field variant="filled" :error="ErrorDestination" name="Destination" type="text" class="input" v-model="Destination" placeholder="ETNW"/>
            </v-card>

            <v-card variant="outlined" class="FLTInfoBoxLayer2">
                <v-label class="Category"> Alternate </v-label>
                <hr>
                <v-text-field variant="filled" name="Alternate" type="text" class="input" v-model="Alternate" placeholder="EDDK"/>
            </v-card>
        </div>
        <v-card variant="outlined" class="FLTInfoBoxLayer2">
        <div class="HorizontalContainer"> 
            <v-label class="Category"> Route </v-label>
            <v-text-field variant="filled" name="Alternate" type="text" class="input" v-model="Route" style="margin-left: 20%;" placeholder="DIR ETNW"/>
        </div>
        <div class="HorizontalContainer"> 
            <v-label class="Category"> Alt </v-label>
            <v-text-field variant="filled" name="Alternate" type="number" class="input" v-model="Alt" style="margin-left: 25%;" placeholder="1000"/>
        </div>
        </v-card>
    </v-card>
    <v-card variant="outlined" class="FLTInfoBox">
        <div class="HorizontalContainer">
            <v-card variant="outlined" class="FLTInfoBoxLayer2">
                <v-label class="Category"> Departure Time </v-label>
                <hr>
                <v-text-field variant="filled" name="ArrTime" type="datetime-local" class="input" v-model="DepTime" placeholder="ETNL"/>
            </v-card>
            <v-card variant="outlined" class="FLTInfoBoxLayer2">
                <v-label class="Category"> Arrival Time </v-label>
                <hr>
                <v-text-field variant="filled" name="ArrTime" type="datetime-local" class="input" v-model="ArrTime" placeholder="ETNL"/>
            </v-card>
        </div>
        <div class="HorizontalContainer">
            <v-label class="Category"> Type* </v-label>
            <v-label class="Category"> Callsighn* </v-label>
        </div>
        <div class="HorizontalContainer">
            <v-text-field variant="filled" :error="ErrorType" name="Alternate" type="text" class="input" v-model="Type" style="margin-left: 1%;" placeholder="EF-2000"/>
            <v-text-field variant="filled" :error="ErrorCall" name="Alternate" type="text" class="input" v-model="Call" style="margin-left: 1%;" placeholder="Juliet 1-3"/>
        </div>
        <v-label class="Category"> Remarks </v-label>
        <v-text-field variant="filled" name="Alternate" type="text" class="input" v-model="Remarks" style="margin-left: 1%;" placeholder="no remarks"/>
    </v-card>
    <v-card variant="outlined" class="FLTInfoBox">
        <div class="HorizontalContainer">
            <v-autocomplete class="input" v-model="IFR" label="Flight rules" style="width: 50%;" :items="Flight_rules_preset"></v-autocomplete>
            <v-autocomplete class="input" v-model="Formation" label="Flight type" style="width: 50%;" :items="Flight_types_preset"></v-autocomplete>
        </div>
        <div class="HorizontalContainer">
            <v-text-field label="block-fuel" variant="filled" type="number" class="input" v-model="Fuel" style="width: 50%;" placeholder="1000"/>
            <v-text-field v-if="Formation == 'Formation-Flight'" v-model="Formation_elements" label="flight-elements" variant="filled" type="number" class="input" style="width: 50%;" placeholder="1"/>
            <v-text-field v-else disabled="true"  label="flight-elements" variant="filled" type="number" class="input" v-model="Call" style="width: 50%;" placeholder="1"/>
        </div>
        <button class="button" @click="filePlan" :style="{color: ButtonColor}"> Submit</button>
    </v-card>
</template>

<style scoped>
    
    .button {
        border-radius: 10%;
        margin-left: 3%;
        float:left;
        margin-right: 3%;
        margin-bottom: 3%;
        background-image: linear-gradient(to right, rgb(100,50,175), rgb(120,70,195));
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