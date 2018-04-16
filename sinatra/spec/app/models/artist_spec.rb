require 'spec_helper'
require_relative '../../../app/models/artist'

describe Artist do
  describe '#to_json' do
    it 'serialized the artist to JSON' do
      artist = Artist.new(id: '1234', name: 'Meshuggah')
      expect(artist.to_json).to eq('{"id":"1234","name":"Meshuggah"}')
    end

    it 'works when the artist is part of an array' do
      artists = [
        Artist.new(id: '1234', name: 'Meshuggah'),
        Artist.new(id: '2345', name: 'Charlie Daniels'),
      ]
      expect(JSON.parse(JSON.dump(artists))).to eq([
        { 'id' => '1234', 'name' => 'Meshuggah' },
        { 'id' => '2345', 'name' => 'Charlie Daniels' },
      ])
    end
  end
end
