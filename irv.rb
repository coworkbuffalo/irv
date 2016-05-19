require 'cgi'
require 'open-uri'
require 'json'

class Irv < Sinatra::Application
  enable :logging, :dump_errors, :raise_errors

  get '/' do
    'IRV!'
  end

  # status:
  # info
  # lock_id:
  # 8944080
  # object_type:
  # User
  # user_id:
  # 9444
  # message_key:
  # Locks/access
  # place_id:
  # 8944081
  # object_id:
  # 9444
  # id:
  # 2454295
  # actor_type:
  # User
  # integration_id:
  # 170
  # action:
  # access
  # text_message:
  # Mike  Macaluso (mike@coworkbuffalo.com) accessed lock CoworkBuffalo Door 2.0
  # message:
  # Mike  Macaluso (mike@coworkbuffalo.com) accessed lock CoworkBuffalo Door 2.0
  # group_id:
  # 8944078
  # email:
  # mike@coworkbuffalo.com
  # actor_id:
  # 9444
  post '/kisi' do
    payload = JSON.parse(request.body.read)
    RestClient.post ENV['SLACK_URL'], {
      text: payload['message']
    }.to_json, content_type: :json, accept: :json
  end
end
