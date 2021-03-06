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

  # app=secure-woodland-9775&user=example%40example.com&url=http%3A%2F%2Fsecure-woodland-9775.herokuapp.com&head=4f20bdd&head_long=4f20bdd&prev_head=&git_log=%20%20*%20Michael%20Friis%3A%20add%20bar&release=v7
  post '/heroku' do
    notify ENV['SLACK_URL']
    notify ENV['OTHER_SLACK_URL']
  end

  def notify(url)
    RestClient.post url, {
      username: 'irv',
      icon_url: 'https://raw.githubusercontent.com/coworkbuffalo/irv/master/irv.jpg',
      text: "#{params['user']} deployed #{params['release']} / <https://github.com/qrush/mxdesk/commit/#{params['head']}|#{params['head']}> of <#{params['url']}|#{params['app']}>: #{params['git_log']}",
      channel: '#mxdesk'
    }.to_json, content_type: :json, accept: :json
  end
end
