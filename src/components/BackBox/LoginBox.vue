
<script setup>
import {ref} from 'vue';
    const show_login = ref(false);
    const username = ref("");
    const password = ref("");
    const active_user =ref("");

    const emit = defineEmits(['permission','user'])

    function returnPermissions(permissionValue) {
        emit('permission',permissionValue)
    }
    function returnUser(userValue)
    {
        emit('user',userValue)
    }

    const buttoncolor = ref("rgb(200,0,200)");
    function login() {
        let url = `http://127.0.0.1:5000/get-loginvalidation?username=${username.value}&password=${password.value}`

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
                if(data.login == "correct")
                {
                    buttoncolor.value = "rgb(100,200,100)";
                    active_user.value = username.value
                    
                    returnPermissions(data.permission)
                    returnUser(active_user.value)
                }
                else
                {
                    buttoncolor.value = "rgb(255,0,100)";
                }
            })
            .catch(err => {
                console.error("Fetch error:", err);
            }); 
    }
    const props = defineProps({
        LoginHeader: Text
    })
</script>


<template>
    <div class="background-clickable" v-show="!show_login" v-on:click="show_login=true">
        <img src=""class="CenterLock" v-on:click="show_login=true">
    </div>
    <div class="background-clickable" v-show="show_login" v-on:click="show_login=false">
        <v-card variant="outlined" class="loginBackground" v-on:click.stop>
            <label>{{ LoginHeader }}</label>
            <v-text-field class="input" label="Username" variant="filled" v-model="username" type="text" autocomplete="off" placeholder="myUser"/>
            <v-text-field class="input" label="Password" variant="filled" v-model="password" type="password" autocomplete="off" placeholder="myPassword"/>
            <button style="width: 50%;margin-left: 25%;" v-on:click="login()" :style="{color: buttoncolor}" class="input">Login</button>
        </v-card>
    </div>
</template>


<style scoped>
    .input {
        background-color: rgb(150,50,150,0.1);
        color: rgb(200, 0, 200);
        border-radius: 5%;
        margin: 3%;
        text-align: center;
        width: 94%;
    }
    label {
        color: rgb(100,140,165);
        font-size: 300%;
        margin-left: 5%;
        margin-top: 3%;
    }
    .loginBackground {
        display: grid;
        color: rgb(200, 0, 200);
        background-color: rgba(150, 150, 180, 0.1);
        grid-template-rows: auto auto auto auto;
        border-radius: 5%;
        width: 40vw;
    }
    .horizontal {
        vertical-align:top;
    }
    .background-clickable {
        display: flex;
        justify-content: center;
        align-items: center;
        padding: 15%;
        color: rgba(100,100,100,0.2);
        width: 100%;
        height: 80vh;
        background-color: rgba(100,100,100,0.2);
        transition: 
            background-color 1s;
    }
    .background-clickable:hover{
        background-color: rgba(120,120,140,0.3);
    }
    .CenterLock {
        background-color: rgba(100,100,140,0.4);
        width: 25%;
        height: 25%;
    }
</style>