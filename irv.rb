require 'cgi'
require 'open-uri'

class Irv < Sinatra::Application
  get '/' do
    'IRV!'
  end
end
