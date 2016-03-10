require 'sinatra'
require 'twilio-ruby'

post '/receive_sms' do
  content_type 'text/xml'
  message  = params[:Body].downcase
  reply    = if message.scan(/refuel/).length > 0 || message.scan(/petrol/).length > 0
    "Hello Josh, you vehicle MB890 will requires 77l costing $83. The refuel will take place at 30 Boronia St, 2016 Redfern in between 4pm to 5pm. Please second ‘YES’ to order the refuel."
  else
    "Hi Josh, your car has been refuelled. Have a good journey."
  end

  response = Twilio::TwiML::Response.new do |r|
    r.Message(reply)
  end

  response.to_xml
end

# @AudiCompanion: Please refuel my car today.
#
# Hello Josh, you vehicle MB890 will requires 77l costing $83. The refuel will take place at 30 Boronia St, 2016 Redfern in between 4pm to 5pm. Please second ‘YES’ to order the refuel.
#
# @AudiCompanion: YES
#
# Upon completion
# Hi Josh, your car has been refuelled. Have a good journey.
