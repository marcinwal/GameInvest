console.log("Marcin and Richard");



  
// $('#temperature').text(thermostat.temperature);
// $('#temperature').attr('class',thermostat.consoleColor());
// $('#power-text').attr('class',thermostat.consoleColor());
// if (thermostat.savingMode)
// {
//   $('.PWS-mode').text('power mode: on');
// }else
// {
//   $('.PWS-mode').text('power mode: off');
// }

// };

$(document).ready(function(){

  google.load('visualization', '1', {packages:['table'], callback: drawTable});
  

  // $('.increase-temp').on('click', function(){
  //     thermostat.up();
  //     updateTemperature();
  // });

  // $('.decrease-temp').on('click', function(){
  //     thermostat.down();
  //     updateTemperature();
  // });

  // $('.reset').on('click', function(){
  //   thermostat.reset();
  //   updateTemperature();
  // });

  // $('.PWS-mode').on('click',function(){
  //   thermostat.changeSaveMode();
  //   updateTemperature();
  // });
});



