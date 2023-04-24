# app.rb

require "sinatra"
require "tilt/erubis"
require "vonage"
require "dotenv/load"
require "yaml"

DATA = YAML.load_file("data.yml")

get "/" do
  erb :index
end

post "/" do
  mode = params[:mode]

  begin
    if mode == "sms"
      send_sms(params)
    elsif mode == "voice"
      make_voice_call(params)
    end
    @status_message = { class: "flash-success", text: "Message sent successfully/送信に成功しました" }
  rescue Vonage::Error => e
    @status_message = {class: "flash-error", text: "Sorry, there was a problem/問題が発生しました"}
  end

  erb :index
end

def send_sms(params)
  to_number = params[:number]
  language = params[:language]
  topic = params[:topic]
  data = DATA[language][topic]

  client = Vonage::Client.new(application_id: ENV["VONAGE_APP_ID"], private_key: ENV["VONAGE_PRIVATE_KEY"])

  message = Vonage::Messaging::Message.sms(message: data)

  client.messaging.send(to: to_number, from: "Vonage", **message)
end

def make_voice_call(params)
  to_number = params[:number]
  language = params[:language]
  topic = params[:topic]
  data = DATA[language][topic]

  client = Vonage::Client.new(application_id: ENV["VONAGE_APP_ID"], private_key: ENV["VONAGE_PRIVATE_KEY"])

  ncco = {action: "talk", text: data}
  ncco.merge!(language: "ja-JP", style: 2) if language == 'jp'

  client.voice.create(
    to: [{ type: "phone", number: to_number }],
    from: {type: "phone", number: ENV["VONAGE_FROM_NUMBER"]},
    ncco: [ncco]
  )
end
