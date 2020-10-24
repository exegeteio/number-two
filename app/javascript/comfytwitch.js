async function checkForTwitchToken() {
  return await checkTwitchTokenLocalStorage() || await checkTwitchTokenURL();
}

async function checkTwitchTokenURL() {
  try {
      const params = new URLSearchParams( location.hash.replace( "#", "" ) );
      const accessToken = params.get( "access_token" );
      if( accessToken ) {
          let result = await validateTwitchToken( accessToken );
          if( result && result.login ) {
              // Save into localStorage
              localStorage.setItem( "twitchToken", accessToken );
              // Replace current URL
              const url = window.location.href.split( "#" )[ 0 ];
              window.location.replace( url );
              result.token = accessToken;
              return result;
          }
      }
  }
  catch( err ) {
      return null;
  }
}

async function checkTwitchTokenLocalStorage() {
  try {
      // Check local storage
      let accessToken = localStorage.getItem( "twitchToken" );
      if( accessToken ) {
          let result = await validateTwitchToken( accessToken );
          if( result && result.login ) {
              result.token = accessToken;
              return result;
          }
      }
  }
  catch( err ) {
      return null;
  }
}

async function validateTwitchToken( token ) {
  return await fetch( "https://id.twitch.tv/oauth2/validate", {
      headers: {
          Authorization: `OAuth ${token}`
      }
  } )
  .then( r => r.json() )
  .catch( error => {
      // Auth Failed
      return {
          error: error
      };
  });
}

let comfyTwitchAuth = {
  UserId: 0,
  User: "",
  ClientID: "",
  Token: "",
  Scopes: [],
  Logout: function () {
      localStorage.removeItem( "twitchToken" );
  },
  Login: function ( clientId, redirectURI, scopes = [ "user:read:email" ] ) {
      window.location.href = `https://id.twitch.tv/oauth2/authorize?client_id=${clientId}&redirect_uri=${redirectURI}&response_type=token&scope=${scopes.join( " " )}`;
  },
  Check: async function( redirectURI ) {
      let result = await checkForTwitchToken();
      if( result ) {
          comfyTwitchAuth.ClientID = result.client_id;
          comfyTwitchAuth.UserId = result.user_id;
          comfyTwitchAuth.User = result.login;
          comfyTwitchAuth.Token = result.token;
          comfyTwitchAuth.Scopes = result.scopes;
      }
      else {
          comfyTwitchAuth.Logout();
          if( redirectURI ) {
              window.location.href = redirectURI;
          }
      }
      return result;
  },
  GetUser: async function( clientId, userId ) {
      return await fetch( `https://api.twitch.tv/helix/users?id=${userId}`, {
          headers: {
              "Client-ID": clientId,
              "Authorization": `Bearer ${comfyTwitchAuth.Token}`,
          }
      } )
      .then( r => r.json() )
      .then( r => {
          if( r[ "data" ].length > 0 ) {
              return r[ "data" ][ 0 ];
          }
          return {};
      })
      .catch( error => {
          // Auth Failed
          return {
              error: error
          };
      });
  },
};

window.ComfyTwitch = comfyTwitchAuth;