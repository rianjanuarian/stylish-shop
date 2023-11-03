const { OAuth2Client } = require('google-auth-library');
const CLIENT_ID = 'YOUR_CLIENT_ID';
const client = new OAuth2Client(CLIENT_ID);

const verifyGoogleOAuthToken = async (token) => {
  try {
    const ticket = await client.verifyIdToken({
      idToken: token,
      audience: CLIENT_ID,
    });
    const payload = ticket.getPayload();
    return payload;
  } catch (error) {
    throw error;
  }
}

module.exports = verifyGoogleOAuthToken;
