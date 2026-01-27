
<script setup>
    const props = defineProps({
        user: Text
    })
</script>


<template>
   <div class="">


   </div> 
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