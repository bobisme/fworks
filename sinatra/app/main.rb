require 'loga'
require 'sinatra'

Loga.configure(
  filter_parameters: [:password],
  format: STDOUT.isatty ? :simple : :gelf,
  service_name: 'the-app',
  tags: [:uuid],
)

class App < Sinatra::Base
  set :logging, false # suppress Sinatra request logger

  get '/' do
    Loga.logger.info(Loga::Event.new(message: 'hello', data: { power_level: 9001 }))
    'Hello World!'
  end
end
