let axios = require('axios');
let moment = require('moment-timezone');

//let today = moment().format("MM/DD/YYYY");

//test day
let today = '09/18/2018'

//school day type test api endpoint
let daytype = 'https://s3-us-west-2.amazonaws.com/bova-schedule-thing/hs_bell_schedule.json';

console.log(today);

function getTodayFromApi(today) {
    return axios.get('https://sheetsu.com/apis/v1.0su/d7ecffa210eb')
  .then(function (response) {
    // handle success
    let todayData = response.data;
    let dayType 
     todayData.forEach((day) =>{
        if(day.Date == today) {
            dayType = day.Schedule;
        }
        
    })
    return dayType;
    
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
}

function getScheduleFromApi(schooldayType) {
    console.log(schooldayType)
    return axios.get('https://s3-us-west-2.amazonaws.com/bova-schedule-thing/hs_bell_schedule.json')
  .then(function (response) {
      
      let rType = response.data;
      let typeReturned;
      rType.forEach((t) => {
          
          if (t[''] == schooldayType){
              typeReturned = t;
          }
      })
    // handle success
     return typeReturned;
  })
  .catch(function (error) {
    // handle error
    console.log(error);
  })
}

function dataTransform(sampleData){

    let objKeys  = Object.keys(sampleData);
    let newArray = [];
    
    objKeys.forEach((o) => {
        newArray.push({ 'Day': o + ' - '+ sampleData[o] });
    })
    
    
    return newArray;
}

exports.handler = async (event) => {
    
    let schooldayType = await getTodayFromApi(today)
    let daySchedule = await getScheduleFromApi(schooldayType)
    let transformedReturn = dataTransform(daySchedule)
    
    // TODO implement
    return transformedReturn;
};