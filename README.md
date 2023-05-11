# RubyKaigi Vonage API Demo

This application demonstrates using Vonage's [Voice](https://developer.vonage.com/en/voice/voice-api/overview) and [Messages](https://developer.vonage.com/en/messages/overview) APIs using Vonage's [Ruby SDK](https://github.com/vonage/vonage-ruby-sdk).

To run this demo you will require a Vonage Developer account ([free sign-up](https://developer.vonage.com/sign-up)).

For the Voice funtionality, you will also need a Vonage number with Voice capability enabled.

To run the demo:

1. Clone the repo: `git clone https://github.com/Vonage-Community/demo-messages_voice-ruby_sinatra-rubykaigi.git`

2. Create a Vonage Application in the Dashboard, and enable it for **Voice** and **Messages** capabilities. This will create an Application ID and also generate a private key. Copy or move the private key to the root directory of the demo application.

3. Copy or rename `.env.dist` to `.env` and add your Application ID for the Vonage Application you ceated as `VONAGE_APP_ID`and the Voice-enabled number as `VONAGE_FROM_NUMBER`.

4. Run `bundle install`

5. Run `bundle exec ruby app.rb`

6. Navigate to http://localhost:4567/
