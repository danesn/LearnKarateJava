function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    apiUrl: 'https://conduit-api.bondaracademy.com/api/'
  }

  // Environment
  if (env == 'dev') {
    config.userEmail = 'bonkai@bonk.com';
    config.userPassword = 'bonkaibonkai998';
  }
  if (env == 'qa') {
    config.userEmail = 'bonkai2@bonk.com';
    config.userPassword = 'bonkaibonkai999';
  }

  var accessToken = karate.callSingle('classpath:helpers/CreateToken.feature', config).authToken
  karate.configure('headers',
    {
      Authorization: 'Token ' + accessToken
    }
  )
  
  return config;
}