require 'loga'
require 'sinatra'
require 'sinatra/namespace'

require_relative 'repos/artist'

Loga.configure(
  filter_parameters: [:password],
  format: STDOUT.isatty ? :simple : :gelf,
  service_name: 'the-app',
  tags: [:uuid],
)

class App < Sinatra::Base
  register Sinatra::Namespace
  set :logging, false # suppress Sinatra request logger
  # disable :show_exceptions

  namespace '/artists' do
    get '/' do
      content_type :json
      # Loga.logger.info(Loga::Event.new(message: 'hello', data: { power_level: 9001 }))
      ArtistRepo.all.to_json
    end

    get '/:id' do
      artist = ArtistRepo.get_by_id(params.id)
      artist.to_json
    end

    post '/' do
      artist = Artist.new(name: params[:name])
      artist.id = ArtistRepo.create(artist)
      redirect "/artists/#{artist.id}"
    end
  end
end
