$.get('http://httpbin.org/delay/5', function(){

  console.log('first thing is done, so let\'s do these two at the same time:');

  $.when(
    ipServiceRequest(),
    userAgentServiceRequest()
    ).done(function(ipResult, userAgentResult){
      console.log(
        "IP Result:", ipResult[0]["origin"],
        "User Agent Result:", userAgentResult[0]["user-agent"]
      );
    });

});

var ipServiceRequest = function() {
  return $.get('http://httpbin.org/ip', function(){
  });
};

var userAgentServiceRequest = function() {
  return $.get('http://httpbin.org/user-agent', function(){
  });
};
